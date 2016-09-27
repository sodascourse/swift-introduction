/*:
 
 # Variables
 
 - A variable is like a storage for a value
 - Swift uses variables to store and refer to values by an identifying name. 
   _We usually give variables a clear name with proper meaning._
 - Variable names in Swift follows the **camelCase** rule.
   + The first letter of the name is lowercase.
   + The second or further words in the name are connected by a _uppercase_ letter.
   + Like `bookTitle`, `authorName`, and `nameOfAccountOwner`
 - Don’t use meaningless name for variables, you (or your partner) could not understand 
   the usage of this variable. _Like x, i, a, tmp, foo, bar, blah ..._
 - Follow English grammar when possible. It helps people who read your code.
 - In Swift, it’s okay to use _non-ASCII_ characters as variable name.

 */

/*:
 
 ## Declaration
 
 - We use `let` to declare a **constant**, storage which would not change its value, 
   _for immutable value_.
 - _For mutable values_, we use `var` to declare a **variable**, storage which allows 
   to change its value later.

 ## Assignment
 
 - We use `=` to assign value in the left to variable/constant in the right.
 - It’s not the _equal sign_ in mathematic.
 - A variable/constant is said **initialized** after assigning first value to it.

 */

// A constant named "answer", and the value `42.0` is assgined when declaring it.
let answer = 42.0
// A variable called "year", and is initialized with the value `2016`.
var year = 2016
// A constant called "name" is declared with an initial value `"Peter"`.
let name = "Peter"
// A variable called "thisYear", and is assigned with the value of the "year" variable.
var thisYear = year
// The "year" is a variable, and could be re-assigned with a new value, `2017`.
year = 2017

//: > Your practice:
//: >  1. Re-assign a new value, `"Emma"`, to the constant "name", and read what Xcode says.
//: >  2. What's the value of the variable "thisYear", 2016 or 2017?

//: In Swift, it's okay to use non-ASCII characters as identifier of variables and constants.
//:
//: > **ASCII**, see [wikipedia](https://en.wikipedia.org/wiki/ASCII), is a character encoding 
//: > describing about how to use digits to store numbers, letters, and punctuation symbols in
//: > computer. The standard ASCII only represents English letters and modern computer systems
//: > uses **Unicode**, see [wikipedia](https://en.wikipedia.org/wiki/Unicode), to store
//: > characters, including Chinese, Japanese, and other characters.
let スウィフト = "Swift"
let colorOf🍎 = "red"
let ラーメン = "🍜"
let 👍 = true

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
