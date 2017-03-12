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
 
 ## Arrays
 
 An array stores values of _the same type_ in **an ordered list**.
 The same value can appear in an array multiple times at different positions.
 
 ### Array creation
 
 Arrays could be created by using Array's initializers or with the array literals.
 
 An array literal is written as a list of values, separated by commas, 
 surrounded by a pair of square brackets.

 */
let names = ["Peter", "Annie", "Matt", "Spencer", "Alvin"]
let zeros = Array(repeating: 0, count: 10)
var emptyStringArray = [String]()
var emptyDoubleArray = Array<Double>()

/*:
 
 ### Array Type
 
 The type of a Swift array is written in full as `Array<Element>`, 
 where `Element` is the type of values the array is allowed to store.
 
 You can also write the type of an array in shorthand form as `[Element]`.
 The shorthand form is preferred and is used throughout this guide 
 when referring to the type of an array.

 */
let fruits: Array<String> = ["apple", "banana", "orange"]
let numbers: [Int] = [1, 2, 3, 4, 5]

/*:
 
 ### Array and Operators
 
 - Arrays could be joined by `+` operator.
 - We use bracket operator (`[]`) to access the content of an array
   by a given index or a range.

 */
var japaneseFoods = ["寿司", "カツ丼", "うどん"]
let taiwaneseFoods = ["大腸麵線", "蚵仔煎", "珍珠奶茶", "小籠湯包"]
let asianFoods = japaneseFoods + taiwaneseFoods
let 烏龍麵 = asianFoods[2]
//japaneseFoods[3]  
// Try to uncomment the above line to see what Xcode yields
let noodles = asianFoods[2..<4]

/*:
 
 ### Properties and Methods of Arrays
 
 */
asianFoods.isEmpty
japaneseFoods.count
let sushi = japaneseFoods.first
let doubleOptionalValue = emptyDoubleArray.last
// Try to use "option+click" to see the type of above two constants.

japaneseFoods.append("牛丼")
japaneseFoods.insert("Rib eye steak", at: 2)
//taiwaneseFoods.append("魯肉飯")
// Try to uncomment the above line to see what Xcode yields

let indexOf肉骨茶 = japaneseFoods.index(of: "肉骨茶")
let indexOfRibEyeSteak = japaneseFoods.index(of: "Rib eye steak")!
// Try to use "option+click" to see the type of above two constants.
//let indexOfPhở = japaneseFoods.index(of: "Phở")!
// Try to uncomment the above line to see what Xcode yields

japaneseFoods.remove(at: indexOfRibEyeSteak)
japaneseFoods
if let indexOfBurrito = japaneseFoods.index(of: "Burrito") {
    japaneseFoods.remove(at: indexOfBurrito)
}
//japaneseFoods.remove(at: indexOf肉骨茶)
// Try to uncomment the above line to see what Xcode yields

/*:
 
 ### Array and Control flows
 
 The `for-in` loop is great to enumerate elements in an array
 
 */
for japaneseFood in japaneseFoods {
    "\(japaneseFood) is a delicious."
}

// `enumerated` method would return an `interator` with pairs (tuples) of index and value.
for (index, taiwaneseFood) in taiwaneseFoods.enumerated() {
    "The food at \(index) is \(taiwaneseFood)."
}

/*:
 
 In Swift, we have a convention that functions and methods which alter the data structure itself (in place)
 would be named in plain form, like `sort` and `filter`. And since these methods alters the object itself,
 it's only available to mutable instances (variables).
 
 For method named with past tense, like `sorted` and `filtered`, they return a copy of the original one
 
 */

let unorderedNumbers = [4, 1, 5, -10, 12, 6, 3, 7, 2]
let sortedNumbers = unorderedNumbers.sorted()
unorderedNumbers


var unorderedNumbers2 = [1, 2, -1, 4, 3, 5]
unorderedNumbers2.sort()
unorderedNumbers2

/*:
 
 ## Array is a generic type
 
 The `Array` type could hold another type as its `Element` type. This concept
 is called **Generic**. We say that Array is a generic collection type. The syntax
 of denoting a generic type is by angle brackets (`<>`).
 
 Types in properties and methods of a generic type may be changed.
 
 */
let emptyDoubleOptional = emptyDoubleArray.first
let emptyStringOptional = emptyStringArray.first
// Try to use "option+click" to see the type of above two constants.

emptyDoubleArray.append(42.0)
emptyStringArray.append("String")
// Try to append different types into these arrays, like:
//emptyStringArray.append(10)

let removedDouble = emptyDoubleArray.removeLast()
let removedString = emptyStringArray.removeFirst()
// Try to use "option+click" to see the type of above two constants.

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
