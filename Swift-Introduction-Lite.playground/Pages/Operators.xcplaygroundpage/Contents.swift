/*:
 
 # Operators
 
 An operator is a special symbol or phrase that you use to check, change, or combine values.
 
 Operators are unary, binary, or ternary:
 - **Unary** - operate on a single target. 
   + Unary prefix operators appear immediately before their target (such as `!b`)
   + Unary postfix operators appear immediately after their target (such as `c!`).
 - **Binary** - operate on two targets (such as `2 + 3`) and are infix because they appear in
   between their two targets.
 - **Ternary** - operators operate on three targets.
 
 */

/*:
 
 ## Assignment operator
 
 The one which initializes/updates the variable/costant in the left 
 with the value in the right.

 */
let (two, three) = (2, 3)

/*:
 
 ## Arithmetic operators
 
 In Swift, we have
 - Addition, `+`
 - Subtraction, `-`
 - Multiplication, `*`
 - Division, `/`

 for all number types
 
 */
6 * 7
5 / 10
5.0 / 10
let half: Double = 5 / 10
//: > Types would affect the result value of operators.
//: > Arithmetic operations on integers result in integers too.

//: The addition operator is also supported to join two strings, like:
"Hello" + " " + "World!"

//: Swift also has a **remainder operator**
3 % 2
10 % 5
52 % 7

//: There are also an **unary minus operator** and an **unary plus operator**
let one = 1
let negativeOne = -one
let positiveOne = +one
//: > In Swift, spaces are not allowed between an unary operator and its operand.

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Compound assignment operators
 
 Swift provides compound assignment operators that combine assignment (=) 
 with another operation.
 
 Take the **Add and assign** (`a += b`) operator for example, it means:
 1. get the result of `a + b`
 2. put the result into `a`.
 
 */
var count = 10
count += 2
count

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Comparison operators
 
 Comparison operators take two number values and returns a bool value indicating 
 the relationship of the two values.
 
 Swift supports all standard C comparison operators:
 - Equal to (`a == b`)
 - Not equal to (`a != b`)
 - Greater than (`a > b`)
 - Less than (`a < b`)
 - Greater than or equal to (`a >= b`)
 - Less than or equal to (`a <= b`)

 */
1 == 2
2 == 2
3 > 4
3 <= 4
//: > In Swift, `==` is the equality operator, and `=` is the assignment operator.

//: When comparing to strings, Swift compares them with their ascii and unicode values.
"apple" < "banana"
"cat" > "dog"
"c" + "at" == "cat"

//: Tuples could be compared too. (by orders of elements)
(1, "B") > (2, "A")
(2, "B") > (2, "A")


//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Ternary conditional operator
 
 The ternary conditional operator is a special operator with three parts, which takes the form
 `question ? answer1 : answer2`. 
 
 It is a shortcut for evaluating one of two expressions based on 
 whether `question` is true or false. If question is true, it evaluates `answer1` and
 returns its value; otherwise, it evaluates `answer2` and returns its value.

 */
let condition1 = 1 > 2
condition1 ? "1 is greater than 2." : "1 is not greater than 2."
let condition2 = 30 >= 10
condition2 ? "30 is a more large number." : "10 is a more large number."


//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Logical operators
 
 Logical operators modify or combine the Boolean logic values true and false. 
 
 Swift supports the three standard logical operators found in C-based languages:
 - NOT `!` - reverses the bool value
 - AND `&&` - returns true when **all** the both bool values are true
 - OR `||` - returns true when **one of** the both bool values is true

 */
let trueCondition1 = 1 > -10
let falseCondition1 = "a" < "Z"
let falseCondition2 = !trueCondition1
let trueCondition2 = !falseCondition1

let andTrue = trueCondition1 && trueCondition2
let andFalse = trueCondition1 && falseCondition1
let orTrue = trueCondition1 || falseCondition1
let orFalse = falseCondition1 || falseCondition2

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Range operators

 Swift includes two range operators, which are shortcuts for expressing a range of values
 or a series of numbers.
 
 - Closed Range Operator (`a...b`) defines a range runs between `a` and `b`, including both
   ends.
 - Half-open Range Operator (`a..<b`) also defines a range runs between `a` and `b`, 
   but only including the start (`a`) but not the end `b`)
 ends.

 */
Array(10...15)
Array(10..<15)

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Operator Precedence
 
 Just like operators in math, Swift operators also have the precedence concept.
 See [Swift Operators Reference](https://developer.apple.com/reference/swift/1851035-swift_standard_library_operators)
 
 */
//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
