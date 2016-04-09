//: # Basic Data Types
//: --------------------------------------------------------------------------------------------------------------------

import Foundation

//:
//: ## Number data types
//:

var normalInt: Int  // which is 8 bytes in 64-bit system or 4 bytes in 32-bit system
var shortInt: Int8
var twoBytesInt: Int16
var thirtyTwoBitsInt: Int32
var sixtyFourBitsInt: Int64

Int64(Int.max) == Int64.max  // Use Int64, the largest Int type, for comparison
Int64(Int.max) == Int64(Int32.max)  // Use Int64, the largest Int type, for comparison

var normalUnsignedInt: UInt  // which is 8 bytes in 64-bit system or 4 bytes in 32-bit system
var unsignedShortInt: UInt8  // which is also used as `byte` in Swift
var unsignedTwoBytesInt: UInt16
var unsignedThirtyTwoBitsInt: UInt32
var unsignedSixtyFourBitsInt: UInt64

var floatNumber: Float  // 4 bytes
var doubleNumber: Double  // 8 bytes

var booleanTrue: Bool = true
var booleanFalse: Bool = false

//:
//: ## Strings data types
//:

//:
//: ### Character View
//: 
//: The _View_ here is the same concept like you used in database, which could be treated as a virtual table in the
//: database based on a query or a sort order. In Python 3, the list containing keys of dictionary is also a view which
//: looks like an array but actually there's no such real array in the memory storage of a dictionary.
//:
//: The `characters` property of `String` is actually a view which represents a list of characters in this String
//: instance.
//:

// Count the number of characters in the string. (i.e., the length of this string)
"Dog!🐶".characters.count

// Enumerate characters in a string
var charactersInDogString = [Character]()
for character in "Dog!🐶".characters {
    charactersInDogString.append(character)
}
charactersInDogString

// Get character and substrings by index and subscription

let helloWorldStr = "Hello World!"
helloWorldStr[helloWorldStr.startIndex]  // The first character
helloWorldStr[helloWorldStr.endIndex.predecessor()]  // The last character
helloWorldStr[helloWorldStr.startIndex.advancedBy(8)]  // The 9th character, zero-based index
let index5_helloWorld = helloWorldStr.startIndex.advancedBy(5)
helloWorldStr.substringToIndex(index5_helloWorld) // First 5 letters
let index6_helloWorld = index5_helloWorld.successor()
let indexLast_helloWorld = helloWorldStr.endIndex.predecessor()
let range = index6_helloWorld..<indexLast_helloWorld
helloWorldStr.substringWithRange(range)

//:
//: ### Unicode, Concatenation, and Interpolation
//:

"Hello" + " " + "World!"
var ultimateAnswer: Int = 42
"The Answer to the Ultimate Question of Life, the Universe, and Everything is \(ultimateAnswer)"
"1 + 1 = \(1+1)"
"Love is \u{2665}"

//: ## Tuples
//:
//: Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not
//: have to be of the same type as each other.
//:

let http404Error = (404, "Not Found")
let (errCode, errReason) = http404Error
//let (errCode, errReason, errInfo) = http404Error  // ERROR: Uncomment this to see the error message
let errorCode = http404Error.0
let errorReason = http404Error.1

//: ### Named tuples

let http200Status = (statusCode: 200, description: "OK")
let statusMessage = http200Status.description
let (statusCode, _) = http200Status
http200Status.1

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
