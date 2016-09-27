/*:
 
 # Strings
 
 A string is a series of characters, such as "hello, world" or "albatross".
 
 */
/*:
 
 ## Creating strings
 
 The easist way to create strings is by string literals

 */
let name = "Peter"
//: Or you can put any object to the `String` type to convert it to a string
String(describing: 60.0)
//: If you want to repeat some strings into patterns
String(repeating: "=-", count: 10)

/*:
 
 ## Mutability
 
 A string could not be modified if it's assigned to a constant.

 */
var sentence = "This"
sentence += " "
sentence += "is a book."
sentence

// Try to uncomment the following two lines to see what Xcode yields.
//let sentence2 = "This"
//sentence2 += " is a pen."

/*:
 
 ## Properties of strings
 
 Properties are like child values associated with a value
 
 */
let emptyString = ""
let helloWorldString = "Hello World!"
emptyString.isEmpty
helloWorldString.isEmpty
helloWorldString.characters.count

/*:
 
 ## String Interpolation
 
 String interpolation is a way to construct a new String value from a mix of constants,
 variables, literals, and expressions by including their values inside a string literal. 
 
 Each item that you insert into the string literal is wrapped in a pair of parentheses,
 prefixed by a backslash.
 
 */
let result = 6 * 3
"The result of 6+3 is \(result)."
"It's \(5 > 2) that 5 is bigger than 2."

/*:
 
 ## Escaped characters
 
 String literals can include the following special characters:

 - `\\` (backslash)
 - `\t` (horizontal tab)
 - `\n` (line feed)
 - `\"` (double quote)
 - `\'` (single quote)
 
 */
"Her name is \"Alice\"."
"This is a\nmultiline string."

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
