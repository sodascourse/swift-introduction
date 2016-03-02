//: # Classes and Structures
//:
//: Classes and structures are general-purpose, flexible constructs that become the building blocks of your program’s 
//: code. You define _properties_ (data, members, variables) and _methods_ (functions) to add functionality to your 
//: classes and structures by using exactly the same syntax as for constants, variables, and functions.
//:
//: Unlike Objective-C, Swift does not require you to create separate interface and implementation files for custom 
//: classes and structures. In Swift, you define a class or a structure in a single file, and the external interface to 
//: that class or structure is automatically made available for other code to use.
//:
//: Swift provides both `class` and `struct` for OOP usage. They have many things in common:
//: * Define properties to store values
//: * Define methods to provide functionality
//: * Define subscripts to provide access to their values using subscript syntax (to be mentioned in the future)
//: * Define initializers to set up their initial state
//: * Be extended to expand their functionality beyond a default implementation (extension,
//:   to be mentioned in the future classes)
//: * Conform to protocols to provide standard functionality of a certain kind (to be mentioned in the future classes)
//:
//: Classes have additional capabilities that structures do not:
//: * Inheritance enables one class to inherit the characteristics of another.
//: * Type casting enables you to check and interpret the type of a class instance at runtime.
//: * Deinitializers enable an instance of a class to free up any resources it has assigned.
//: * Reference counting allows more than one reference to a class instance.
//:

class SomeClass {
    var someProperty: Int = 0
    func someMethod(arg1: String, arg2: Int) -> Double {
        return 2.0 + Double(self.someProperty)
    }
    func anotherMethod() -> Double {
        return self.someMethod("", arg2: self.someProperty)
    }
}

struct SomeStructure {
    var someProperty: Int = 0
    func someMethod(arg1: String, arg2: Int) -> Double {
        return 2.0 + Double(self.someProperty)
    }
    func anotherMethod() -> Double {
        return self.someMethod("", arg2: self.someProperty)
    }
}

//:
//: NOTE: Use `self` to reference current instance
//:
//: ---
//:
//: ## Instances

let someInstanceOfClass = SomeClass()
let someInstanceOfStructure = SomeStructure()

someInstanceOfClass.someProperty = 42
someInstanceOfStructure.someProperty

someInstanceOfStructure.someMethod("XD", arg2: 42)

//: ## Properties - Introduction: Computed Properties
//:
//: Computed properties do not actually store a value. Instead, they provide a getter and an optional setter to retrieve 
//: and set other properties and values indirectly.

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    var area: Double {  // a getter-only computed property
        return self.size.width * self.size.height
    }
}

var rectangle = Rect()
rectangle.origin = Point(x: 10.0, y: 20.0)
rectangle.size = Size(width: 40.0, height: 40.0)
(rectangle.center.x, rectangle.center.y)
rectangle.center = Point(x: 0, y: 0)
(rectangle.origin.x, rectangle.origin.y)

//: ## Class Inheritence: Introduction
//:
//: Use `super` to call superclass and add `override` before methods which would be overriden.

class BaseClass {
    func someMethod() -> String {
        return "XD"
    }
}

class SubClass: BaseClass {
    override func someMethod() -> String {
        return super.someMethod() + "~"
    }
}

//: ## Struct mutation
//:
//: By default, the properties of a value type cannot be modified from within its instance methods. However, if you 
//: need to modify the properties of your structure or enumeration within a particular method, you can opt in to 
//: mutating behavior for that method.

struct Therometer {
    var temperature: Double

    init(temperature: Double) {
        self.temperature = temperature
    }

    mutating func addByDegree(degree: Double) {
        self.temperature += degree
    }
}

//: ## Reference Types and Value Types
//:
//: A **value type** is a type whose value is _copied_ when it is _assigned_ to a variable or constant, or when it is 
//: _passed to a function_. Like the one in C++, without using `new`.
//:
//: Structures are value types. All of the basic types in Swift, like integers, floating-point numbers, Booleans, 
//: strings, arrays, dictionaries, and sets, are implemented as structures behind the scenes and are value types.
//:
//: This means that any structure instances you create, and any value types they have as properties, are always copied 
//: when they are passed around in your code.
//:
//: Also, the mutability of value types are based on how they are declared. As we mentioned before, if you use `let`
//: to decalare a constant for value types, they would be immutable. Use `var` for mutable value types.
//:
//: Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they 
//: are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.
//:
//: Classes are reference types, like the one in Objective-C, Java, and Python.
//:
//: > NOTE: The description above refers to the "copying" of strings, arrays, and dictionaries. The behavior you see in 
//:         your code will always be as if a copy took place. However, Swift only performs an actual copy behind the 
//:         scenes when it is absolutely necessary to do so. Swift manages all value copying to ensure optimal 
//:         performance, and you should not avoid assignment to try to preempt this optimization.

//: ## Identity Operators
//:
//: Because classes are reference types, it is possible for multiple constants and variables to refer to the same 
//: single instance of a class behind the scenes. (The same is not true for structures and enumerations, because they 
//: are always copied when they are assigned to a constant or variable, or passed to a function.)
//:
//: In Swift, we use `===` and `!==` to find out if two variables refer to exactly the same instance of a class.

class Fruit {
    var name: String
    init(name: String) {
        self.name = name
    }
}

func ==(fruitA: Fruit, fruitB: Fruit) -> Bool {
    return fruitA.name == fruitB.name
}

let apple1 = Fruit(name: "Apple")
let apple2 = apple1
let apple3 = Fruit(name: "Apple")

apple1 == apple2
apple1 == apple3
apple1 === apple2
apple1 === apple3

//: ## Choosing Between Classes and Structures
//:
//: Structure instances are always **passed by value**, and class instances are always **passed by reference**. This
//: means that they are suited to different kinds of tasks.
//:
//: Structures are preferable if they are relatively small and copiable because copying is way safer than having 
//: multiple reference to the same instance as happens with classes. This is especially important when passing around a 
//: variable to many classes and/or in a multithreaded environment. With Structs there is no need to worry about memory 
//: leaks or multiple threads racing to access/modify a single instance of a variable.
//:
//: Using `Protocols`, especially with **protocol extensions** where you can provide implementations to protocols, 
//: allows you to eliminate the need for classes to achieve this sort of behavior. Also this is why Apple wants to 
//: promote a new concept called "Protocol-Oriented Programming" in Swift.
//:

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
//:
//: References:
//: * http://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
//: