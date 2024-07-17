import os

def rename_images(root_dir):
    # Walk through each subdirectory in the root directory
    for subdir, _, files in os.walk(root_dir):
        restaurant_name = os.path.basename(subdir).lower().replace(" ", "")
        
        for file in files:
            # Get the item name from the original filename
            item_name, _ = os.path.splitext(file)
            if restaurant_name in item_name:
              continue
            # Remove whitespace from item name
            item_name = item_name.lower().replace(" ", "")
            # Construct the new filename
            new_filename = f"{restaurant_name}_{item_name}.jpg"
            # Get full file paths
            old_file_path = os.path.join(subdir, file)
            new_file_path = os.path.join(subdir, new_filename)
            
            # Rename the file
            os.rename(old_file_path, new_file_path)
            print(f"Renamed: {old_file_path} to {new_file_path}")

# Define the root directory containing the restaurant subdirectories
root_directory = '/Users/christopheradolphe/Desktop/MenuItemImages'

# Call the function to rename the images
rename_images(root_directory)