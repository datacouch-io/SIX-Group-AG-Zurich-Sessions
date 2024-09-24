# inspect_tags.py
from metaflow import Flow


def inspect_tagging_flow():
    # Fetch the latest run of the TaggingFlow
    run = Flow('TaggingFlow').latest_run

    # Print the run ID and tags associated with the entire run
    print(f"Run ID: {run.id}")
    print(f"Run Tags: {run.tags}")

    # Iterate through each step in the flow and print the step name
    for step in run:
        print(f"Step: {step.id}")
        print(f"Step Tags: {step.tags}")


if __name__ == '__main__':
    inspect_tagging_flow()
