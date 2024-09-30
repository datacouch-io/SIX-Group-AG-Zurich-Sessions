**Lab 1: Setting Up the Development Environment for Data Analytics**

This hands-on lab walks participants through the initial setup required for a functional data analytics environment. Participants will configure service pods, establish database connections, and gain access to storage interfaces. This foundation is essential for executing data analysis tasks in subsequent labs and involves tools such as the terminal, DBeaver for database management, and Minio for object storage.

### Lab Structure:

#### Step 1: Navigate to Setup Location

-   **Open your terminal**  and enter the following command to navigate to the setup directory:

	```
	cd /home/training/sixgroups_latest/sixgroups/setup`     
	```
#### Step 2: Execute Setup Script

-   **Run the setup script**  to start deploying necessary services by executing:

    ```
    ./setup.sh
    ```


#### Step 3: Verify Service Deployment

-   **Check the status of the service deployment**; it may take 1-2 minutes for all pods to reach a running/ready status. Use:

	   ```
	   ./check_status.sh
	```
	![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd_NI-UoneG1mt9AYxFVD7Vlz4PZTUEQ31onMAbuBCSmYzCARhQG4TMivVdasRBZ_-M3mKUW8edjIfLj9mmyEHLYrDN_D8eIuqhKKcn3x_B_-LwcdVekdjTVsfuMTIf6wzCBnQJYOkRF9On2raAxNbSlBF7?key=njBU8V-sJrzAcYBhXD7zzA)
#### Step 4: Launch DBeaver

-   **Start the DBeaver application**  for managing databases by simply running:

    ```
    dbeaver
    ```


#### Step 5: Refresh Trino Engine Connection in DBeaver

-   **Refresh the connection to the Trino engine**  in DBeaver by right-clicking on 'localhost' and selecting 'Refresh'.
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfv_QWSRSSJs0QLE7PoG-RAnt3PrU_ABY-c7pbxMLw94-8RnBEipJjd2phw7af_wJz-QNnxPujf4GzcOZXrAt0dkM2x09_4JmVah1uN4Hwmtrvu3_JBCN8bVxqpAAsY_EJgbc7VafjZTIGpjXR6Wh7ppita?key=njBU8V-sJrzAcYBhXD7zzA)

#### Step 6: Verify Available Catalogs in DBeaver

-   **Check the available data catalogs**  in DBeaver by clicking on 'localhost'.
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc8ZR67qC_QxprctndeqUsSmhdqZ7woDpMOoEGJB5cP6bF33TK783Hqml3qXheuiLfKH1JLFUY7lSn8iQozjhKF6BjfKNxZ1DanAypmFqx3ONwsSxvx8C69fVITPqrCx4YBt-NhsuGv8SE8OGNuvRixMmN3?key=njBU8V-sJrzAcYBhXD7zzA)

#### Step 7: Set Up Port Forwarding for Minio

-   **Open a new terminal**  and set up port forwarding to access the Minio console by running:

    ```cd /home/training/sixgroups_latest/sixgroups/setup
    ./port-forwarding.sh
    ```


#### Step 8: Log into Minio Console

-   **Access the Minio console**  by opening a browser and typing  `localhost:9090`. Log in using the username  `minio`and the password  `minio123`.
![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcq6o-nekSb7GbWTsOOkcH0i7GeZRF81xAvynipx9eAzg1318E53k_ttD58Jj_lbvVaodo5fguOBSvY04H9bxvwt3PBbgOHaLfOQc_RXI2Qzi1YaFQ5f7Ipjv80ipPctw5Q-2u0m7p2MoygMUSfeidAC69w?key=njBU8V-sJrzAcYBhXD7zzA)
