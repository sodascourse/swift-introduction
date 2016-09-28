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
    default:
        description = "Some other character"
    }
    return description
}
description(of: "z")
description(of: "h")
description(of: "A")

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

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
