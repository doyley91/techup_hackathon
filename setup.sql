-- =====================================================
-- Snowflake Setup Worksheet - Internal Stage Creation
-- =====================================================

USE ROLE SYSADMIN;
USE DATABASE MY_DEMOS_DB;
USE SCHEMA TECHUP_HACKATHON_FSI;

-- =====================================================
-- CREATE INTERNAL STAGE
-- =====================================================
-- Create an internal stage called "reports" for storing report files
CREATE OR REPLACE STAGE reports
COMMENT = 'Internal stage for storing report files and documents';CREATE OR REPLACE STAGE reports
    DIRECTORY = ( ENABLE = true ) 
    ENCRYPTION = ( TYPE = 'SNOWFLAKE_SSE' )
    COMMENT = 'Internal stage for storing report files and documents';

-- Show stage details
DESCRIBE STAGE reports;

-- List files in the stage (will be empty initially)
LIST @reports;

-- =====================================================
-- USAGE EXAMPLES
-- =====================================================
-- To upload files to this stage, you can use:
-- PUT file://path/to/local/file.csv @reports;

-- To download files from this stage, you can use:
-- GET @reports/file.csv file://path/to/local/directory/;

-- To copy data from stage to table:
-- COPY INTO your_table FROM @reports/file.csv;

-- To remove files from stage:
-- REMOVE @reports/file.csv; 