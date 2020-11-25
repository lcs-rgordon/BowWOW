import Cocoa
import SwiftyJSON // Library to make parsing difficult JSON easier

var originalJSON = """
{
   "message":{
      "affenpinscher":[
         
      ],
      "african":[
         
      ],
      "airedale":[
         
      ],
      "akita":[
         
      ],
      "appenzeller":[
         
      ],
      "australian":[
         "shepherd"
      ],
      "basenji":[
         
      ],
      "beagle":[
         
      ],
      "bluetick":[
         
      ],
      "borzoi":[
         
      ],
      "bouvier":[
         
      ],
      "boxer":[
         
      ],
      "brabancon":[
         
      ],
      "briard":[
         
      ],
      "buhund":[
         "norwegian"
      ],
      "bulldog":[
         "boston",
         "english",
         "french"
      ],
      "bullterrier":[
         "staffordshire"
      ],
      "cairn":[
         
      ],
      "cattledog":[
         "australian"
      ],
      "chihuahua":[
         
      ],
      "chow":[
         
      ],
      "clumber":[
         
      ],
      "cockapoo":[
         
      ],
      "collie":[
         "border"
      ],
      "coonhound":[
         
      ],
      "corgi":[
         "cardigan"
      ],
      "cotondetulear":[
         
      ],
      "dachshund":[
         
      ],
      "dalmatian":[
         
      ],
      "dane":[
         "great"
      ],
      "deerhound":[
         "scottish"
      ],
      "dhole":[
         
      ],
      "dingo":[
         
      ],
      "doberman":[
         
      ],
      "elkhound":[
         "norwegian"
      ],
      "entlebucher":[
         
      ],
      "eskimo":[
         
      ],
      "finnish":[
         "lapphund"
      ],
      "frise":[
         "bichon"
      ],
      "germanshepherd":[
         
      ],
      "greyhound":[
         "italian"
      ],
      "groenendael":[
         
      ],
      "havanese":[
         
      ],
      "hound":[
         "afghan",
         "basset",
         "blood",
         "english",
         "ibizan",
         "plott",
         "walker"
      ],
      "husky":[
         
      ],
      "keeshond":[
         
      ],
      "kelpie":[
         
      ],
      "komondor":[
         
      ],
      "kuvasz":[
         
      ],
      "labrador":[
         
      ],
      "leonberg":[
         
      ],
      "lhasa":[
         
      ],
      "malamute":[
         
      ],
      "malinois":[
         
      ],
      "maltese":[
         
      ],
      "mastiff":[
         "bull",
         "english",
         "tibetan"
      ],
      "mexicanhairless":[
         
      ],
      "mix":[
         
      ],
      "mountain":[
         "bernese",
         "swiss"
      ],
      "newfoundland":[
         
      ],
      "otterhound":[
         
      ],
      "ovcharka":[
         "caucasian"
      ],
      "papillon":[
         
      ],
      "pekinese":[
         
      ],
      "pembroke":[
         
      ],
      "pinscher":[
         "miniature"
      ],
      "pitbull":[
         
      ],
      "pointer":[
         "german",
         "germanlonghair"
      ],
      "pomeranian":[
         
      ],
      "poodle":[
         "miniature",
         "standard",
         "toy"
      ],
      "pug":[
         
      ],
      "puggle":[
         
      ],
      "pyrenees":[
         
      ],
      "redbone":[
         
      ],
      "retriever":[
         "chesapeake",
         "curly",
         "flatcoated",
         "golden"
      ],
      "ridgeback":[
         "rhodesian"
      ],
      "rottweiler":[
         
      ],
      "saluki":[
         
      ],
      "samoyed":[
         
      ],
      "schipperke":[
         
      ],
      "schnauzer":[
         "giant",
         "miniature"
      ],
      "setter":[
         "english",
         "gordon",
         "irish"
      ],
      "sheepdog":[
         "english",
         "shetland"
      ],
      "shiba":[
         
      ],
      "shihtzu":[
         
      ],
      "spaniel":[
         "blenheim",
         "brittany",
         "cocker",
         "irish",
         "japanese",
         "sussex",
         "welsh"
      ],
      "springer":[
         "english"
      ],
      "stbernard":[
         
      ],
      "terrier":[
         "american",
         "australian",
         "bedlington",
         "border",
         "dandie",
         "fox",
         "irish",
         "kerryblue",
         "lakeland",
         "norfolk",
         "norwich",
         "patterdale",
         "russell",
         "scottish",
         "sealyham",
         "silky",
         "tibetan",
         "toy",
         "westhighland",
         "wheaten",
         "yorkshire"
      ],
      "vizsla":[
         
      ],
      "waterdog":[
         "spanish"
      ],
      "weimaraner":[
         
      ],
      "whippet":[
         
      ],
      "wolfhound":[
         "irish"
      ]
   },
   "status":"success"
}
"""

print("original JSON")
print(originalJSON)

let jsonData = Data(originalJSON.utf8)

let json = JSON(jsonData)

print("from SwiftyJSON")
print(json["message"])

var rawBreedList: [String : JSON] = json["message"].dictionaryValue
var breeds = [String : [String]]()
breeds.count

print("====")

for (key, value) in rawBreedList {
    
    print("key is \(key)")
    print("value is \(value)")
    
//    breeds[key] = value.arrayValue.map {$0.stringValue}
    breeds[key] = value.arrayValue.map { item in
        item.stringValue
    }
}

for (key, value) in breeds {
    print("key is \(key)")
    print("value is \(value)")
}


var sortedBreeds = breeds.sorted(by: {
    $0.key < $1.key
})

print("%%%%%")

for (key, value) in sortedBreeds {
    print("key is \(key)")
    print("value is \(value)")
}

print("===== final list =====")

//for (mainBreed, value) in sortedBreeds {
//    if value.isEmpty {
//        print(mainBreed)
//    } else {
//        for subBreed in value {
//            print("\(mainBreed)/\(subBreed)")
//        }
//    }
//}

for (mainBreed, value) in sortedBreeds {
    if value.isEmpty {
        print("\(mainBreed)\t\(mainBreed.capitalized)")
    } else {
        for subBreed in value {
            print("\(mainBreed)/\(subBreed)\t\(subBreed.capitalized) \(mainBreed.capitalized)")
        }
    }
}
