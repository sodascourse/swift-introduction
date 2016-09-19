//: # Control Flow
//:
//: Swift has following control flow statements:
//: * if/else
//: * guard
//: * switch/case
//: * for and for-in
//: * while and repeat-while
//:

import Foundation

//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## For and For-in loops
//:

for index in 0..<3 {
    print("index is \(index)")
}

var sum1: Int = 1
for _ in 1...3 {
    sum1 += sum1
}
sum1

for number in [1, 2, 3, 4, 5, 6] {
    print(number)
}

for (intValue, stringValue) in [1: "one", 2: "two", 3: "three"] {
    print("\(stringValue) is '\(intValue)'")
}

//:
//: NOTE: In Swift, you use underscore (`_`) for values which would not be used.
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## While and Repeat-while loops
//:
//: The _repeat-while_ loop is like _do-while_ in C and Objective-C.
//:

var sum2: Int = 0
while sum2 < 10 {
    sum2 += 1
}

var times1 = 0
repeat {
    print("Repeat ...")
    times1 += 1
} while (times1 < 1)

//:
//: --------------------------------------------------------------------------------------------------------------------
//: ## If/else

let temperature = 19.0
let moisture = 0.70
if temperature < 10 || (temperature < 15 && moisture >= 0.70) {
    print("Cold")
} else if temperature < 20 {
    print("A little cold")
} else {
    print("It's okay")
}

//:
//: --------------------------------------------------------------------------------------------------------------------
//: ## Early Exit and Guard
//:
//: A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression. 
//: You use a guard statement to require that a condition must be true in order for the code after the `guard` statement 
//: to be executed.
//:
//: A `guard` statement always has an `else` clause, the code inside the else clause is executed if the condition is 
//: not true.
//:
//: Using a `guard` statement for requirements improves the readability of your code, compared to doing the same check 
//: with an if statement. It lets you write the code that’s typically executed without wrapping it in an else block, 
//: and it lets you keep the code that handles a violated requirement next to the requirement.
//:

func divide1(a: Double, _ b: Double) -> Double {
    guard b != 0 else {
        print("The second argument should not be zero.")
        return Double.infinity
    }
    return a / b
}

func divide2(a: Double, _ b: Double) -> Double {
    if b == 0 {
        print("The second argument should not be zero.")
        return Double.infinity
    }
    return a / b
}

func divide3(a: Double, _ b: Double) -> Double {
    if b != 0 {
        return a / b
    } else {
        print("The second argument should not be zero.")
        return Double.infinity
    }
}

//:
//: --------------------------------------------------------------------------------------------------------------------
//: ## Switch/case
//:
//: _Switch-case_ in Swift is very powerful!
//:
//: ### Simplest case
//:
//: Note that in Swift, you don't have to add `break` in each case block (This is called **No Implicit Fallthrough**)

let zeroNumber = 0
switch zeroNumber {
case 0:
    print("zero")
default:
    print("Not zero")
}

//: ### Multiple matches and Fallthrough

let matchNumber1 = 1
switch matchNumber1 {
case 0, 1:
    print("smaller than 2")
    fallthrough
case 2:
    print("smaller than 3")
default:
    print("> 3")
}

//: ### Interval Matching

let approximateCount = 1
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
"'\(approximateCount)' is \"\(naturalCount)\""

//: ### Tuple Matching and Value Bindings

typealias Point = (Int, Int)

let somePoint: Point = (3, 1)
switch somePoint {
case (0, 0):
    "(0, 0) is at the origin"
case (_, 0):
    "(\(somePoint.0), 0) is on the x-axis"
case (0, _):
    "(0, \(somePoint.1)) is on the y-axis"
case (-2...2, -2...2):
    "(\(somePoint.0), \(somePoint.1)) is inside the box"
default:
    "(\(somePoint.0), \(somePoint.1)) is outside of the box"
}

let anotherPoint: Point = (5, 0)
switch anotherPoint {
case (let x, 0):
    "on the x-axis with an x value of \(x)"
case (0, let y):
    "on the y-axis with a y value of \(y)"
case let (x, y):
    "somewhere else at (\(x), \(y))"
}

//: Use `where` to check for additional conditions

let yetAnotherPoint: Point = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    "(\(x), \(y)) is on the line x == y"
case let (x, y) where x == -y:
    "(\(x), \(y)) is on the line x == -y"
case let (x, y):
    "(\(x), \(y)) is just some arbitrary point"
}

//:
//: --------------------------------------------------------------------------------------------------------------------
//: ## Break and Continue

var oddNumbers: [Int] = []
for var number in 0...20 {
    if number < 5 {
        continue
    } else if number < 15 {
        if number % 2 == 1 {
            oddNumbers.append(number)
        }
    } else {
        break
    }
}
oddNumbers

//: ## Labeled Statements
//:
//: _Labeled statements_ is used to define a statement block and could make the target of `continue` and `break`
//: clearly.
//:

var pairs = [(Int, Int)]()
iLoop: for i in 0..<10 {
    var j = 0
    jLoop: while j < 10 {

        guard j < 3 || j % 4 == 0 else {
            continue iLoop
        }
        pairs.append((i, j))

        j += 1
    }
}
for (x, y) in pairs {
    "(\(x), \(y))"
}

//: --------------------------------------------------------------------------------------------------------------------
//: ## Defer
//:
//: You use a defer statement to execute a set of statements just before code execution leaves the current block of 
//: code. This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves 
//: the current block of code—whether it leaves because an error was thrown or because of a statement such as return or 
//: break. For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated 
//: memory is freed.

var tableIsUsing = false
func read(_ source: String) {
    guard !tableIsUsing else {
        print("Cannot use the table")
        return
    }
    tableIsUsing = true
    defer {
        tableIsUsing = false
    }

    guard source.characters.count >= 5 else {
        print("The source is too short")
        return
    }
    print("read")
}

read("XD")
read("Some great newspaper")

//: NOTE: Comment the `defer` block to see what happened

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
