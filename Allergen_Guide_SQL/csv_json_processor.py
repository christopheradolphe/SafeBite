import csv
import json

def read_csv(file_path):
  #Input: Filepath to csv file
  #Output: List of dicts mapping column names to data in column 
    data = []
    with open(file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data

class AllergenInfo:
  def __init__(self, gluten, wheat, soy, shellfish, fish, dairy, egg, treeNuts, peanuts, 
  sesame, mustard, garlic, sulfites, onion, mushroom, corn, oliveOil, legumes):
    self.gluten = gluten
    self.wheat = wheat
    self.soy = soy
    self.shellfish = shellfish
    self.fish = fish
    self.dairy = dairy
    self.egg = egg
    self.treeNuts = treeNuts
    self.peanuts = peanuts
    self.sesame = sesame
    self.mustard = mustard
    self.garlic = garlic
    self.sulfites = sulfites
    self.onion = onion
    self.mushroom = mushroom
    self.corn = corn
    self.oliveOil = oliveOil
    self.legumes = legumes
  
  def to_dict(self):
    return {
      'gluten': self.gluten,
      'wheat': self.wheat,
      'soy': self.soy,
      'shellfish': self.shellfish,
      'fish': self.fish,
      'dairy': self.dairy,
      'egg': self.egg,
      'treeNuts': self.treeNuts,
      'peanuts': self.peanuts,
      'sesame': self.sesame,
      'mustard': self.mustard,
      'garlic': self.garlic,
      'sulfites': self.sulfites,
      'onion': self.onion,
      'mushroom': self.mushroom,
      'corn': self.corn,
      'oliveOil': self.oliveOil,
      'legumes': self.legumes
    }

class DietaryRestrictionInfo:
  def __init__(self, vegan, vegetarian, halal, keto, lowCarb, lowFODMAP, dashDiet):
    self.vegan = vegan
    self.vegetarian = vegetarian
    self.halal = halal
    self.keto = keto
    self.lowCarb = lowCarb
    self.lowFODMAP = lowFODMAP
    self.dashDiet = dashDiet
  
  def to_dict(self):
    return {
      'vegan': self.vegan,
      'vegetarian': self.vegetarian,
      'halal': self.halal,
      'keto': self.keto,
      'lowCarb': self.lowCarb,
      'lowFODMAP': self.lowFODMAP,
      'dashDiet': self.dashDiet
    }

class MenuItem:
  def __init__(self, name, itemType, description, allergenInfo, dietaryRestrictionInfo):
    self.name = name
    self.itemType = itemType
    self.description = description
    self.allergenInfo = allergenInfo
    self.dietaryRestrictionInfo = dietaryRestrictionInfo
  
  def to_dict(self):
    return {
      'name': self.name,
      'itemType': self.itemType,
      'description': self.description,
      'allergenInfo': self.allergenInfo.to_dict(),
      'dietaryRestrictionInfo': self.dietaryRestrictionInfo.to_dict()
    }

def process_csv_data(csv_data):
    objects = []
    for row in csv_data:
        obj = MenuItem(row['name'], row['itemType'], row['descritpion'] if 'description' in row.keys() else "", 
              AllergenInfo(int(row['gluten']) if 'gluten' in row.keys() else -1,
                           int(row['wheat']) if 'wheat' in row.keys() else -1, 
                           int(row['soy']) if 'soy' in row.keys() else -1, 
                           int(row['shellfish']) if 'shellfish' in row.keys() else -1, 
                           int(row['fish']) if 'fish' in row.keys() else -1, 
                           int(row['dairy']) if 'dairy' in row.keys() else -1, 
                           int(row['eggs']) if 'eggs' in row.keys() else -1,
                           int(row['treeNuts']) if 'treeNuts' in row.keys() else -1, 
                           int(row['peanuts']) if 'peanuts' in row.keys() else -1, 
                           int(row['sesame']) if 'sesame' in row.keys() else -1, 
                           int(row['mustard']) if 'mustard' in row.keys() else -1, 
                           int(row['garlic']) if 'garlic' in row.keys() else -1, 
                           int(row['sulfites']) if 'sulfites' in row.keys() else -1,
                           int(row['onion']) if 'onion' in row.keys() else -1, 
                           int(row['mushroom']) if 'mushroom' in row.keys() else -1,
                           int(row['corn']) if 'corn' in row.keys() else -1, 
                           int(row['oliveOil']) if 'oliveOil' in row.keys() else -1, 
                           int(row['legumes']) if 'legumes' in row.keys() else -1),
              DietaryRestrictionInfo(int(row['vegan']) if 'vegan' in row.keys() else -1, 
                                     int(row['vegetarian']) if 'vegetarian' in row.keys() else -1, 
                                     int(row['halal']) if 'halal' in row.keys() else -1, 
                                     int(row['keto']) if 'keto' in row.keys() else -1, 
                                     int(row['lowCarb']) if 'lowCarb' in row.keys() else -1, 
                                     int(row['lowFODMAP']) if 'lowFODMAP' in row.keys() else -1, 
                                     int(row['dashDiet']) if 'dashDiet' in row.keys() else -1)
              )
        objects.append(obj)
    return objects

def export_to_json(objects, json_file):
    json_data = [obj.to_dict() for obj in objects]
    with open(json_file, 'w') as f:
        json.dump(json_data, f, indent=4)

def main(csv_file, json_file):
  csv_data = read_csv(csv_file)
  objects = process_csv_data(csv_data)
  export_to_json(objects, json_file)

if __name__ == "__main__":
  main('Allergen_Guide_SQL/grizzlygrillguide.csv', 'output.json')