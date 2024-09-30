import kopf
import kubernetes.client
from kubernetes.client.rest import ApiException
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Define the handler for the creation of AppConfig custom resources
@kopf.on.create('mycompany.com', 'v1', 'appconfigs')
def create_fn(spec, name, namespace, **kwargs):
    app_name = spec.get('appName', 'defaultapp').lower()  # Ensure container name is lowercase
    replicas = spec.get('replicas', 1)

    # Define the Deployment object
    deployment = {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {"name": name, "namespace": namespace},
        "spec": {
            "replicas": replicas,
            "selector": {"matchLabels": {"app": name}},
            "template": {
                "metadata": {"labels": {"app": name}},
                "spec": {
                    "containers": [
                        {"name": app_name, "image": "nginx"}
                    ]
                },
            },
        },
    }

    # Create the Deployment in the specified namespace
    api = kubernetes.client.AppsV1Api()
    try:
        api.create_namespaced_deployment(namespace=namespace, body=deployment)
        logger.info(f"Deployment '{name}' created with {replicas} replicas for app '{app_name}'")
        return {'message': f"Deployment '{name}' created with {replicas} replicas for app '{app_name}'"}
    except ApiException as e:
        logger.error(f"Failed to create Deployment '{name}': {e}")
        raise kopf.PermanentError(f"Failed to create Deployment '{name}': {e}")

# Define the handler for update events
@kopf.on.update('mycompany.com', 'v1', 'appconfigs')
def update_fn(spec, name, namespace, **kwargs):
    app_name = spec.get('appName', 'defaultapp').lower()
    replicas = spec.get('replicas', 1)

    # Patch the Deployment with new values
    deployment_patch = {
        "spec": {
            "replicas": replicas
        }
    }

    api = kubernetes.client.AppsV1Api()
    try:
        api.patch_namespaced_deployment(name=name, namespace=namespace, body=deployment_patch)
        logger.info(f"Deployment '{name}' updated to {replicas} replicas")
        return {'message': f"Deployment '{name}' updated to {replicas} replicas"}
    except ApiException as e:
        logger.error(f"Failed to update Deployment '{name}': {e}")
        raise kopf.PermanentError(f"Failed to update Deployment '{name}': {e}")

# Define the handler for deletion events
@kopf.on.delete('mycompany.com', 'v1', 'appconfigs')
def delete_fn(name, namespace, **kwargs):
    api = kubernetes.client.AppsV1Api()
    try:
        api.delete_namespaced_deployment(name=name, namespace=namespace)
        logger.info(f"Deployment '{name}' deleted")
    except ApiException as e:
        # If the Deployment is already deleted, ignore the error
        if e.status == 404:
            logger.warning(f"Deployment '{name}' not found for deletion")
        else:
            logger.error(f"Failed to delete Deployment '{name}': {e}")
            raise kopf.PermanentError(f"Failed to delete Deployment '{name}': {e}")
