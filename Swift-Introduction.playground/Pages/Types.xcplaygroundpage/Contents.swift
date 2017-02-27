/*:

 # Types

 Each variable and constant in Swift has a **type**, _unlike Python which variable
 references don’t have types_. This is the "Type Safety" feature of Swift.

 But for the convenience, Swift also has a feature called "Type Inference" which means
 the compiler would infer the type of variables automatically; you don't have to specify the
 type of each variable manually, like Java and C++.

 */

/*:

 ## Type Annotation

 To specify types in Swift, put a colon (`:`) after the name (identifier) of variables and
 constants, like the way in _ActionScript_, _TypeScript_, and _Python 3.5_.

 */
let price: Int = 42
var name: String = "Peter"

/*:

 ## Type Inference

 Swift would infer the type of variables when possible.
 
 > Use `option+click` on variables and costants to see the type Swift inferred.

 */
let year = 2016
var city = "Taipei"

/*:
 
 Type inference only works when the variable/constant is declared with an initialize value.
 Because the compiler would infer its type by value assigned when declaring.
 
 So if you declare a variable/constant without assigning a value, you also have to declare its type.

 */
// A constant is declared without assigning value. (i.e. uninitialized)
let country: String
// To initialize the constant, assign value to it.
country = "Taiwan"
// Constants which are initialized cannot be assigned again.
//country = "Japan"  // Try to uncomment this line to see the error message.


/*:

 ## Type of variables cannot be changed

 The type of a variable/constant is fixed. And hence each variables/constants could only
 store the value of correct type after declared.

 */
city = "Tokyo"
//city = 42
// Uncomment the above line `city = 42` to see what Xcode says.

/*:

 ## Type alias

 Like `typedef` in C, we can create alias of types to make them more fit to your context.

 */
typealias Score = Int
let scoreOfPeter: Score = 42

/*:
 For example, you may use a tuple to express a data structure for Book first. And in the future,
 when you want to extend the data structure, just change the declaration; you don't have to change
 code using this data structure.
 
 > Try to comment `Declaration 1` and uncomment `Declaration 2`.
 */

// > Declaration 1
typealias Book = (title: String, authorName: String, price: Double)
// > Declaration 2
//struct Book {
//    let title: String
//    let authorName: String
//    var price: Double
//}

let book1 = Book(title: "Harry Potter", authorName:"J.K. Rowling", price: 42.0)
let titleOfBook1 = book1.title

//: --------------------------------------------------------------------------------------------------------------------

/*:

 ## Common Types

 Followings are common primitive types you would see in Swift.

 */
let integer: Int = -42
let integerMax = Int.max
let integerMin = Int.min
let unsignedInteger: UInt = 42

let charInt: Int8 = 127
let shortInt: Int16 = 32767
let int: Int32 = 2147483647
let longInt: Int64 = 9223372036854775807

let unsignedCharInt: UInt8 = 255
let unsignedShortInt: UInt16 = 65535
let unsignedInt: UInt32 = 4294967295
let unsignedLongInt: UInt64 = 18446744073709551615

// Float is 32 bits long and has a precision of 7 digits.
let float: Float = 3.14
// Double is 64 bits long and has double precision of floats.
let double: Double = 2.71828

let floatPi = Float.pi
let doublePi = Double.pi

let string: String = "string"
let boolean: Bool = true

//: > Check the documentation of Swift for these types and their properties

/*:

 ### Conversion between common types

 Types are either structures or classes in Swift. To convert types, just create new instances of target type.

 */
let integerAnswer = 42
let floatAnswer = Float(integerAnswer)
let stringAnswer = String(42)
let pi = 3.1415926
let three = Int(pi)

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
