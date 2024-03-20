import os
import sys
import argparse
import requests
from googledrivedownloader import GoogleDriveDownloader as gdd

def createFolder(name):

  return 


import pickle 
import os.path 
import io 
import shutil 
from mimetypes import MimeTypes 
from googleapiclient.discovery import build 
from google_auth_oauthlib.flow import InstalledAppFlow 
from google.auth.transport.requests import Request 
from googleapiclient.http import MediaIoBaseDownload, MediaFileUpload 
  
class DriveAPI: 
  global SCOPES 
    
  # Define the scopes 
  SCOPES = ['https://www.googleapis.com/auth/drive'] 

  def __init__(self): 
      
      # Variable self.creds will 
      # store the user access token. 
      # If no valid token found 
      # we will create one. 
      self.creds = None

      # The file token.pickle stores the 
      # user's access and refresh tokens. It is 
      # created automatically when the authorization 
      # flow completes for the first time. 

      # Check if file token.pickle exists 
      if os.path.exists('token.pickle'): 

          # Read the token from the file and 
          # store it in the variable self.creds 
          with open('token.pickle', 'rb') as token: 
              self.creds = pickle.load(token) 

      # If no valid credentials are available, 
      # request the user to log in. 
      if not self.creds or not self.creds.valid: 

          # If token is expired, it will be refreshed, 
          # else, we will request a new one. 
          if self.creds and self.creds.expired and self.creds.refresh_token: 
              self.creds.refresh(Request()) 
          else: 
              flow = InstalledAppFlow.from_client_secrets_file( 
                  'credentials.json', SCOPES) 
              self.creds = flow.run_local_server(port=0) 

          # Save the access token in token.pickle 
          # file for future usage 
          with open('token.pickle', 'wb') as token: 
              pickle.dump(self.creds, token) 

      # Connect to the API service 
      self.service = build('drive', 'v3', credentials=self.creds) 

      # request a list of first N files or 
      # folders with name and id from the API. 
      results = self.service.files().list( 
          pageSize=100, fields="files(id, name)").execute() 
      items = results.get('files', []) 

      # print a list of files 

      print("Here's a list of files: \n") 
      print(*items, sep="\n", end="\n\n") 

  def FileDownload(self, file_id, file_name): 
      request = self.service.files().get_media(fileId=file_id) 
      fh = io.BytesIO() 
        
      # Initialise a downloader object to download the file 
      downloader = MediaIoBaseDownload(fh, request, chunksize=204800) 
      done = False

      try: 
          # Download the data in chunks 
          while not done: 
              status, done = downloader.next_chunk() 

          fh.seek(0) 
            
          # Write the received data to the file 
          with open(file_name, 'wb') as f: 
              shutil.copyfileobj(fh, f) 

          print("File Downloaded") 
          # Return True if file Downloaded successfully 
          return True
      except: 
          
          # Return False if something went wrong 
          print("Something went wrong.") 
          return False


if __name__ == "__main__":
  # Process 1:
  #1. Download google drive folder with excels
  #2. Convert every file to csv
  #3. Process CSV

  #Process 2:
  #1. Download files as csv

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