import csv

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

class DietaryRestrictionInfo:
  def __init__(self, vegan, vegetarian, halal, keto, lowCarb, lowFODMAP, dashDiet):
    self.vegan = vegan
    self.vegetarian = vegetarian
    self.halal = halal
    self.keto = keto
    self.lowCarb = lowCarb
    self.lowFODMAP = lowFODMAP
    self.dashDiet = dashDiet

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
      'allergenInfo': self.allergenInfo,
      'dietaryRestrictionInfo': self.dietaryRestrictionInfo
    }


if __name__ == "__main__":
  print(read_csv("/Users/christopheradolphe/Desktop/SafeBite/Allergen_Guide_SQL/grizzlygrillguide.csv"))