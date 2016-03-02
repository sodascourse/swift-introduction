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

func bubbleSort<T>(var items: [T], sorter: (T, T) -> Bool) -> [T] {
    let itemsCount = items.count

    outerWhile: while true {
        var swapped = false
        for i in 1..<itemsCount {
            if sorter(items[i], items[i - 1]) {  // should return `true` when items[i] is greater than items[i-1]
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

//: To instantiate closures, as anonymous functions, just like:

let unorderedNumbers = [9, 1, 2, 5, 4, 6, 0, 7, 8, 3]

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

// And even

bubbleSort(unorderedNumbers, sorter: { a, b in a > b })

//: Arguments could also be denoted as their index, like:

bubbleSort(unorderedNumbers, sorter: { $0 > $1 })  // $0: a, $1: b

//: Further, it's okay to use operators as closures (same function type)

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
//: Check following examples:

func makeIncrementer1(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {  // This function, as a closure, captures `runningTotal`
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

func makeIncrementer2(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    return { () -> Int in  // This closure captures `runningTotal`
        runningTotal += amount
        return runningTotal
    }
}

let tenIncrementer = makeIncrementer1(forIncrement: 10)
let fiveIncrementer = makeIncrementer1(forIncrement: 5)
tenIncrementer()
tenIncrementer()
fiveIncrementer()
fiveIncrementer()
fiveIncrementer()
tenIncrementer()

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
