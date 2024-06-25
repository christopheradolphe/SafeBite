//
//  Allergens.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-15.
//

import Foundation

struct Allergens: Codable {
    var gluten = false {
        didSet {
            if gluten {
                allergenList.insert("gluten")
            } else {
                allergenList.remove("gluten")
            }
        }
    }
    
    var wheat = false {
        didSet {
            if wheat {
                allergenList.insert("wheat")
            } else {
                allergenList.remove("wheat")
            }
        }
    }
    
    var soy = false {
        didSet {
            if soy {
                allergenList.insert("soy")
            } else {
                allergenList.remove("soy")
            }
        }
    }
    
    var shellfish = false {
        didSet {
            if shellfish {
                allergenList.insert("shellfish")
            } else {
                allergenList.remove("shellfish")
            }
        }
    }
    
    var fish = false {
        didSet {
            if fish {
                allergenList.insert("fish")
            } else {
                allergenList.remove("fish")
            }
        }
    }
    
    var dairy = false {
        didSet {
            if dairy {
                allergenList.insert("dairy")
            } else {
                allergenList.remove("dairy")
            }
        }
    }
    
    var egg = false {
        didSet {
            if egg {
                allergenList.insert("egg")
            } else {
                allergenList.remove("egg")
            }
        }
    }
    
    var treeNuts = false {
        didSet {
            if treeNuts {
                allergenList.insert("treeNuts")
            } else {
                allergenList.remove("treeNuts")
            }
        }
    }
    
    var peanuts = false {
        didSet {
            if peanuts {
                allergenList.insert("peanuts")
            } else {
                allergenList.remove("peanuts")
            }
        }
    }
    
    var sesame = false {
        didSet {
            if sesame {
                allergenList.insert("sesame")
            } else {
                allergenList.remove("sesame")
            }
        }
    }
    
    var mustard = false {
        didSet {
            if mustard {
                allergenList.insert("mustard")
            } else {
                allergenList.remove("mustard")
            }
        }
    }
    
    var garlic = false {
        didSet {
            if garlic {
                allergenList.insert("garlic")
            } else {
                allergenList.remove("garlic")
            }
        }
    }
    
    var sulfites = false {
        didSet {
            if sulfites {
                allergenList.insert("sulfites")
            } else {
                allergenList.remove("sulfites")
            }
        }
    }
    
    var allergenList = Set<String>()
}

struct DietaryRestrictions: Codable {
    var vegan = false {
        didSet {
            if vegan {
                dietaryRestrictionList.insert("vegan")
            } else {
                dietaryRestrictionList.remove("vegan")
            }
        }
    }
    
    var vegetarian = false {
        didSet {
            if vegetarian {
                dietaryRestrictionList.insert("soy")
            } else {
                dietaryRestrictionList.remove("soy")
            }
        }
    }
    
    var halal = false  {
        didSet {
            if halal {
                dietaryRestrictionList.insert("halal")
            } else {
                dietaryRestrictionList.remove("halal")
            }
        }
    }
    
    var keto = false {
        didSet {
            if keto {
                dietaryRestrictionList.insert("keto")
            } else {
                dietaryRestrictionList.remove("keto")
            }
        }
    }
    
    var lowCarb = false {
        didSet {
            if lowCarb {
                dietaryRestrictionList.insert("lowCarb")
            } else {
                dietaryRestrictionList.remove("lowCarb")
            }
        }
    }
    
    var lowFODMAP = false {
        didSet {
            if lowFODMAP {
                dietaryRestrictionList.insert("lowFODMAP")
            } else {
                dietaryRestrictionList.remove("lowFODMAP")
            }
        }
    }
    
    var dashDiet = false {
        didSet {
            if dashDiet {
                dietaryRestrictionList.insert("dashDiet")
            } else {
                dietaryRestrictionList.remove("dashDiet")
            }
        }
    }
    
    var dietaryRestrictionList = Set<String>()
}
