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

 ## Loops
 
 A **loop** is a sequence of statements which is specified once but which may be 
 carried out several times.
 
 ### `for-in`
 
 You use the for-in loop to iterate over a sequence, such as ranges of numbers, 
 items in an array, or characters in a string.

 */
for index in 0..<5 {
    index
}

func sum(_ x: Int) -> Int {
    var result = 0
    for item in 0...x {
        result += item
    }
    return result
}
sum(6)

func power(_ base: Int,  exponent exp: Int) -> Int {
    var result = 1
    for _ in 0..<exp {
        result *= base
    }
    return result
}
power(2, exponent: 4)
//: > In Swift, you use underscore (`_`) for values which would not be used.

for character in "Hello World!".characters {
    character
}

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ### While loops
 
 A while loop performs a set of statements until a condition becomes false. 
 These kinds of loops are best used when the number of iterations is not known 
 before the first iteration begins.
 
 Swift provides two kinds of while loops:
 - `while` evaluates its condition at the start of each pass through the loop.
 - `repeat-while` evaluates its condition at the end of each pass through the loop.
 
 */
func heat(to targetTemperature: Int) {
    var currentTemperature = 0
    while currentTemperature < targetTemperature {
        print("Keep heating to \(targetTemperature) ... It's \(currentTemperature) now.")
        currentTemperature += 10
    }
    print("Done heating, the temperature is now \(currentTemperature).")
}
print("------ Heat ------")
heat(to: 50)
heat(to: -10)
print("====== Heat ======\n\n")

func forceHeat(to targetTemperature: Int) {
    var currentTemperature = 0
    repeat {
        print("Keep force-heating to \(targetTemperature) ... It's \(currentTemperature) now.")
        currentTemperature += 10
    } while currentTemperature < targetTemperature
    print("Done force-heating, the temperature is now \(currentTemperature).")
}
print("------ Force Heat ------")
forceHeat(to: 50)
forceHeat(to: -10)
print("====== Force Heat ======\n\n")

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Control Transfer Statements
 
 Control transfer statements change the order in which your code is executed,
 by transferring control from one piece of code to another. 
 
 Swift has five control transfer statements:
 - `continue`
 - `break`
 - `fallthrough`
 - `return`
 - `throw`
 
 In this Playground page, we would talk about `continue` and `break`.
 _(You know the `return` statement via function implementation, and the `fallthrough` and `throw` would be
   mentioned in further chapters.)_
 
 */
/*:
 
 ### `continue`
 
 The `continue` statement tells a loop to stop what it is doing and start again at the beginning 
 of the next iteration through the loop. It says “I am done with the current loop iteration”
 without leaving the loop altogether.
 
 */
func sumOfEvenNumbers(to upperBound: Int) -> Int {
    var result = 0
    for number in 0...upperBound {
        guard number % 2 == 0 else {
            continue
        }
        result += number
    }
    return result
}
sumOfEvenNumbers(to: 10)

/*:
 
 ### `break`
 
 The `break` statement ends execution of an entire control flow statement immediately.
 The `break` statement can be used inside a switch statement or loop statement when you want to 
 terminate the execution of the switch or loop statement earlier than would otherwise be the case.
 
 */
func isPrime(_ number: Int) -> Bool {
    guard number >= 2 else {
        print("Error: The definition of primes is available only when the number is greater than 1.")
        return true
    }
    let squareRootBound = Double(number).squareRoot().rounded()
    for divisor in 2..<number {
        guard divisor <= Int(squareRootBound) else {
            break
        }
        print("Test whether \(number) is a prime or not with \(divisor) as divisor.")
        if number % divisor == 0 {
            return false
        }
    }
    return true
}
print("------ Prime ------")
isPrime(5)
isPrime(13)
isPrime(221)
print("====== Prime ======\n\n")

//: --------------------------------------------------------------------------------------------------------------------
//: > Try to write a function which calculate the summary of odd numbers within an upper bound.



//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
