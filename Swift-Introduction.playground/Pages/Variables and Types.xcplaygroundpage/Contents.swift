//: # Variables and Types
//: --------------------------------------------------------------------------------------------------------------------
//: 
//: ## Comments
//:
//: Swift uses **C-style comments** which single line comments start with `//` and multiline one starts
//: with `/*` and ends with `*/`.
//:
//: In Xcode (and most IDE on the OS X), you could use _"command+/"_ to comment and uncomment selected lines.
//:

// This is a single line comment.

/*
 * This is a multiline comment.
 */

//: --------------------------------------------------------------------------------------------------------------------
//: ## Literals
//:
//: A literal is the source code representation of a value of a type, such as a number or string.
//:

42  // This is an integer literal
3.141596  // This is a floating-point literal
"Hello World!"  // This is a string literal
true  // This is a boolean literal

//: --------------------------------------------------------------------------------------------------------------------
//: ## Variable Declaration
//:
//: Use `var` to declare mutable variables and `let` for immutable ones.
//: The mutability behavior also applies to all value types, including "structure".
//: The scope of variables is based on blocks, like C.
//:
//: * For keyword list in Swift, See ["The Swift Programming Language (Swift 2.1, from Apple) > Language Reference > Lexical Structure > Keywords and Punctuation"](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID413).
//: * Wrapping keywords with a back-tick (\`) to use _keywords_ as _identifiers_. (Like \`class\` for an identifier 
//: called "class" which is a reserved keyword of Swift)
//:

var answer = 42
answer = 50
let constantAnswer = 42
let スウィフト = "Swift"

//: Swift allows you to use unicode names, including emoji; even the name of functions and classes.
struct 🍎 {
    func 👅() -> String {
        return "Licking an apple"
    }
}

let apple = 🍎()
apple.👅()

//: --------------------------------------------------------------------------------------------------------------------
//: ## Variable Types
//:
//: Each variable and constant in Swift **has a type**, _unlike Python which variable references don’t have types_.
//: This is the "Type Safety" feature of Swift.
//:
//: But for the convenience, Swift also has a feature called "Type Inference" which means the compiler would infer type 
//: of variables automatically; you don't have to specify the type of each variable manually, like Java and C++.
//:

var str1 = "Hello World!"
//str1 = 42  // ERROR: Uncomment this line to see which error message you get

//:
//: Try to use "_option+click_" to see the types of `str` inferred by the Swift compiler. You may have to wait for the 
//: mouse pointer to become a _question mark_, "?", and you would see this popup: ![](check-inferred-type.png)
//:
//: Try to uncomment the line `str = 42` to see what error message you get. In the above example, the `str` has been 
//: inferred as a `String` type variable, and hence it could not be reassigned with an `Int` type variable.
//:
//: ---
//:

//:
//: ### Type Conversion
//:
//: Types are either structures or classes in Swift. To convert types, just create new instances of target type.
//:

let answerInt: Int = 42
let answerString: String = String(answerInt)

let sixteenString: String = "16"
let sixteenFloat: Float? = Float(sixteenString)

//:
//: ### Type Alias
//:
//: Like `typedef` in C

typealias Score = Int
let currentScore: Score = 1

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
