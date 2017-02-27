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
 
 ## Switch
 
 A switch statement considers a value and compares it against several possible matching patterns. 
 It then executes an appropriate block of code, based on the first pattern that matches successfully.
 A switch statement provides an alternative to the if statement for responding to multiple potential states.

 In its simplest form, a switch statement compares a value against one or more values of the same type.
 
 */
func description(of character: Character) -> String {
    var description: String
    switch character {
    case "a", "A":
        description = "The first letter of the alphabet"
    case "z", "Z":
        description = "The last letter of the alphabet"
    case "m":
        description = "This is a lowercase 'm'."
    case "M":
        description = "This is an 'M'."
    default:
        description = "Some other character"
    }
    return description
}
description(of: "z")
description(of: "h")
description(of: "A")
description(of: "m")

/*:
 
 ### Fallthrough

 In contrast with switch statements in C and Objective-C,
 switch statements in Swift do not fall through the bottom of each case and into the next one by default.

 Instead, the entire switch statement finishes its execution
 as soon as the first matching switch case is completed, without requiring an explicit break statement.
 This makes the switch statement safer and easier to use than the one in C and
 avoids executing more than one switch case by mistake.
 
 By contrast, C requires you to insert an explicit `break` statement at the end of every switch `case`
 to prevent fallthrough. Avoiding default fallthrough means that Swift switch statements are 
 much more concise and predictable than their counterparts in C, 
 and thus they avoid executing multiple switch cases by mistake.

 If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case 
 basis with the `fallthrough` keyword. The example below uses `fallthrough` to create 
 a textual description of a number.
 
 */
func describe(_ integerToDescribe: Int) -> String {
    var description = "The number \(integerToDescribe) is"

    switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
    }
    return description
}

describe(12)
describe(13)

/*:
 
 Swift's switch-case also supports **Interval Matching**.
 
 */
func feeling(of temperature: Int) -> String {
    switch temperature {
    case 36...50:
        return "Super hot"
    case 30..<36:
        return "Quite hot"
    case 26..<30:
        return "Hot"
    case 18..<26:
        return "Great"
    case 14..<18:
        return "Cool"
    case 0..<14:
        return "Cold"
    default:
        return "Unknown"
    }
}
feeling(of: 32)
feeling(of: 24)
feeling(of: 17)

/*:

 Even **tuple matching**, like

 */
typealias Point = (x: Double, y: Double)
func position(of point: Point) -> String {
    switch point {
    case (0, 0):
        return "(0, 0) is at the origin"
    case (_, 0):
        return "(\(point.x), 0) is on the x-axis"
    case (0, _):
        return "(0, \(point.y)) is on the y-axis"
    case (-2...2, -2...2):
        return "(\(point.x), \(point.y)) is inside the box"
    default:
        return "(\(point.x), \(point.y)) is outside of the box"
    }
}
position(of: (0, 5))
position(of: (1, 5))
position(of: (-1.5, 2))
position(of: (2, 0))
position(of: (0, 0))

/*:
 
 ### Value Bindings
 
 A switch case can bind the value or values it matches to temporary 
 constants or variables, for use in the body of the case. This behavior 
 is known as value binding, because the values are bound to temporary 
 constants or variables within the case’s body.
 
 */

func axis(of point: Point) -> String {
    switch point {
    case (0, 0):
        return "at the origin."
    case (let x, 0):
        return "on the x-axis with an x value of \(x)."
    case (0, let y):
        return "on the y-axis with a y value of \(y)."
    case let (x, y) where x == y:
        return "on the axis where x == y, the value is \(x)."
    case let (x, y):
        return "somewhere else at (\(x), \(y))."
    }
}
axis(of: (2, 0))
axis(of: (0, 4.2))
axis(of: (10, 5))
axis(of: (10, 10))
axis(of: (0, 0))

/*:
 
 This above `switch` statement **does not** have a default case.
 
 The final case, `case let (x, y)`, declares a tuple of two placeholder 
 constants that can match any value. Because `point` is always
 a tuple of two values, this case matches all possible remaining 
 values, and a default case is not needed to make the switch statement exhaustive.
 
 > Try to move the `case (0, 0)` to after `case let (x, y)` to see what happens. 
 
 */

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
