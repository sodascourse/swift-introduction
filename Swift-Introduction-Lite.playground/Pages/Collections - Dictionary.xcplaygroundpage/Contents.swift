/*:

 # Collections

 Swift provides three primary collection types, known as arrays, sets, and dictionaries,
 for storing collections of values.

 - Arrays are **ordered** collections of values.
 - Sets are **unordered** collections of **unique values**.
 - Dictionaries are **unordered** collections of **key-value associations**.

 Arrays, sets, and dictionaries in Swift are always clear about
 the types of values and keys that they can store.

 This means that you cannot insert a value of the wrong type into a collection
 by mistake. It also means you can be confident about the type of values you
 will retrieve from a collection.

 If you create an array, a set, or a dictionary, and assign it to a variable,
 the collection that is created will be mutable. You can change the collection
 by adding, removing, or changing items in the collection.

 If you assign an array, a set, or a dictionary to a constant,
 that collection is immutable, and its size and contents cannot be changed.

 */
/*:

 ## Dictionaries
 
 A dictionary stores associations between **keys** of the same type and 
 **values** of the same type in a collection with no defined ordering. 
 Each value is associated with a unique key, which acts as an identifier for
 that value within the dictionary.
 
 Unlike items in an array, items in a dictionary do not have a specified order.
 You use a dictionary when you need to look up values based on their identifier,
 in much the same way that a real-world dictionary is used to look up the 
 definition for a particular word.
 
 ### Dictionary Creation
 
 Dictionary could be created by using Dictionary's initializers or with the 
 dictionary literals.
 
 A _key-value pair_ is a combination of a key and a value. In a dictionary literal,
 the key and value in each key-value pair are separated by **a colon** (`:`).
 The key-value pairs are written as _a list_, separated by commas (`,`), 
 surrounded by a pair of square brackets.

 */
var airports = ["TPE": "Taipei Taoyuan", "HND": "Tokyo Haneda", "NRT": "Tokyo Narita"]
let emptyStringIntPairDictionary = Dictionary<String, Int>()
let emptyStringFloatPairDictionary = [String: Float]()
let emptyStringBoolPairDictionary: [String: Bool] = [:]

/*:
 
 ### Dictionary Type
 
 The type of a Swift dictionary is written in full as `Dictionary<Key, Value>`,
 where `Key` is the type of value that can be used as a dictionary key,
 and `Value` is the type of value that the dictionary stores for those keys.
 
 You can also write the type of a dictionary in shorthand form as `[Key: Value]`.
 Although the two forms are functionally identical, the shorthand form is preferred
 and is used throughout this guide when referring to the type of a dictionary.
 
 */
var fruitsColors: Dictionary<String, String> = [
    "apple": "red",
    "banana": "yellow",
    "orange": "orange",
]
let numberNames: [Int: [String]] = [
    1: ["One", "ichi", "いち"],
    2: ["Two", "ni", "に"],
    4: ["Four", "yon", "よん"],
    7: ["Seven", "nana", "なな"],
    8: ["Eight", "hachi", "はち"],
]

/*:
 
 ### Dictionary and Operators
 
 - We use bracket operator (`[]`) to access the content of a dictionary
   by a given key.

 */
let colorOfApple = fruitsColors["apple"]!
let colorOfWatermelon = fruitsColors["watermelon"]
// Try to use "option+click" to see the type of above two constants.

fruitsColors["grape"] = "purple"
fruitsColors
fruitsColors["grape"] = nil
fruitsColors["watermelon"] = nil
fruitsColors
//numberNames[3] = ["Three", "san", "さん"]
// Try to uncomment the above line to see what Xcode yields

/*:

 ### Properties and Methods of Dictionaries

 */
emptyStringIntPairDictionary.isEmpty
numberNames.count
let numbers = Array(numberNames.keys)
let colors = Set(fruitsColors.values)

/*:
 
 ### Dictionaries and Control flows
 
 The `for-in` loop is great to enumerate key-value pairs in a dictionary.

 */
for (fruit, color) in fruitsColors {
    "\(fruit) is \(color)."
}

for fruit in fruitsColors.keys {
    fruit
}

for color in fruitsColors.values {
    color
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
