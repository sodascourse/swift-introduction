//: # Operators
//:
//: Operators are unary, binary, or ternary:
//: * Unary operators operate on a single target (such as `-a`). Unary prefix operators appear immediately before their
//:   target (such as `!b`), and unary postfix operators appear immediately after their target (such as `i++`).
//: * Binary operators operate on two targets (such as `2 + 3`) and are infix because they appear in between their two
//:   targets.
//: * Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional
//:   operator (`a ? b : c`).
//:
//: > NOTE: In Swift, unary operators should not be separated with its operand. (i.e. has spaces between them)
//:

//- 3  // ERROR: Uncomment this line to see the error message

//: --------------------------------------------------------------------------------------------------------------------
//: ## Assignment
let a = 1
let (x, y) = (10, 11)  // x = 10 and y = 11

//: --------------------------------------------------------------------------------------------------------------------
//: ## Arithmetic
1 + 1
3 - 2
2 * 2

8 / 4
4 / 8
4.0 / 8
let half: Double = 4 / 8
let zero: Int = 4 / 8

42 % 4
43 % 2.5

"Hello" + " " + "World" + "!"
[1, 2] + [3, 4]

var i = 0
i += 1
i *= 10

//: --------------------------------------------------------------------------------------------------------------------
//: ## Comparison
1 < 2
2 <= 2
3 == 4
5 != 7
6 >= 5
4 > 5

let array1: [Int] = [1]
let array2: [Int] = [1]

array1 == array2

let 醤油ラーメン1 = 醤油🍜()
let 醤油ラーメン2 = 醤油🍜()
let 塩ラーメン = 塩🍜()

醤油ラーメン1 == 醤油ラーメン2
醤油ラーメン1 == 塩ラーメン

//: NOTE: Comparison between instances of structures/classes would be mentioned in future classes.

//: --------------------------------------------------------------------------------------------------------------------
//: ## Ternary Conditional

let number1 = 1
number1 != 0 ? "True" : "False"
//number1 ? "True" : "False"  // ERROR: Uncomment this line to see what happened.

//: NOTE: In Swift, numbers are not `BooleanType` and hence could not be used as boolean diretly
//:
//: ---
//:
//: ### Nil Coalescing
//:
//: NOTE: See `optional value` in Swift first
//:

let dict1: [Int: String] = [1: "one"]
let optionalOne: String? = dict1[1]
let optionalTwo: String? = dict1[2]
optionalOne ?? "--- one"
optionalTwo ?? "--- two"

//: --------------------------------------------------------------------------------------------------------------------
//: ## Range
//:
//: * `...` is **Closed Range Operator** which includes both _start_ and _end_ in the range.
//: * `..<` is **Half-Open Range Operator** which includes only _start_ but not _end_ in the range.
//:

for i in 0...5 {
    print(i)
}

for i in 0..<5 {
    print(i)
}

//: --------------------------------------------------------------------------------------------------------------------
//: ## Logical

!true
true && true
true && false
false || true
false || false

//: --------------------------------------------------------------------------------------------------------------------
//: ## Bitwise

let twelve = 0b1100
let three = ~twelve  // (~0b1100 --> 0b0011)
let six = 0x6  // (0b0110)
let four = twelve & six  // (0b1100 & 0b0110 --> 0b0100)
let fourteen = twelve | six  // (0b1100 | 0b0110 --> 0b1110)
let ten = twelve ^ six  // (0b1100 XOR 0b0110 --> 0b1010)
let eight = 0b0001 << 3
let two = 0b1000 >> 2

//: --------------------------------------------------------------------------------------------------------------------
//: ## Operator Functions
//:
//: ### Overload Operator
//:
//: In Swift, you can overload operators to provide custom definition of an operator
//:

func +(a: Int, b: String) -> String {
    return String(a) + b
}  // Try to comment this function to see what error you get from the following line
2 + " eggs"
//"eggs" + 2  // ERROR: Uncomment this line to see what error message you get

func +=(inout left: String, right: Int) {  // `inout` works like `pass-by-reference`.
    left = left + String(right)
}  // Comment this to see what error message you get from the following liness
var str1 = "1 plus 1 is "
str1 += 2

prefix func +(a: String) -> Int {
    return a.characters.count
}  // Try to comment this function to see what error you get from the following line
+"Apple"

//:
//: ### Custom Operator
//:
//: Further, you could declare a custom operator
//:

prefix operator ✈️ {}
prefix func ✈️(dest: String) -> String {
    return "Fly to \(dest)"
}
✈️"San Francisco"

infix operator +^ { associativity left precedence 140 }
func +^(a: Int, b: Int) -> Int {
    return a*a + b*b
}
3 +^ 4

infix operator +> { associativity left precedence 90 }
func +>(left: Int, inout right: Int) {
    right = right + left
}
var rightNum = 40
2 +> rightNum
rightNum

//: Check **Advanced Operators** and **Swift Standard Library Operators Reference** for information of built-in
//: operators

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
