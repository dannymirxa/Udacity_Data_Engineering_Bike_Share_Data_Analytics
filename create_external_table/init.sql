-- DROP DATABASE divvy_project
CREATE DATABASE divvy_project;
USE divvy_project;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = ''
-- CREATE DATABASE SCOPED CREDENTIAL WorkspaceIdentity WITH IDENTITY = 'Managed Identity'
-- Must fix SECRET
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    -- Remove ? from the beginning of the SAS token
    SECRET =''

-- CREATE LOGIN sqladminuser WITH PASSWORD = ''
CREATE USER Test FOR LOGIN sqladminuser
GRANT REFERENCES ON DATABASE SCOPED CREDENTIAL::AzureStorageCredential TO Test

-- DROP EXTERNAL DATA SOURCE AzureStorage
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'AzureStorage')
    CREATE EXTERNAL DATA SOURCE AzureStorage with (
        LOCATION ='wasbs://divvycontainer@divvystorageaccount.blob.core.windows.net',
        CREDENTIAL = AzureStorageCredential
    );
GO

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat')
    CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat]
    WITH ( FORMAT_TYPE = Parquet)
GO

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'TextFileFormat')
    CREATE EXTERNAL FILE FORMAT TextFileFormat
    WITH    (  FORMAT_TYPE = DELIMITEDTEXT ,
                FORMAT_OPTIONS (
                    FIELD_TERMINATOR = ',',
                    STRING_DELIMITER = '"',
                    USE_TYPE_DEFAULT = FALSE
            )
)
GO


CREATE EXTERNAL FILE FORMAT [TextFileFormat_WithHeader]
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,      -- <— skip the header line
        ENCODING = 'UTF8',
        USE_TYPE_DEFAULT = TRUE
    )
);
