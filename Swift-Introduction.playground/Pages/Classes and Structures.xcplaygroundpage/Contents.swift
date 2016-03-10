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

import Foundation

class SomeClass {
    var someProperty: Int = 0
    func someMethod(arg1: String, arg2: Int) -> Double {
        return 2.0 + Double(self.someProperty)
    }
    func anotherMethod() -> Double {
        return self.someMethod("", arg2: self.someProperty)
    }

    static func classMethod() {
    }
    static let someClassProperty = 42
}

struct SomeStructure {
    var someProperty: Int = 0
    func someMethod(arg1: String, arg2: Int) -> Double {
        return 2.0 + Double(self.someProperty)
    }
    func anotherMethod() -> Double {
        return self.someMethod("", arg2: self.someProperty)
    }

    static func staticMethod() {
    }
}

let classInstance = SomeClass()
classInstance.anotherMethod()
SomeClass.classMethod()
SomeClass.someClassProperty

let structInstance = SomeStructure()
structInstance.someMethod("", arg2: 42)
SomeStructure.staticMethod()

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
    var origin = Point()  // Left-up
    var size = Size()

    // A computed property which defines `get` and `set` methods manually
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

    // A readonly property is which has only `get` method
    var diagonalLength: Double {
        get {
            let rightBottomPoint = Point(x: origin.x + size.width, y: origin.y + size.width)
            let xDiff = abs(origin.x - rightBottomPoint.x)
            let yDiff = abs(origin.y - rightBottomPoint.y)
            return sqrt(xDiff*xDiff + yDiff*yDiff)
        }
    }

    // `get` could be ommited for a getter-only computed property
    var area: Double {
        return self.size.width * self.size.height
    }
}

var rectangle = Rect()
rectangle.origin = Point(x: 10.0, y: 20.0)
rectangle.size = Size(width: 40.0, height: 40.0)
(rectangle.center.x, rectangle.center.y)
rectangle.center = Point(x: 0, y: 0)
(rectangle.origin.x, rectangle.origin.y)

//: ## Subscripts
//:
//: Subscripts are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts 
//: to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you
//: access elements in an Array instance as someArray[index] and elements in a Dictionary instance as 
//: someDictionary[key].

class LinkedListNode<T> {  // LinkedList should be reference based ... use `class`
    var nextNode: LinkedListNode? = .None
    var content: T

    init(content: T) {
        self.content = content
    }

    subscript(steps: Int) -> LinkedListNode? {
        guard steps >= 0 else {
            print("Steps should equals to or be greater than 0")
            return nil
        }
        var resultNode: LinkedListNode? = self
        for _ in 0..<steps {
            resultNode = resultNode?.nextNode
        }
        return resultNode
    }

    subscript(indexes: Int...) -> [T?] {
        var result = [T?]()
        for index in indexes {
            result.append(self[index]?.content)
        }
        return result
    }

    static func createLinkedList(items: T...) -> LinkedListNode<T>? {
        guard items.count > 0 else {
            print("Should provide at least one item.")
            return nil
        }

        let resultNode = LinkedListNode(content: items.first!)
        var lastNode = resultNode
        for item in items[1..<items.count] {
            let node = LinkedListNode(content: item)
            lastNode.nextNode = node
            lastNode = node
        }
        return resultNode
    }
}

let linkedList = LinkedListNode.createLinkedList(1, 2, 3, 4)!
linkedList[0]?.content
linkedList[1]?.content
linkedList[2]?.content
linkedList[3]?.content
linkedList[4]?.content

linkedList[0, 1, 5]

//: --------------------------------------------------------------------------------------------------------------------
//: ## Class Inheritence: Introduction
//:
//: 1. Use _colon_ (`:`) to specify the base class of this class.
//: 2. Use `super` to call superclass and add `override` before methods which would be overriden.
//:
//: Note that Swift is a single-inheritance language, like Java. Also classes in Swift don't require to have a base 
//: class.
//:

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

//: --------------------------------------------------------------------------------------------------------------------
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
//: ## Type Casting
//:
//: _Conversion_ usually means converting an object of type to another type. The implementation and memory storage are  
//: different from original one. Like converting from `Int` to `String`. Instead, **Casting** means just treating
//: the same memory storage as another type. The underneath implementation and storage are still the same.
//: 
//: In Swift, we use `as` to cast types between class instances. Due to the **Type Safety** feature, Swift doesn't allow
//: you to perform casting to unrelated types.
//:
//: Since `structures` doesn't the inheritance concept, they could not be casted. (And so to all built-in types)
//: Like:

let arr: [Int] = []
//let str = arr as String  // ERROR: Uncomment to see error message

//: For struct types, only _literals_ could be casted.

let fiveInt = 5
let fiveDouble = 5 as Double
let oddArray = [1, 3, 5, 7, 9]
let oddSet = [1, 3, 5, 7, 9] as Set<Int>

// NOTE: Only literals themselves, but not types which could be created by literals
let i: Int = 5
//let j: Double = i as Double  // Error: Uncomment to see what you get

//:
//: But for classes, who have the inheritance concept, it's possible to cast between types.
//:

class Animal {
    var name: String

    func walk() -> String {
        return "walk"
    }

    init(name: String) {
        self.name = name
    }
}

class 🐶: Animal {
    override func walk() -> String {
        return "dog walk"
    }
}

class 🐱: Animal {
    override func walk() -> String {
        return "cat walk"
    }
}

class 🍜 {}

let kikiCat = 🐱(name: "kiki")
let pupuDog = 🐶(name: "pupu")
let liliAnimal: Animal = 🐱(name: "lili")
let fupaAnimal: Animal = 🐶(name: "fupa")
let guguAnimal: Animal = 🐱(name: "gugu")

//: ### Upcast
//: Cast from a subclass to superclass
let kikiAnimal = kikiCat as Animal

//: ### Downcast
//: Cast from a superclass to subclass. The result would be failed and hence would be an optional. 
//: (The _Type Safety_ feature)

//let guguCat = guguAnimal as 🐱  // ERROR: Uncomment to see the error message
let liliCat = liliAnimal as? 🐱
let liliDog = liliAnimal as? 🐶
//let fupaCat = fupaAnimal as! 🐱  // ERROR: Uncomment to see the error message
let fupaDog = fupaAnimal as! 🐶

//: ### Unrelated cast
//: It always fails. (The _Type Safety_ feature)
//let guguRamen = guguAnimal as 🍜  // ERROR: Uncomment to see the error message
//let guguRamen = guguAnimal as? 🍜  // ERROR: Uncomment to see the error message

//: ### Dynamic dispatch
//:
//: Swift is a **dynamic dispatch** language. Hence even if you cast an instance of `🐱` to `Animal`, the 
//: implementation `walk` method of the casted variable, in this case: `kikiAnimal`, is still the one of `🐱`.
//:

kikiCat.walk()
kikiAnimal.walk()

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
//:
//: References:
//: * http://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
//:
