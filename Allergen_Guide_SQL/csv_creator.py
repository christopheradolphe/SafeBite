import os
import sys
import argparse

if __name__ == "__main__":
  # Inputs: 
  # 1. Name of excel spreadsheet in google drive
  # 2. Output folder to house csv files to be put into 
  # Outputs: 
  # 1. Error saying that file may not exist
  # 2. Success error message (file added to folder)

  parser = argparse.ArgumentParser()
  parser.add_argument(
      "--allergenGuide",
      type=str,
      required=True,
      help="The name of the file containing the allergen guide to be converted to csv."
  )
  parser.add_argument(
      "--outputFolder",
      type=str,
      required=True,
      help="Folder to put the newly created csv file. Folder on local machine."
  )
  
  args = parser.parse_args()