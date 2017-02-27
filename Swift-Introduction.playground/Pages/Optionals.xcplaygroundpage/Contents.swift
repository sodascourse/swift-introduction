/*:

 # Optionals

 You use **optionals** in situations where a value may be _absent_. 
 
 An optional represents two possibilities: 
 - Either there is a value, and you can unwrap the optional to access that value
 - or there isn’t a value at all
 
 We put _a question mark_ (`?`) after the type to indicate that this variable has
 an optional value.

 */
/*:
 
 Take following lines as example, converting strings into numbers may fail when
 the string is not composed by digits.

 */
let possibleNumber1 = "123"
let convertedNumber1 = Int(possibleNumber1)
let possibleNumber2 = "ABC1"
let convertedNumber2 = Int(possibleNumber2)
//: > Use `option+click` to see the type of `convertedNumber2`.

/*:
 
 ## `nil`

 We use `nil` to denote that the value is absent.

 */
var concreteNumber: Int = 42
var optionalNumber: Int? = 42
optionalNumber = nil
//concreteNumber = nil  // Try to uncomment this line to see what Xcode yields.

func divide(_ dividend: Int, by divisor: Int) -> (quotient: Int, remainder: Int)? {
    // We cannot perform division when the `divisor` is '0',
    // So we have to check whether divisor is not zero, and returns `nil` when it's zero
    // The result is absent because we cannot perform task with given arguments.
    guard divisor != 0 else { return nil }
    return (dividend/divisor, dividend%divisor)
}

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Unwrapping optional values
 
 We have to unwrap the value from optionals before using it. 
 
 ### Forced unwrapping
 
 Use `if` statement to check whether it's `nil` or not, and then put a 
 _exclamation mark_ (`!`) after optionals to force unwrapping it.
 
 We called this way, using the `!` mark, as "forced unwrapping".
 
 */
func convertToNumber(from input: String, default defaultValue: Int = 0) -> Int {
    let convertedOptionalNumber = Int(input)
    if convertedOptionalNumber != nil {
        // Use the `!` mark to force unwrapping an optional to get its value
        // It's like telling Swift: I have checked this value, open the box of optional for me
        return convertedOptionalNumber!
    } else {
        return defaultValue
    }
}
convertToNumber(from: "1")
convertToNumber(from: "A")
convertToNumber(from: "A", default: -1)

/*:
 
 You should always check whether the value is nil or not before force unwrapping an optional.
 
 */

let answerString = "42"
let forcedUnwrappingNumber1 = Int(answerString)!
let helloWorldString = "Hello World!"
//let forcedUnwrappingNumber2 = Int(helloWorldString)!
// Try to uncomment the above line to see what happened.

/*:
 
 ### Optional binding
 
 You use optional binding to find out whether an optional contains a value,
 and if so, to make that value available as a temporary constant or variable.
 
 Optional binding can be used with `if`, `guard`, and `while` statements to 
 check for a value inside an optional, and to extract that value into a constant 
 or variable, as part of a single action.

 */

func parseInt1(_ string: String) -> (isInteger: Bool, value: Int) {
    let possibleNumber = Int(string)
    if possibleNumber != nil {
        let actualNumber = possibleNumber!
        return (true, actualNumber)
    } else {
        return (false, 0)
    }
}

/*:
 
 The two lines for checking nil and unwrapping could be merged as one line by
 **optional binding**, like:
 
 */

func parseInt(_ string: String) -> (isInteger: Bool, value: Int) {
    let possibleNumber = Int(string)
    if let actualNumber = possibleNumber {
        return (true, actualNumber)
    } else {
        return (false, 0)
    }
}
parseInt("12")
parseInt("XD")

/*:

 The `if` statement in `parseInt(_:)` could be read as

 “If the optional Int returned by `Int(possibleNumber)` contains a value,
 set a new constant called `actualNumber` to the value contained in the optional.”

 > Try to "option+click" on `possibleNumber` and `actualNumber` to see their types.
 
 Also, we use `guard` for optional binding too:

 */

func squareFloat(_ string: String) -> String? {
    guard let floatNumber = Float(string) else {
        return nil
    }
    return "\(floatNumber * floatNumber)"
}
squareFloat("16.0")
squareFloat("A")

/*:
 
 The `optional binding` could be chained together, like:
 
 */

func getAnswer(_ optionalInput: String?) -> String? {
    if let concreteString = optionalInput, let answer = Int(concreteString) {
        return "The answer is \(answer)."
    } else {
        return nil
    }
}
let optionalString: String? = "42"
getAnswer(optionalString)

func stringPower(base: String, exponent exp: String) -> String? {
    guard let baseNumber = Int(base), let expNumber = Int(exp) else {
        return nil
    }
    var result = 1
    for _ in 0..<expNumber {
        result *= baseNumber
    }
    return String(result)
}
stringPower(base: "2", exponent: "5")
stringPower(base: "2", exponent: "B")

/*:

 ### Nil-Coalescing Operator
 
 The _nil-coalescing operator_ (`a ?? b`) unwraps an optional a if it contains a value,
 or returns a default value b if a is nil.
 
 The expression `a` is always of an optional type. The expression `b` must match the type
 that is stored inside `a`.

 */
let someString1 = "XD"
let someString2 = "42"
let whateverNumber1 = Int(someString1) ?? -1
let whateverNumber2 = Int(someString1) ?? 0
let whateverNumber3 = Int(someString2) ?? -1
//: > Try to "option+click" on `whateverNumber1` and `whateverNumber2` to see their types.

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
