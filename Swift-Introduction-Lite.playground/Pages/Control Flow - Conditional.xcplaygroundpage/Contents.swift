/*:
 
 # Control Flow
 
 Control flow statements are used to change the execution order of lines of code.
 
 Swift provides a variety of control flow statements. These include `while` loops to perform a task multiple times;
 `if`, `guard`, and `switch` statements to execute different branches of code based on certain conditions;
 and statements such as `break` and `continue` to transfer the flow of execution to another point in your code.
 
 Swift also provides a `for-in` loop that makes it easy to iterate over arrays,
 dictionaries, ranges, strings, and other sequences.
 
 */

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Conditional Statements
 
 It is often useful to execute different pieces of code based on certain conditions. 
 You might want to run an extra piece of code when an error occurs, 
 or to display a message when a value becomes too high or too low. 
 To do this, you make parts of your code conditional.
 
 
 ### `if`

 In its simplest form, the if statement has a single `if` condition. It executes a set of statements
 only if that condition is true.

 */
print("------ If statement ------")
if 5 > 2 {
    print("5 is bigger than 2.")
}
let someFalseCondition = 2 == 0
if someFalseCondition {
    print("This line won't be printed.")
}
print("====== If statement ======\n\n")

/*:
 
 The if statement can provide an alternative set of statements, known as an _else clause_,
 for situations when the `if` condition is false. These statements are indicated by the `else` keyword.
 
 */
print("------ Temperature ------")
let currentTemperature = 24.0
if currentTemperature > 32 {
    print("It's quite hot today.")
} else {
    print("It's not so hot today.")
}
print("====== Temperature ======\n\n")

/*:
 
 You can chain _multiple_ `if` _statements_ together to consider additional clauses.
 
 */
func feeling(ofTemperature degree: Double) -> String {
    let message: String
    if currentTemperature > 32 {
        message = "It's quite hot today."
    } else if currentTemperature > 25 {
        message = "It's a little hot today."
    } else if currentTemperature > 20 {
        message = "It's great today."
    } else if currentTemperature > 15 {
        message = "It's cool today."
    } else {
        message = "It's cold today."
    }
    return message
}
feeling(ofTemperature: currentTemperature)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### `guard`
 
 A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression.
 
 You use a `guard` statement to require that a condition must be true 
 **in order for the code after the guard statement to be executed**. 
 
 Unlike an `if` statement, a guard statement _always_ has an else clause,
 the code inside the else clause is executed if the condition is not true.
 
 */
func divide(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    guard y != 0 else {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    return (x/y, x%y)
}
print("------ Divide ------")
divide(12, by: 5)
divide(12, by: 0)
print("====== Divide ======\n\n")

/*:
 
 Without using the `guard` statement, the function implementation would be like:
 
 */
func badDivide1(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    if y == 0 {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    return (x/y, x%y)
}

func badDivide2(_ x: Int, by y: Int) -> (quotient: Int, remainder: Int) {
    if y != 0 {
    } else {
        print("Error: Cannot divide \(x) by \(y).")
        return (0, 0)
    }
    return (x/y, x%y)
}

/*:
 
 In the first example, `badDivide1(_:by:)`, the requirement condition is reversed.
 The condition we want to ensure is `y != 0`, but the code we write is `y == 0`.
 
 In the second example, `badDivide2(_:by:)`, the requirement condition is the same
 as the one we want to ensure. But it has an empty and redundant code block.
 
 Using a `guard` statement for requirements improves the readability of your code, 
 compared to doing the same check with an `if` statement. It lets you write the code
 that’s typically executed without wrapping it in an `else` block, and it lets you 
 keep the code that handles a violated requirement next to the requirement.
 
 */

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
