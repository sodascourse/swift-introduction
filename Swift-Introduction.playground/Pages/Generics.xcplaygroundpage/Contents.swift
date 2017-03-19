/*:
 
 # Generics
 
 Generic code enables you to write flexible, reusable functions and types 
 that can work with any type, subject to requirements that you define. 
 You can write code that avoids duplication and expresses its intent 
 in a clear, abstracted manner.
 
 Generics are one of the most powerful features of Swift, 
 and much of the Swift standard library is built with generic code.
 
 */

import Foundation

/*:
 
 We all know that the following code is redundant and not easy to maintain.
 
 */
func myRedundantSwap(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func myRedundantSwap(_ a: inout Double, _ b: inout Double) {
    let temp = a
    a = b
    b = temp
}

func myRedundantSwap(_ a: inout String, _ b: inout String) {
    let temp = a
    a = b
    b = temp
}

/*:
 
 In above example, all we care is that the type of the two argument
 should be the same. Hence we can replace the type with `T`, a generic type.

 */

func mySwap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

/*:
 
 The `T` here is an abstract type. It would be determined while being invoked.
 
 */

var firstNumber = 42, secondNumber = 56
mySwap(&firstNumber, &secondNumber)
firstNumber
secondNumber

/*:
 
 This concept could be applied to Types too.
 
 For example, we want a stack to put element like integers or strings.
 
 */

struct IntStack {
    private var values = [Int]()
    func peek() -> Int? { return self.values.last }
    mutating func pop() -> Int? { return self.values.popLast() }
    mutating func push(_ value: Int) { self.values.append(value) }
}

struct StringStack {
    private var values = [String]()
    func peek() -> String? { return self.values.last }
    mutating func pop() -> String? { return self.values.popLast() }
    mutating func push(_ value: String) { self.values.append(value) }
}

/*:
 
 In this case, all we care is - 
 The type of the content of this Stack should be the same as its operations.
 
 Instead of writing these redundant types, we can substitute the type of 
 the Stack content with a generic type, named `Element`.
 
 > In Swift, we usually use `Element` for the type of container types.
 
 */

struct Stack<Element> {
    private var values = [Element]()
    func peek() -> Element? { return self.values.last }
    mutating func pop() -> Element? { return self.values.popLast() }
    mutating func push(_ value: Element) { self.values.append(value) }
}

// Note: Use `option+click` to see the signature of `push`, `peek`, and `pop` methods.
var intStack = Stack<Int>()
intStack.push(1)
intStack.peek()

var stringStack = Stack<String>()
stringStack.pop()

/*:
 
 We can also limit generic types. It means not all types can be substituted.
 The type passed into the functions or types must reach some requirements.
 
 For example, we can implement a `max` function to find the max value in a sequence.
 In the implementation, we would compare values,
 
 */

func myMax<Value: Comparable>(_ first: Value, _ rest: Value...) -> Value {
    var result = first
    for value in rest {
        if value > result { result = value }
    }
    return result
}

myMax(1, -1, 2, 3, 5, 10, -4)

extension Array where Element: Comparable {
    var maximum: Element? {
        guard !self.isEmpty else { return nil }
        var result = self.first!
        for value in self[1..<self.count] {
            if value > result { result = value }
        }
        return result
    }
}

let numbers = [1, 5, -10, 7, 42]
numbers.maximum!
let booleans = [true, false]
//booleans.maximum  // Uncomment to see what error message Xcode yields.

func find<T: Equatable, U: Sequence>(_ target: T, in values: U) -> Bool
    where U.Iterator.Element == T {
        for value in values {
            if target == value { return true }
        }
        return false
}

find(3, in: [2, 3, 5, 7, 11, 13, 17, 19])
find(9, in: [2, 3, 5, 7, 11, 13, 17, 19])
//find("A", in: [2, 3, 5, 7, 11, 13, 17, 19])  // Uncomment to see what error message Xcode yields.

/*:
 
 Using generics with protocols is a little tricky.
 
 */

protocol Generator {
    associatedtype Element  // The generic type in protocol

    mutating func next() -> Element?

    mutating func forEach(_ body: (Element) -> Void)
    func map<Mapped>(_ transform: @escaping (Element) -> Mapped) -> MappedGenerator<Self, Mapped>
    mutating func reduce<Reduced>(initial: Reduced, _ reducer: (Reduced, Element) -> Reduced) -> Reduced
    func filter(_ shouldInclude: @escaping (Element) -> Bool) -> FilteredGenerator<Self>
    func enumerated() -> EnumeratedGenerator<Self>

    mutating func contains(_ target: Element, where predicate: (Element, Element) -> Bool) -> Bool
    mutating func maximum(by isLarger: (Element, Element) -> Bool) -> Element?
}

struct MappedGenerator<Base: Generator, Element>: Generator {
    var base: Base
    let transformer: (Base.Element) -> Element

    mutating func next() -> Element? {
        guard let next = self.base.next() else { return nil }
        return self.transformer(next)
    }
}

struct FilteredGenerator<Base: Generator>: Generator {
    var base: Base
    let shouldInclude: (Base.Element) -> Bool

    mutating func next() -> Base.Element? {
        while let next = self.base.next() {
            if self.shouldInclude(next) { return next }
        }
        return nil
    }
}

struct EnumeratedGenerator<Base: Generator>: Generator {
    var base: Base
    var currentIndex: Int = 0

    init(base: Base) {
        self.base = base
    }

    mutating func next() -> (Int, Base.Element)? {
        guard let next = self.base.next() else { return nil }
        defer { currentIndex += 1 }
        return (currentIndex, next)
    }
}

// Default implementations
extension Generator {
    mutating func forEach(_ body: (Element) -> Void) {
        while let next = self.next() {
            body(next)
        }
    }

    func map<T>(_ transform: @escaping (Element) -> T) -> MappedGenerator<Self, T> {
        return MappedGenerator(base: self, transformer: transform)
    }

    mutating func reduce<T>(initial: T, _ reducer: (T, Element) -> T) -> T {
        var result = initial
        self.forEach { (item) in
            result = reducer(result, item)
        }
        return result
    }

    func filter(_ shouldInclude: @escaping (Element) -> Bool) -> FilteredGenerator<Self> {
        return FilteredGenerator(base: self, shouldInclude: shouldInclude)
    }

    func enumerated() -> EnumeratedGenerator<Self> {
        return EnumeratedGenerator(base: self)
    }

    mutating func contains(_ target: Element, where predicate: (Element, Element) -> Bool) -> Bool {
        while let next = self.next() {
            if predicate(target, next) {
                return true
            }
        }
        return false
    }

    mutating func maximum(by isLarger: (Element, Element) -> Bool) -> Element? {
        var result: Element? = nil
        while let next = self.next() {
            if result == nil || isLarger(next, result!) {
                result = next
            }
        }
        return result
    }
}

// Extra capabilities
extension Generator where Element: Equatable {
    mutating func contains(_ target: Element) -> Bool {
        return self.contains(target, where: ==)
    }
}
extension Generator where Element: Comparable {
    mutating func maximum() -> Element? {
        return self.maximum(by: >)
    }
}

// Type conversions
extension Array {
    init<T: Generator>(_ Generator: T) where T.Element == Element {
        var copiedGenerator = Generator
        var result = [Element]()
        while let next = copiedGenerator.next() {
            result.append(next)
        }
        self = result
    }
}


// Concrete Types - Number Generator
struct NumberGenerator: Generator {
    let startStep: Int
    let targetStep: Int
    var currentStep: Int

    init(steps: Int, from startStep: Int = 0) {
        self.startStep = startStep
        self.targetStep = startStep + steps
        self.currentStep = startStep
    }

    // Protocol-Generic conformation by implement `Element` related method
    mutating func next() -> Int? {
        guard self.currentStep <= self.targetStep else { return nil }
        defer { self.currentStep += 1 }
        return self.currentStep
    }

    // You can still provide your own implementation.
    // for better performance one. From O(n) -> O(1)
    func contains(_ target: Int) -> Bool {
        return self.startStep <= target && target <= self.targetStep
    }
}

struct LetterGenerator: Generator {
    var currentLetterIndex: Int = 0

    mutating func next() -> Character? {
        guard self.currentLetterIndex < 26 else { return nil }
        defer { self.currentLetterIndex += 1 }
        return Character(UnicodeScalar(self.currentLetterIndex + 65)!)
    }
}

Array(NumberGenerator(steps: 5))

var fiveToTen = NumberGenerator(steps: 10, from: 5)
fiveToTen.contains(2)

var evenGenerator = NumberGenerator(steps: 20).filter { $0 % 2 == 0}
evenGenerator.forEach { (number) in
    print("\(number) is an even number.")
}

print("\n----\n")

var letterGenerator = LetterGenerator()
var lowercaseLetterGenerator = letterGenerator.map { String($0).lowercased().characters.first! }.enumerated()
lowercaseLetterGenerator.forEach { (index, letter) in
    print("The letter at index \(index) is \(letter).")
}



print("\n----\n")



struct FileChunksReader: Generator {
    let path: String
    let fileHandle: FileHandle
    let chunkSize: Int

    init?(path: String, chunkSize: Int = 4096) {
        guard chunkSize > 0 else { return nil }
        guard let fileHandle = FileHandle(forReadingAtPath: path) else {
            return nil
        }
        self.path = path
        self.fileHandle = fileHandle
        self.chunkSize = chunkSize
    }

    mutating func next() -> Data? {
        let data = self.fileHandle.readData(ofLength: Int(self.chunkSize))
        guard !data.isEmpty else { return nil }
        return data
    }
}

var hostFileReader = FileChunksReader(path: "/etc/hosts", chunkSize: 128)!
let hostFileSize = hostFileReader.reduce(initial: 0) { (accumulatedSize, data) in
    return accumulatedSize + data.count
}
"It takes \(hostFileSize) bytes for '/etc/hosts'"

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
