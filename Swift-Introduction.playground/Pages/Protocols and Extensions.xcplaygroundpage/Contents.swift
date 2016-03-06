//: # Protocols and Extensions
//:
//: Protocols and Extensions makes the Objective-C and Swift language become very dynamic and flexible. They make your
//: code more reusable, abstract, and loss-coupled.
//: In Swift, the extensions concept are more enhanced and powerful than Objective-C.

import Foundation

//:
//: ## Procotols
//:
//: A **protocol** defines a _blueprint_ of methods, properties, and other requirements that suit a particular task or 
//: piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual 
//: implementation of those requirements. Any type that satisfies the requirements of a protocol is said to 
//: **conform to that protocol**.
//:
//: > NOTE: `protocol` and `interface` in Java are the same concepts.
//:
//: In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement 
//: some of these requirements or to implement additional functionality that conforming types can take advantage of.
//:

protocol SomeProtocol {
    func someMethod()
    mutating func someMutatingMethod()
    static func someStaticMethod()

    var someRequiredReadonlyMemeber: Int { get }
    var someRequiredReadwriteMemeber: Int { get set }

    init(someInitArgument: Int)
}

//:
//: Take the `Animal` example for instance, the `Animal` could be just a `protcol` which defines methods all animals
//: would do. But actually the implementation of these methods are different and implemented by each animal subclasses.
//:
//: A class/struct/enum/procotol also uses _colon_ (`:`) to specify protocols it conforms to. Types could adopt to 
//: multiple protocols, just use _commas_ (`,`) to separate them.
//:

protocol Animal {
    func walk() -> String
}

protocol 外星人 {
    var 母星: String { get }
}

protocol 來自喵星: 外星人 {
    var 喵: Double { get }
}

class 🐶: Animal {
    func walk() -> String {
        return "dog walk"
    }
}

struct 🐱: Animal, 來自喵星 {
    var 母星: String = "喵星"
    var 喵: Double = 42

    func walk() -> String {
        return "cat walk"
    }
}

struct 🐟: Animal {
    func walk() -> String {
        return "fish doesn't walk"
    }
}

//: ### Protocol as Types
//:
//: You can use a protocol in many places where other types are allowed, including:
//: * As a parameter type or return type in a function, method, or initializer
//: * As the type of a constant, variable, or property
//: * As the type of items in an array, dictionary, or other container

func makeAnimalWalk(animal: Animal) {
    print(animal.walk())
}

//: ### Generics
//:
//: Protocols don't support generics. Instead, you could associate a type for generic using.

protocol Adder {
    typealias AdderValueType  // The **associated type**
    func add(a: AdderValueType, _ b: AdderValueType) -> AdderValueType
}

struct IntCalculatorCore: Adder {

    typealias AdderValueType = Int

    func add(a: AdderValueType, _ b: AdderValueType) -> AdderValueType {
        return a + b
    }
}

IntCalculatorCore().add(1, 2)

//: Generic types of a type are also associated types. So if the name of a associated type is the same as generic name,
//: it could be ommited.

protocol RandomlyAccess {
    typealias Element
    var random: Element { get }
}

struct Pair<Element>: RandomlyAccess {
    var first: Element
    var second: Element

    var random: Element {
        return Int(arc4random_uniform(2)) == 0 ? self.first : self.second
    }
}

let pair = Pair(first: 42, second: 24)
pair.random

//: In Swift, collections like `Array` and `Set` usually use `Element` as content generic type name. The one like
//: `Dictionary` uses `Key` and `Value`.

//: --------------------------------------------------------------------------------------------------------------------
//: ## Extensions
//:
//: Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the 
//: ability to extend types for which you do not have access to the original source code.
//:
//: Extensions can:
//: * Add computed properties and computed type properties
//: * Define instance methods and type methods
//: * Provide new initializers
//: * Define subscripts (Use `[]` to access content like Array)
//: * Define and use new nested types
//: * Make an existing type conform to a protocol
//:
//: Extensions are more flexible than subclassing. The functions/methods added to a class/structure/protocol via 
//: extensions are available to all instances of themselves and subclasses. Hence, for instance, you could use this way 
//: to add new methods to built-in types like array.
//:
//: Besides above reasons, extensions are also great to be used for grouping/organizing code.
//:

extension Array {
    var middle: Element? {  // `Element` is a Generic symbol defines in `Array` declaration. (Use "cmd+click" to see)
        guard !self.isEmpty else {
            return nil
        }
        return self[self.count/2]
    }

    var random: Element? {
        guard !self.isEmpty else {
            return nil
        }
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomIndex]
    }
}

let numberArray1 = [1, 2, 3]
numberArray1.middle
numberArray1.random

let emptyIntArray1 = [Int]()
emptyIntArray1.middle
emptyIntArray1.random

//:
//: An extension can extend an existing type to make it adopt one or more protocols. Where this is the case, the 
//: protocol names are written in exactly the same way as for a class or structure
//:

protocol ToString {
    var toString: String { get }
}

extension Array: ToString {  // Make `Array` conforms to some protocols via extension
    var toString: String {
        var resultString = "toString: ["
        for (index, item) in self.enumerate() {
            resultString += String(item)
            if index != self.count - 1 {
                resultString += ", "
            }
        }
        resultString += "]"
        return resultString
    }
}

let numberArray2 = [1, 2, 3]
let floatArray1 = [3.1, 4.2, 5.6]

let outputables: [ToString] = [numberArray2, floatArray1]
for output in outputables {
    print(output.toString)
}

//: Extensions could also provide default implementation for protocols. Use `where` to specify adopted classes by the
//: way used to constraint generic types.

protocol GroundAnimal {
}

protocol MovableAnimal {
    func move(steps: Int) -> String
    func turnBack() -> String
}

extension MovableAnimal {
    func move(steps: Int) -> String {
        return "move for \(steps) steps."
    }
}

extension MovableAnimal where Self: GroundAnimal {
    func move(steps: Int) -> String {
        return "walk for \(steps) steps."
    }
    func turnBack() -> String {
        return "walk for turning back."
    }
}

extension 🐶: GroundAnimal, MovableAnimal {
}
extension 🐱: GroundAnimal, MovableAnimal {
}
extension 🐟: MovableAnimal {
    func turnBack() -> String {
        return "swim for turning back."
    }
}

🐶().move(20)
🐶().turnBack()
🐱().move(20)
🐱().turnBack()
🐟().move(20)
🐟().turnBack()

//:
//: NOTE: Comment the extensions of `MovableAnimal` protocol to see what error message you get.
//:
//: --------------------------------------------------------------------------------------------------------------------
//: 
//: ## Swift Built-in Protocols and Protocol-Oriented Programming (POP)
//:
//: Since you know that most built-in types in Swift are actually value types which is defined by `struct`.
//: And also you know that `struct` doesn't have the inheritance concept. Now here's a question: how the code of same or 
//: similar behaviors being re-used? 
//:
//: With the inheritance concept, you use usually defines a series of base classes to reuse components. For example,
//: you can use the way you operating arrays to manipulate strings' characters view. You may design a base class, say
//: `CollectionType`, and let `Array` and `CharacterView` extends it. In this simple case, this problem would be solved
//: efficiently using this way. But sometimes, the class inheritance chain would be a big trouble while designing the 
//: whole object graph of your app.
//:
//: Protocols is actually a highly flexible way to implement the **Polymorphism** concept. By defining a _protocol_
//: named `CollectionType` and provide some common or default implementations via _extensions_, the `Array` and 
//: `CharacterView` don't have to inherite from same base class. These 2 classes hence are decoupled, but still shares
//: same implementation for common features.
//:
//: Most Swift built-in types are designed with this concept, called **Protocol-Oriented Programming**.
//:
//: For example, there's a protocol called `CustomStringConvertible` which defines a method used to be called when
//: an object is being converted to String. Like:
//:

struct NormalRāmen {
    let flavor: String
}

struct StringRāmen {
    let flavor: String
}

extension StringRāmen: CustomStringConvertible {
    var description: String {  // Declared in `CustomStringConvertible` protocol
        return "\(self.flavor) Rāmen"
    }
}

let 醤油ラーメン1 = NormalRāmen(flavor: "醤油")
let 醤油ラーメン2 = StringRāmen(flavor: "醤油")

//: Let's see the linked list example again

class LinkedListNode<Element>: ArrayLiteralConvertible {  // LinkedList should be reference based ... use `class`
    var nextNode: LinkedListNode? = .None
    var content: Element?

    init(content: Element) {
        self.content = content
    }

    required init(arrayLiteral elements: Element...) {
        self.content = elements.first
        if !elements.isEmpty {
            var lastNode = self
            for element in elements[1..<elements.count] {
                let node = LinkedListNode(content: element)
                lastNode.nextNode = node
                lastNode = node
            }
        }
    }
}

// Group subscript code as another extension
extension LinkedListNode {
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

    subscript(indexes: Int...) -> [Element?] {
        var result = [Element?]()
        for index in indexes {
            result.append(self[index]?.content)
        }
        return result
    }
}

extension LinkedListNode: SequenceType {  // Makes a type could be enumerated by `for ... in ...`
    typealias Generator = AnyGenerator<Element>

    func generate() -> Generator {
        var lastNode: LinkedListNode? = self
        return anyGenerator {
            if let node = lastNode {
                lastNode = node.nextNode
                return node.content
            } else {
                return nil
            }
        }
    }
}

let linkedList: LinkedListNode<String> = ["A", "B", "C", "D"]
linkedList[0]?.content
linkedList[1]?.content
linkedList[2]?.content
linkedList[3]?.content
linkedList[4]?.content

linkedList[0, 1, 5]

for (index, str) in linkedList.enumerate() {
    print("The content at index \(index) is \"\(str)\"")
}

//:
//: For more detail about the **Protocol-Oriented Programming**, see 
//: [WWDC 2015: Section 408](https://developer.apple.com/videos/play/wwdc2015/408/)


//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
