//: # Closures
//:
//: Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in 
//: Swift are similar to _blocks_ in C and Objective-C and to _lambdas_ in other programming languages.
//:
//: Closures can **capture and store references to any constants and variables** from the context in which they are
//: defined. This is known as closing over those constants and variables, hence the name “closures”. Swift handles all 
//: of the memory management of capturing for you.
//:
//: _Functions_ are actually special cases of closures, which they don't capture any references. **Global functions**,
//: which are functions declared at the root level, usually don't capture values. **Nested functions**, which are 
//: defined in a global function and maybe used as variables, may capture values and actually are closures.
//:
//: The closure syntax is like anonymous functions. The body of a closure is surrounded by _curly braces_ (`{}`).
//: the arguments list and return type are defined before `in` keyword. After the `in` keyword, you write lines of code
//: which is your closure body.
//:

func addFunction(a: Int, b: Int) -> Int {
    return a + b
}

let addClosure = { (a: Int, b: Int) -> Int in
    return a + b
}

//:
//: > NOTE: Use _"option+click"_ to see the type of `addClosure`. It would be the same as the type of `addFunction`
//:
//: The way to _call_ a `closure` is the same as _functions_. Only that by default, arguments of closures don't have 
//: external names.
//:

addFunction(1, b: 2)
addClosure(1, 2)

//: ## Using closures
//:
//: To use closures in your code, actually it's the same as function types. Like:

/**
A bubble sort function

- parameter items:  Items to be sorted via this bubble sort function
- parameter sorter: A function/closure which would be passed 2 items from the source array in.
                    This function/closure should return `true` when the first parameter is greater than second one.

- returns: sorted items
*/
func bubbleSort<T>(var items: [T], sorter: (T, T) -> Bool) -> [T] {
    let itemsCount = items.count

    outerWhile: while true {
        var swapped = false
        for i in 1..<itemsCount {
            if sorter(items[i], items[i - 1]) {  // should return `true` when items[i] is greater than items[i-1]
                // Swap items
                let temp = items[i]
                items[i] = items[i - 1]
                items[i - 1] = temp

                swapped = true
            }
        }
        if !swapped {
            break outerWhile
        }
    }
    return items
}

let unorderedNumbers = [9, 1, 2, 5, 4, 6, 0, 7, 8, 3]

//: First, we could create a function as the sorter
//: 
//: By the documentation of the `bubbleSort` function, this sorter function should return `true` when a is greater than
//: b.

func intSorter(a: Int, b: Int) -> Bool {
    return a > b
}

bubbleSort(unorderedNumbers, sorter: intSorter)

//: But it would be quite tedious if we have to declare a function first each time when we just want to pass it as 
//: an argument of a function. For this case, closures, as anonymous functions, are better and easier to use. Like:

bubbleSort(unorderedNumbers, sorter: { (a: Int, b: Int) -> Bool in
    return a > b
})

//: Types used in closure could be infered automatically too

bubbleSort(unorderedNumbers, sorter: { (a, b) in
    return a > b
})

// And even

bubbleSort(unorderedNumbers, sorter: { a, b in
    return a > b
})

//: If the body of this closure is only a single line which returns a value

bubbleSort(unorderedNumbers, sorter: { a, b in
    a > b
})

// And even the parentheses could be omitted too.

bubbleSort(unorderedNumbers, sorter: { a, b in a > b })

//: Arguments could also be denoted with a dollar sign (`$`) and their index, like:

bubbleSort(unorderedNumbers, sorter: { $0 > $1 })  // $0: a, $1: b

//: Further, it's okay to use operators as closures (with same function type)

bubbleSort(unorderedNumbers, sorter: >)

//: ### Trailing Closures
//:
//: If you need to pass a closure expression to a function as the function’s final argument and the closure expression
//: is long, it can be useful to write it as a trailing closure instead. A trailing closure is a closure expression 
//: that is written outside of (and after) the parentheses of the function call it supports

bubbleSort(unorderedNumbers) { (a: Int, b: Int) -> Bool in
    return a > b
}

//: ## Capturing Values
//:
//: In the `bubbleSort` example, we demonstrate why we say closures are like anonymous functions. In this case,
//: we would show you the behavior that closures would capture values.
//:
//: Check following examples:

/**
Create an incrementer

- parameter incrementStep: The step to increase each time when this increamenter being called

- returns: An incrementer with specified step.
*/
func makeIncrementer(forIncrement incrementStep: Int) -> () -> Int {
    var currentStep = 0
    // Returns a closure
    return { () -> Int in
        currentStep += incrementStep  // `currentStep` is actually a value not in the scope of this closure.
        return currentStep
    }
}

//: 
//: The above function returns a closure which **doesn't accept any arguments but returns an Int**.
//: Each incrementer knows it's last step and returns new step when it's being called.

let tenIncrementer = makeIncrementer(forIncrement: 10)
let fiveIncrementer = makeIncrementer(forIncrement: 5)

tenIncrementer()   // 10
tenIncrementer()   // 20
fiveIncrementer()  //  5
fiveIncrementer()  // 10
fiveIncrementer()  // 15
tenIncrementer()   // 30

//: As you seen, each incrementer has its own `currentStep` value. (Or these 2 incrementer would interfere each other.)
//: Also, the `currentStep` is not declared in the scope of the closure to be returned. But it's still captured and kept
//: by the closure.

//: **Nested functions** could capture values too. Only **Global functions** don't capture any values.
//: So the `makeIncrementer` could be also written with nested functions, like:

func anotherMakeIncrementer(forIncrement incrementStep: Int) -> () -> Int {
    var currentStep = 0
    // Returns a function
    func incrementer() -> Int {
        currentStep += incrementStep  // `currentStep` is actually a value not in the scope of this closure.
        return currentStep
    }
    // Note there's no `()` after `incrementer`. We are returning this function not its return value.
    return incrementer
}

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
