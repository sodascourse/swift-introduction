//: # Optional
//:
//: You use _optionals_ in situations where a value may be **absent**. An optional says:
//: * There is a value, and it equals x
//: * There isn’t a value at all
//:
//: NOTE: The concept of optionals doesn’t exist in C or Objective-C
//:

//: Here’s an example of how optionals can be used to cope with the absence of a value. Swift's Int type has an 
//: initializer which tries to convert a String value into an Int value. 
//:
//: However, not every string can be converted into an integer. The string "123" can be converted into the numeric 
//: value 123, but the string "ABC" does not have an obvious numeric value to convert to.

let optionInt1: Int? = Int("123")
let optionInt2: Int? = Int("ABC")

//: ## Optional are actually enums

let optionInt3: Int? = .None

//: NOTE: Use "_command+click_" to see the definition of `.None`
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Work with optionals
//:

let someString = "123"

if Int(someString) == nil {
    print("It's not a numeric string. Got \(someString)")
}

//: ### Forced Unwrapping
//:
//: Once you’re sure that the optional does contain a value, you can access its underlying value by adding an 
//: exclamation mark (!) to the end of the optional’s name. The exclamation mark effectively says, “I know that this 
//: optional definitely has a value; please use it.” This is known as forced unwrapping

let optionalTwelve = Int("12")  // Use "_option+click_" to see the type
let twelve = Int("12")!  // Note the exclamation mark `!`. Use "_option+click_" to see the type

//: ### Optional Binding
//:
//: You use optional binding to find out whether an optional contains a value, and if so, to make that value available 
//: as a temporary constant or variable.

if let someIntValue = Int(someString) {
    print(someIntValue)
} else {
    print("It's not a numeric string. Got \(someString)")
}

func square(numericString: String) -> String? {
    guard let someIntValue = Int(numericString) else {
        print("Cannot do something ... expected a numeric string")
        return nil
    }
    return "\(someIntValue*someIntValue)"
}

let strings = ["1", "42", "ABC", "56"]
var sum = 0
var stringsIndex = 0
while let number = Int(strings[stringsIndex++]) {
    sum += number
}
sum

//: ### Implicitly Unwrapped Optionals
//:
//: Sometimes it is clear from a program's structure that an optional will always have a value, after that value is 
//: first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it 
//: is accessed, because it can be safely assumed to have a value all of the time.
//:
//: You can think of an implicitly unwrapped optional as giving permission for the optional to be unwrapped 
//: automatically whenever it is used.

struct SomeStruct {
    var _someLazyLoadedString: String!
    var someLazyLoadedString: String {
        mutating get {
            if _someLazyLoadedString == nil {
                self.lazyLoad()
            }
            return _someLazyLoadedString
        }
    }

    var lazyLoaded: Bool = false
    mutating func lazyLoad() {
        if !self.lazyLoaded {
            self.lazyLoaded = true
            _someLazyLoadedString = "Heavily Loaded"
        }
    }

    init() {}
}

//: NOTE: 
//: 1. Change the type of `someLazyLoadedString` to `String?` to see what happened
//: 2. Change the type of `someLazyLoadedString` to `String` and comment the `mutating getter` to see what happened
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Optional Chaining
//: 
//: Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that 
//: might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the 
//: optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and 
//: the entire chain fails gracefully if any link in the chain is nil.

struct SomeStructA {
    var b: SomeStructB?
}

struct SomeStructB {
    var value: Int
}

let a: SomeStructA? = .None
let b: SomeStructB? = SomeStructB(value: 42)
let finalValue1 = a?.b?.value  // Use "_option+click_" to see the tpye of `finalValue1`
let finalValue2 = b?.value  // Use "_option+click_" to see the tpye of `finalValue2`
let finalValue3 = b!.value  // Use "_option+click_" to see the tpye of `finalValue3`

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)