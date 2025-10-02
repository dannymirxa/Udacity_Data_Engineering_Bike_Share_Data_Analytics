# Bike Share Data Warehouse Project

## Task 1 — Create your Azure resources

- Create an Azure Database for PostgreSQL.
- Create an Azure Synapse workspace. Note that if you've previously created a Synapse Workspace, you do not need to create a second one specifically for the project.
- Use the built-in serverless SQL pool and database within the Synapse workspace.
- In the cloud lab Azure environment, you will only be able to use the built-in serverless SQL Pool.

<img src="Task_01 Create your Azure resources.png" width="400">

## Task 2 — Design a star schema

You are being provided a relational schema that describes the data as it exists in PostgreSQL. In addition, you have been given a set of business requirements related to the data warehouse. You are being asked to design a star schema using fact and dimension tables.

<img src="Task_02 Design a star schema.png" width="400">

## Task 3 — Create the data in PostgreSQL

To prepare your environment for this project, you first must create the data in PostgreSQL. This will simulate the production environment where the data is being used in the OLTP system. This can be done using the Python script provided for you in GitHub: ProjectDataToPostgres.py

<img src="Task_03 Create the data in PostgreSQL.png" width="400">

## Task 4 — EXTRACT the data from PostgreSQL

In your Azure Synapse workspace, use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.

<img src="Task_04 EXTRACT the data from PostgreSQL.png" width="400">

## Task 5 — LOAD the data into external tables in the data warehouse

Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. From here, you can use the script-generating function to load the data from blob storage into external staging tables in the data warehouse you created using the serverless SQL Pool.

<img src="Task_05_1 LOAD the data into external tables in the data warehouse.png" width="400">

<img src="Task_05_2 LOAD the data into external tables in the data warehouse.png" width="400">

## Task 6 — TRANSFORM the data to the star schema using CETAS

Write SQL scripts to transform the data from the staging tables to the final star schema you designed.

The serverless SQL pool won't allow you to create persistent tables in the database, as it has no local storage. So, use CREATE EXTERNAL TABLE AS SELECT (CETAS) instead. CETAS is a parallel operation that creates external table metadata and exports the SELECT query results to a set of files in your storage account.

<img src="Task_06_1 TRANSFORM the data to the star schema using CETAS.png" width="400">

<img src="Task_06_2 TRANSFORM the data to the star schema using CETAS.png" width="400">