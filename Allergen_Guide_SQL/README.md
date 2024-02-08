Processes Needed:
1. Creation of csv files from google drive foler excels 
2. Comparison function for csv in folder and csv newly created 
      - Returns lines that have mismatch
3. Movement of csv files to folder (while potentially deleting old file)
4. Creating new data table from allergen guide
5. Updating data table from allergen guide if changed

# Current Process for SQL Refresh
# 1. Have a SQL table that houses current restaurants
# 2. Have a method to pull excel sheets (as csvs) to folder every Sunday at 2AM to refresh data if unexpectedly changed
# 3. Have a SQL script to refresh the data in the database

# Current Process for SQL Create Table from new allergen guide
# 1. Convert excel sheet to csv (1)
# 2. Move allergen guide to folder (2)
# 3. Create new SQL tables for allergen guide by reading csv file