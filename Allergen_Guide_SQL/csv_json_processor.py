import csv

def read_csv(file_path):
    data = []
    with open(file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data


if __name__ == "__main__":
  print(read_csv("/Users/christopheradolphe/Desktop/SafeBite/Allergen_Guide_SQL/grizzlygrillguide.csv"))