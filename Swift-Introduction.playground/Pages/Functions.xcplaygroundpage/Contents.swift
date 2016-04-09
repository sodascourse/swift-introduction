//: # Functions
//:
//: Swift’s unified function syntax is flexible enough to express anything from a simple C-style function with no 
//: parameter names to a complex Objective-C-style method with local and external parameter names for each parameter.
//:
//: Parameters can also:
//: 1. provide default values to simplify function calls
//: 2. be passed as in-out parameters, which modify a passed variable once the function has completed its execution.
//:
//: Every function in Swift has a type, consisting of the function’s **parameter types** and **return type**. You can 
//: use this type like any other type in Swift, which makes it easy to pass functions as parameters to other functions, 
//: and to return functions from functions. Functions can also be written within other functions to encapsulate useful 
//: functionality within a nested function scope. (i.e. Functions are _first-class citizens_ in Swift)
//:

import Foundation

//:
//: ## Declare a function
//:
//: ### Return Type
//:
//: The return type of this function is defined with the return arrow `->` (a hyphen followed by a right angle bracket), 
//: which is followed by the name of the type to return. For functions which doesn't return anything, the return type
//: annotation could be omitted.
//:

func returnSomething() -> String { return "XD" }
func noop1() {}
func noop2() -> Void {}

//: ### Multiple return type
//:
//: which is implemented by `tuple`

func getHttpStatus1() -> (Int, String) {
    return (200, "OK")
}

func getHttpStatus2() -> (code: Int, error: String) {
    return (200, "OK")
}
let (errCode, errMsg) = getHttpStatus1()

//: ### Arguments Type
//:
//: The type of arguments could be declared like the way variables used. (Put a `colon, :` with type after the argument 
//: name)

func sayHello(personName: String) -> String {
    return "Hello, \(personName)!"
}

//: For functions with multiple arguments, arguments are separated by commas like:

func add(a: Int, b: Int) -> Int {
    return a + b
}

//:
//: Function parameters have both **an external parameter name** and **a local parameter name**. An external parameter 
//: name is used to label arguments passed to _a function call_. A local parameter name is used in 
//: _the implementation of the function_. By using external names, the usage and intention of functions could be more 
//: clear than other languages.

// The way in Java and C++
createRectangle(0.0, 10.0, 20.0, 30.0)
// The way in Swift
createRectangle(originX: 0.0, originY: 10.0, width: 20.0, height: 30.0)

//:
//: By default, the first parameter omits its external name, and the second and subsequent parameters use their local 
//: name as their external name.
//:
//: More clearly:
//: 1. The first argument `a` has a local name called `a`.
//: 2. The second argument `b` has a local name called `b`.

func add1(a: Int, b: Int) -> Int {
    return a + b
}

//: 1. The first argument `a` doesn't have an external name.
//: 2. The second argument `b` has an external name also called `b`.
//:
//: So to call this `add1` function, you have to call it like:

add1(1, b: 2)

//: You write an external parameter name before the local parameter name it supports, separated by a space.
//:
//: ![](greeting-func.png)

func greeting(greetingMessage: String,
    person personName: String) -> String {
    return "Hi, \(personName). \(greetingMessage)"
}
greeting("Nice to meet you", person: "Peter")

func sendGift(to personName: String,
    gift giftName: String) -> String {
    return "Hi, \(personName). You have got \(giftName) as a gift."
}
sendGift(to: "Samantha", gift: "A Swift programming tutorial")

//: But sometimes, you may want the external name second and further arguments ommitted. Then use _underscore_ (`_`)
//: as their external name. Like:

func divide(a: Int, _ b: Int) -> Double {
    guard b != 0 else {
        print("the second argument should not be zero.")
        return Double.infinity
    }
    return Double(a) / Double(b)
}
divide(4, 8)

//:
//: ### Function name
//:
//: The full name of a function is identified by both the function name and arguments' external names.
//:
//: * `func returnSomething() { ... }` has the full name: `returnSomething()`
//: * `func sayHello(personName: String) -> String { ... }` has the full name: `sayHello(_:)`. Since by default the 
//:   external name of the first argument is ommited.
//: * `func add(a: Int, b: Int) -> Int` has the full name: `add(_:b:)`. Because by default, the external name of second
//:   argument is the same as its local name.
//: * `func greeting(greetingMessage: String, person personName: String) -> String` has the full name: 
//:   `greeting(_:person:)`. The external name of the second argument is specified as `person`.
//: * `func sendGift(to personName: String, gift giftName: String) -> String` has the full name:
//:   `sendGift(to:gift)`. Since the external name of first argument is specified explicitly too.

//: ### Variadic Parameters

func average(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
average(1, 2, 3, 4, 5)

//: ### Arguments with Generic Types

func randomAccess<T>(items: T...) -> T {
    let itemsCount = UInt32(items.count)
    let randomIndex = Int(arc4random_uniform(itemsCount))
    return items[randomIndex]
}

let randomGreetingString = randomAccess("Hello", "Hi", "How are you?", "Nice to meet you")
let randomLuckyNumber = randomAccess(1, 3, 42, 51, 17, 24, 33)

//:
//: NOTE: Use _option+click_ to see the type of `randomGreetingString` and `randomLuckyNumber` infered by Swift.

//: ### Default value of Arguments
//:
//: Swift also supports to define a default value for each arguments. Like:

func sum(numbers: [Int], base: Int = 0) -> Int {
    var result = base
    for number in numbers {
        result += number
    }
    return result
}

sum([1, 2, 3])
sum([1, 2, 3], base: 10)

//: ### In-Out Arguments

func mySwap<T>(inout a: T, inout _ b: T) {
    let temp: T = b
    b = a
    a = temp
}

var firstNumber: Int = 1, secondNumber: Int = 2
mySwap(&firstNumber, &secondNumber)

//: --------------------------------------------------------------------------------------------------------------------
//: --------------------------------------------------------------------------------------------------------------------
//: ## Nested Functions

func step1(currentIndex: Int, backwards: Bool) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }

    if backwards {
        return stepBackward(currentIndex)
    } else {
        return stepForward(currentIndex)
    }
}

func step2(currentIndex: Int, backwards: Bool) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }

    return (backwards ? stepBackward : stepForward)(currentIndex)
}

//: --------------------------------------------------------------------------------------------------------------------
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Type of functions
//: Every function has a specific function type, made up of the parameter types and the return type of the function.
//:

func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}

let add: (Int, Int) -> Int = addTwoInts

func noReturnValueFunction() {}
let noop3: () -> Void = noReturnValueFunction

//: In Swift, functions are **first-citizen types**. This means functions are able to used as variable types, function 
//: arguments types, and function return types.
//:
//: ![](my-filter-function.png)

/**
Filter values by a filter function

- parameter items:  source array containing all items
- parameter filter: A function/closure which would be passed an item in, and should return `true` when this item
                    should be reserved.

- returns: filtered array
*/
func myFilterFunction<T>(items: [T], filter: (T) -> Bool) -> [T] {
    var result = [T]()
    for item in items {
        if filter(item) {
            result.append(item)
        }
    }
    return result
}

func oddFilter(number: Int) -> Bool {
    return number % 2 == 1
}
myFilterFunction([1, 2, 3, 4, 5], filter: oddFilter)

typealias IntFilterType = (Int) -> Bool
let theFilterFunction: ([Int], IntFilterType) -> [Int] = myFilterFunction

//: --------------------------------------------------------------------------------------------------------------------
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Overloading
//:
//: Swift supports function overloading which allows you use the same function name but with different arguments types

func addOverloading(a: Int, _ b: Int) -> (Int, String) {
    return (a + b, "Using Int")
}

func addOverloading(a: Double, _ b: Double) -> (Double, String) {
    return (a + b, "Using Double")
}

addOverloading(1, 1)
addOverloading(1.0, 1.0)

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
