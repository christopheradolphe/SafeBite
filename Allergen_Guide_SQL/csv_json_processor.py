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
        obj = MenuItem(row['name'], row['itemType'], row['descritpion'], 
              AllergenInfo(row['gluten'], row['wheat'], row['soy'], row['shellfish'], row['fish'], row['dairy'], row['eggs'],
              row['treeNuts'], row['peanuts'], row['sesame'], row['mustard'], row['garlic'], row['sulfites'], row['mushroom'],
              row['corn'], row['oliveOil'], row['legumes']),
              DietaryRestrictionInfo(row['vegan'], row['vegetarian'], row['halal'], row['keto'], row['lowCarb'], row['lowFODMAP'], row['dashDiet'])
              )
        objects.append(obj)
    return objects

def export_to_json(objects, json_file):
    json_data = [obj.to_dict() for obj in objects]
    with open(json_file, 'w') as f:
        json.dump(json_data, f, indent=4)

if __name__ == "__main__":
  print(read_csv("/Users/christopheradolphe/Desktop/SafeBite/Allergen_Guide_SQL/grizzlygrillguide.csv"))