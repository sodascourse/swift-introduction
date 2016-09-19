//: # Collection Data Types
//:
//: ![](swift-collections.png)
//:
//: Swift provides three primary collection types, known as arrays, sets, and dictionaries. Arrays are ordered 
//: collections of values. Sets are unordered collections of _unique_ values. Dictionaries are unordered collections of 
//: key-value associations.
//:
//: Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store. 
//: They are implemented as **generic collections**. This means that you cannot insert a value of the wrong type into a 
//: collection by mistake. It also means you can be confident about the type of values you will retrieve from a 
//: collection.
//:

//:
//: ## Mutability
//:
//: Collections in Swift are **value types**, which is actually implemented by `Structure`. So if you declare them as
//: constant (i.e. using `let`), they would become immutable.
//:
//: It is good practice to create immutable collections in all cases where the collection does not need to change. 
//: Doing so enables the Swift compiler to optimize the performance of the collections you create. (and keep 
//: thread-safe)
//:

let numberArray1 = [1, 2, 3]
//numberArray1.append(2)  // ERROR: Uncomment this line to see which error message you get.

//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Array
//:
//: An array could be created via an array literal, which is values separated by commas (`,`) and wrapped by a bracket
//: (`[]`)
//:

[1, 2, 3]  // An array with 3 integers

//: 
//: The type of a Swift array is written in full as `Array<Element>`, where `Element` is the type of values the array is
//: allowed to store (generic type). You can also write the type of an array in shorthand form as `[Element]`.
//:
//: NOTE: The shorthand form is preferred and recommended by Apple.
//:

let stringArray1: Array<String> = ["Hello", "World"]
let stringArray2: [String] = ["Hello", "World"]
let emptyArray: [Int] = []

//:
//: ### Array content
//:

stringArray1.isEmpty
stringArray1.count

var fruitArray: [String] = []
fruitArray.append("Apple")
fruitArray.append("Banana")
fruitArray += ["Orange", "Grape", "ラーメン", "Meat Ball"]
fruitArray.insert("Pineapple", at: 2)


let indexOfRāmen = fruitArray.index(of: "ラーメン")!
let rāmenString = fruitArray.remove(at: indexOfRāmen)
let meatBallString = fruitArray.removeLast()
fruitArray

fruitArray[0]
fruitArray[0...2]
fruitArray[0..<2]

//:
//: In Swift `...` and `..<` are **Range operators**, `...` is `closed range operator`, which includes both start and 
//: end, and `..<` is called `half-open range operator`, which includes start but does not include end.
//:

for fruit in fruitArray {
    print(fruit)
}

for (index, fruit) in fruitArray.enumerated() {
    print("The fruit at index \(index) is \"\(fruit)\"")
}

//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Set
//:
//: The type of a Swift set is written as `Set<Element>`, where `Element` is the type that the set is allowed to store. 
//: Unlike arrays, sets do not have an equivalent shorthand form.
//:
//: A `set` could be created by an array literal too, but you have to specify the type first
//:

let numberSet1 = Set<Int>()
let numberSet2: Set<Int> = [1, 2, 2, 3, 5]  // NOTE: There's only one `2` in generated set.
let emptySet: Set<Int> = []

//:
//: ### Set content
//:

var primeNumberSet: Set<Int> = [17, 2, 3, 19, 7, 11, 13, 15, 1, 5]  // Oops, `15` is not a prime. Let's remove it later

primeNumberSet.remove(15)
primeNumberSet.insert(23)
primeNumberSet.contains(29)
primeNumberSet.isEmpty
primeNumberSet.count

let sortedPrimeNumbers = primeNumberSet.sorted()
for primeNumber in primeNumberSet {
    print(primeNumber)
}

//:
//: NOTE: The `sort` method only available when the `Element` of `Set` conforms to `Comparable` protocol.
//:       (This is an future topic we would mention in later classes)
//:
//: ---
//:
//: ### Set operations
//:
//: ![](set-venn-diagram.png)
//:

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits)
oddDigits.intersection(evenDigits)
oddDigits.subtracting(singleDigitPrimeNumbers)
oddDigits.symmetricDifference(singleDigitPrimeNumbers)

//:
//: ![](set-euler-diagram.png)
//:

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: houseAnimals)
farmAnimals.isDisjoint(with: cityAnimals)

//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Dictionary
//:
//: Each `value` in a _dictionary_ is associated with `a unique key`, which acts as an identifier for that value within
//: the dictionary. Unlike items in an array, items in a dictionary do not have a specified order. You use a dictionary 
//: when you need to look up values based on their identifier, in much the same way that a real-world dictionary is 
//: used to look up the definition for a particular word.
//:
//: A dictionary could be created by a dictionary literal. A key-value pair is annotated by _colon_ (`:`) like
//: `key: value`, and each key-value pairs is separated by _commas_ (`,`). The whole literal is wrapped by a _bracket_ 
//: (`[]`). Note, Swift also uses **bracket** for dictionary literals, unlike most programming languages which
//: use _curly braces_ (`{}`) for dictionaries
//:

["Peter": "peter@nccu.edu.tw", "Mike": "mike@nccu.edu.tw"]

//: 
//: The type of a dictionary is written in full as `Dictionary<Key, Value>`, where Key is the type of value that can be 
//: used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.
//:
//: You can also write the type of a dictionary in shorthand form as `[Key: Value]`. Like _Array_, the shorthand form 
//: is preferred and recommended by Apple.
//:

var namesOfIntegers: [Int: String] = [1: "One", 2: "Two", 3: "Three"]
let emptyDictionary: [String: String] = [:]

//: 
//: ### Dictionary content
//:

var airports: [String: String] = [
    "SFO": "San Francisco",
    "LAX": "Los Angeles",
    "JFK": "New York Kennedy",
    "LHR": "London Heathrow",
    "TPE": "Taoyuan",
    "TSA": "Taipei Songshan",
    "HND": "Tokyo Int'l",
    "NRT": "Tokyo Narita",
    "KIX": "Kansai",
    "ICN": "Seoul Incheon",
    "SIN": "Singapore",
    "HKG": "Hong Kong",
    "NCC": "NCCU",  // This is not a real airport, ... delete it later
]

airports.count
airports.isEmpty

let 関西国際空港 = airports["KIX"]!
airports["SEA"] = "Seattle"  // Insert
airports["TPE"] = "Taipei Taoyuan"  // Replace
let 東京国際空港 = airports.updateValue("Tokyo Haneda", forKey: "HND")
airports["NCC"] = nil  // Delete
airports["NCC"] == nil  // Existence

for iataCode in airports.keys {
    print(iataCode)
}

for airportName in airports.values {
    print(airportName)
}

for (iataCode, airportName) in airports {  // Like `dict.items()` in Python
    print("The name of \(iataCode) airport is \"\(airportName)\"")
}

//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Generics
//:
//: Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to 
//: requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, 
//: abstracted manner.
//:
//: Swift also uses _angle brackets_ (`<>`) to specify generic types like:
//:

let strArray = Array<String>()

//: In Swift, you can also use _conlon_ (`:`) to specify the generic type must conform to some protocols or inherit
//: from some classes. Like the declaration of Set, it requires `Element` must conform to `Hashable` protocol since 
//: sets are actually hash tables.

let strSet = Set<String>()

struct MyType {}
//let myTypeSet = Set<MyType>()  // ERROR: Uncomment to see what happened.

//: NOTE: "_command+click_" on the `Set` to see its definition

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
