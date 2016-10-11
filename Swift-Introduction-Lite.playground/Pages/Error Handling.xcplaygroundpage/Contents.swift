/*:

 # Error Handling
 
 Error handling is the process of responding to and **recovering** from error conditions
 in your program. Swift provides first-class support for throwing, catching, propagating, 
 and manipulating recoverable errors at runtime.
 
 Some operations aren’t guaranteed to always complete execution or produce a useful output.
 Optionals are used to represent the absence of a value, but when an operation fails, 
 it’s often useful to understand what caused the failure, so that your code can respond accordingly.
 
 */
/*:

 ## Error Types
 
 In Swift, errors are represented by values of types that conform to the Error protocol.
 This empty protocol indicates that a type can be used for error handling.

 */
enum ArithmeticErorr: Error {
    case divideByZero
    case rootsOfNegativeNumbers
}

/*:
 
 ## Throw Errors
 
 You use a `throw` statement to throw an error.
 
 To indicate that a function can throw an error, you write the `throws` keyword in the 
 function's declaration after its parameters. A function marked with throws is called 
 **a throwing function**. If the function specifies a return type, you write the `throws`
 keyword before the return arrow (`->`).
 
 A throwing function propagates errors that are thrown inside of it to the scope from 
 which it’s called. Only throwing functions can propagate errors. Any errors thrown 
 inside a _nonthrowing function_ must be handled inside the function.
 
 */
func cannotThrowErrors() -> String? {
    return nil
}

func canThrowErrors() throws -> String? {
    return nil
}

func divide(_ dividend: Int, divisor: Int) throws -> (Int, Int) {
    guard divisor != 0 else {
        throw ArithmeticErorr.divideByZero
    }
    return (dividend/divisor, dividend%divisor)
}

/*:
 
 ## Handle Errors
 
 There are four ways to handle errors in Swift:
 
 - Propagate the error from a function to the code that calls that function
 - Handle the error using a `do-catch` statement
 - Handle the error as an _optional value_ with `try?`.
 - Assert that the error will not occur with `try!`.
 
 The last 2 are useful when you don't care about the error reason or when you
 just want the result.

 */
// Handle by `do-catch`
do {
    try divide(22, divisor: 0)
} catch ArithmeticErorr.divideByZero {
    "Cannot divide 22 by 0."
} catch {
    "Unknown Error."
}

// Handle by `try?`
let divideResult1 = try? divide(55, divisor: 7)
if divideResult1 != nil {
    let (quotient1, remainder1) = divideResult1!
    quotient1
    remainder1
} else {
    "No Result"
}

let divideResult2 = try? divide(49, divisor: 0)
if divideResult2 != nil {
    let (quotient2, remainder2) = divideResult2!
    quotient2
    remainder2
} else {
    "No Result"
}

// Handle by `try!`
let (quotient3, remainder3) = try! divide(22, divisor: 7)
quotient3
remainder3
//let (quotient4, remainder4) = try! divide(22, divisor: 0)
// Uncomment the above line to see what Xcode yields.

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Some use case
 
 Assume we have a vending machine, with following goods:
 
 */

typealias Item = (price: Int, count: Int)
var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Cookies": Item(price: 5, count: 2),
    "Pretzels": Item(price: 7, count: 11)
]

/*:
 
 And the vend function is:
 
 */

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func vend(itemNamed name: String, withCoins coins: Int) throws -> (name: String, change: Int) {
    // Check this is a valid item
    guard let item = inventory[name] else {
        throw VendingMachineError.invalidSelection
    }
    // Check the item is still available
    guard item.count > 0 else {
        throw VendingMachineError.outOfStock
    }
    // Check the coins are enough
    guard item.price <= coins else {
        throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coins)
    }

    // Decrease the count of purchased item
    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem

    // Return item name and change
    let change = coins - item.price
    return (name, change)
}

/*:
 
 Let's buy something
 
 */
func buy(_ name: String, withCoins coins: Int) -> String {
    do {
        let (_, change) = try vend(itemNamed: name, withCoins: coins)
        return "Purchased \(name) with \(change) coins as change."
    } catch VendingMachineError.invalidSelection {
        return "Cannot buy \(name). There's no such item to buy."
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        return "Cannot buy \(name). You need extra \(coinsNeeded) coins to buy."
    } catch VendingMachineError.outOfStock {
        return "Cannot buy \(name). Sold out."
    } catch {
        return "Unknown error."
    }
}
buy("Candy Bar", withCoins: 20)
buy("Cookies", withCoins: 2)
buy("Banana", withCoins: 20)
buy("Cookies", withCoins: 6)
buy("Cookies", withCoins: 15)
buy("Cookies", withCoins: 7)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Optionals vs Throwing Errors
 
 In performance, optionals are faster than throwing errors. Also the Swift prefers optionals over
 throwing errors, like when handling abset keys of a dictionary.
 
 But throwing errors are useful when the function may generate multiple kinds of errors, and even 
 including the bad value or the way to recover from the error. _(See the above example: vending function)_
 Optionals doesn't show the reason why the function fails.
 
 For simple functions which would fail by only one reason, use optionals; for others, you may use
 throwing errors, like the vending function.
 
 */
func divide1(_ dividend: Int, divisor: Int) throws -> (Int, Int) {
    guard divisor != 0 else {
        throw ArithmeticErorr.divideByZero
    }
    return (dividend/divisor, dividend%divisor)
}

func divide2(_ dividend: Int, divisor: Int) -> (Int, Int)? {  // preferred way
    guard divisor != 0 else {
        return nil
    }
    return (dividend/divisor, dividend%divisor)
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
