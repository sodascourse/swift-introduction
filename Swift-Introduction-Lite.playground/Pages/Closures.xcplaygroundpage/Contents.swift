/*:

 # Closures
 
 Closures are self-contained blocks of functionality that can be passed around 
 and used in your code. 
 
 Functions are actually special cases of closures. Closures take one of three forms:

 - Global functions are closures that **have a name** and do not capture any values.
 - Nested functions are closures that _have a name_ and can **capture values**
   from their enclosing function.
 - Closure expressions are **unnamed closures** written in a lightweight syntax 
   that can capture values from their surrounding context.

 */
/*:
 
 ## The type of functions and closures
 
 */
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiply(_ a: Int, _ b: Int) -> Int {
    return a * b
}

/*:
 
 This above example defines two simple mathematical functions called `add` and `multiply`.
 
 These functions take two `Int` values, and return an `Int` value. So the type of these functions is
 `(Int, Int) -> Int`. 
 
 This can be read as:
 “A function type that has two parameters, both of type Int, and that returns a value of type Int.”
 
 */
let someArithmeticFunction: (Int, Int) -> Int = add(_:_:)
someArithmeticFunction(1, 2)

/*:
 
 ## Use function as arguments
 
 */
func reduce(numbers: [Int], reducer: (Int, Int) -> Int) -> Int? {
    guard !numbers.isEmpty else {
        return nil
    }
    // This array is not empty, so it’s okay to use `!` to get the first element as result.
    var result = numbers.first!
    // Then, enumerate the rest part of this array 
    for number in numbers[1..<numbers.count] {
        result = reducer(result, number)
    }
    return result
}
reduce(numbers: [1, 2, 3, 4], reducer: add(_:_:))
reduce(numbers: [1, 2, 3, 4], reducer: multiply(_:_:))
reduce(numbers: [2, 3, 4, 5], reducer: +)
//: > Yes, operatos are functions in Swift.

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Use closure as anonymous functions
 
 In the above example, each time when I use the `reduce(numbers:reducer:)` function,
 I have to create a reducer function first, and then pass the function as the argument.
 
 Closures can make the syntax of this pattern easier, like:
 
 */
reduce(numbers: [1, 2, 3, 4], reducer: { (a: Int, b: Int) -> Int in
    return (a + b) * 2
})

/*:
 
 Closure expression syntax has the following general form:
 
 ```
 { (<parameter1>: <Type1>, <parameter2>: <Type2>, ...) -> <ReturnType> in
     <closure body>
 }

 ```
 
 And it can be simplified as following syntaxes:
 
 */
// The full form
reduce(numbers: [1, 2, 3, 4], reducer: { (a: Int, b: Int) -> Int in
    return a + b
})
// Inferring Type From Context
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in
    return a + b
})
// Shorthand Argument Names
reduce(numbers: [1, 2, 3, 4], reducer: {
    return $0 + $1
})
// Implicit Returns from Single-Expression Closures
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in
    a + b
})
reduce(numbers: [1, 2, 3, 4], reducer: { a, b in a + b })
reduce(numbers: [1, 2, 3, 4], reducer: {
    $0 + $1
})
reduce(numbers: [1, 2, 3, 4], reducer: { $0 + $1 })

/*:
 
 ## Trailing Closures
 
 If you need to pass a closure expression to a function as the function's final argument and 
 the closure expression is long, it can be useful to write it as a trailing closure instead.
 
 A trailing closure is written after the function call's parentheses, even though it is still
 an argument to the function. When you use the trailing closure syntax, you don’t write 
 the argument label for the closure as part of the function call.
 
 */
reduce(numbers: [1, 2, 3, 4]) { (a: Int, b: Int) -> Int in
    return a + b
}
// Or even ...
reduce(numbers: [1, 2, 3, 4]) { a, b in return a + b }
reduce(numbers: [1, 2, 3, 4]) { return $0 + $1 }
reduce(numbers: [1, 2, 3, 4]) { $0 + $1 }

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Capturing Values
 
 A closure can capture constants and variables from the surrounding context 
 in which it is defined. The closure can then refer to and modify the values 
 of those constants and variables from within its body, 
 even if the original scope that defined the constants and variables no longer exists.
 
 */
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let oneStepIncrementer = makeIncrementer(forIncrement: 1)
let tenStepsIncrementer = makeIncrementer(forIncrement: 10)

oneStepIncrementer()
oneStepIncrementer()
oneStepIncrementer()
tenStepsIncrementer()
oneStepIncrementer()
tenStepsIncrementer()
/*:
 
 We can find that there are different `runningTotal` vairables **captured** by the two incremeneter.
 So their value are separated and won't affect each other.
 
 And also, although the scope of `runnintTotal` is end, but it still avaialbe
 inside the incremeneter closure. _(Because it has been captured by closures.)_
 
 */

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
