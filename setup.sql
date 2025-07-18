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
    DIRECTORY = ( ENABLE = true ) 
    ENCRYPTION = ( TYPE = 'SNOWFLAKE_SSE' )
    COMMENT = 'Internal stage for storing report files and documents';

-- Create an internal stage called "Annual Filings" for storing annual filing documents
CREATE OR REPLACE STAGE "Annual Filings"
    DIRECTORY = ( ENABLE = true ) 
    ENCRYPTION = ( TYPE = 'SNOWFLAKE_SSE' )
    COMMENT = 'Internal stage for storing annual filing documents and reports';

-- Show stage details
DESCRIBE STAGE reports;
DESCRIBE STAGE "Annual Filings";

-- List files in the stages (will be empty initially)
LIST @reports;
LIST @"Annual Filings";

-- =====================================================
-- USAGE EXAMPLES
-- =====================================================
-- To upload files to the reports stage, you can use:
-- PUT file://path/to/local/file.csv @reports;

-- To upload files to the Annual Filings stage, you can use:
-- PUT file://path/to/local/annual_report.pdf @"Annual Filings";

-- To download files from stages, you can use:
-- GET @reports/file.csv file://path/to/local/directory/;
-- GET @"Annual Filings"/annual_report.pdf file://path/to/local/directory/;

-- To copy data from stage to table:
-- COPY INTO your_table FROM @reports/file.csv;
-- COPY INTO your_table FROM @"Annual Filings"/annual_report.csv;

-- To remove files from stages:
-- REMOVE @reports/file.csv;
-- REMOVE @"Annual Filings"/annual_report.pdf; 