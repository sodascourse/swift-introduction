/*:

 # Extensions

 Extensions add new functionality to an existing `class`, `struct`, and `enum`.
 It can also extend types for which you do not have access to the original source code.
 
 Extensions in Swift can:

 - Add computed instance properties and computed type properties
 - Define instance methods and type methods
 - Provide new initializers
 - Define subscripts
 - Define and use new nested types
 - Make an existing type conform to a protocol

 */

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Extend types

 */
extension Array {
    var middle: Element? {
        guard !self.isEmpty else {
            return nil
        }
        return self[self.count/2]
    }
}

[0, 1, 2].middle
[1, 2, 3, 4].middle

extension String {
    mutating func prepend(_ string: String) {
        self = string + self
    }
}
var string = "Hello"
string.prepend("+++ ")

//: --------------------------------------------------------------------------------------------------------------------
/*:
 
 ## Group and Organize implementation code

 */

// Main type body
struct Fraction {
    var numerator: Int
    var denominator: Int

    init?(numerator: Int, denominator: Int) {
        guard denominator != 0 else {
            return nil
        }
        self.numerator = numerator
        self.denominator = denominator
    }
}

// Extra type features
extension Fraction {
    var doubleValue: Double {
        return Double(self.numerator) / Double(self.denominator)
    }
}

// Bridge for other types
extension Int {
    init(_ fraction: Fraction) {
        self.init(fraction.doubleValue)
    }
}

extension Double {
    init(_ fraction: Fraction) {
        self = fraction.doubleValue
    }
}

// Adopt protocols
extension Fraction: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(numerator: 1, denominator: value)!
    }
}

extension Fraction: CustomStringConvertible {
    var description: String {
        return "Fraction(\(self.numerator)/\(self.denominator))"
    }
}

// Using
let oneThird = Fraction(numerator: 1, denominator: 3)!
let fourThird = Fraction(numerator: 4, denominator: 3)!
String(describing: oneThird)  // CustomStringConvertible
let two: Fraction = 2  // ExpressibleByIntegerLiteral
Int(fourThird)
Double(oneThird)

//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced Example
//: --------------------------------------------------------------------------------------------------------------------

/*:
 
 Extensions can be applied to types only when the type meets some conditions.
 
 */

class LinkedListNode<Element> {
    var nextNode: LinkedListNode? = .none
    var content: Element

    init(content: Element) {
        self.content = content
    }

    var isLastNode: Bool {
        return self.nextNode == nil
    }

    var lastNode: LinkedListNode {
        var lastNode = self
        while !lastNode.isLastNode {
            lastNode = lastNode.nextNode!
        }
        return lastNode
    }

    func toArray() -> [Element] {
        var result = [Element]()
        var node: LinkedListNode<Element>? = self
        repeat {
            result.append(node!.content)
            node = node!.nextNode
        } while node != nil
        return result
    }

    // `subscript` is the method of `[]` operator
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

    // A static func is usually used as factory.
    static func createLinkedList(items: Element...) -> LinkedListNode<Element>? {
        guard !items.isEmpty else { return nil }

        let resultNode = LinkedListNode(content: items.first!)
        var lastNode = resultNode
        for item in items[1..<items.count] {
            lastNode.nextNode = LinkedListNode(content: item)
            lastNode = lastNode.nextNode!  // Step forward
        }
        return resultNode
    }
}

// Add `==` operator for the `LinkedListNode` only when its `Element` is equatable.
extension LinkedListNode where Element: Equatable {
    static func ==(left: LinkedListNode, right: LinkedListNode) -> Bool {
        if left.content == right.content {
            return true
        }
        // `Optional` is actuall an `enum`.
        switch (left.nextNode, right.nextNode) {
        case (.none, .none):
            return true
        case (.some(let leftNextNode), .some(let rightNextNode)):
            return leftNextNode == rightNextNode
        default:
            return false
        }
    }
}

let linkedList1 = LinkedListNode.createLinkedList(items: 1, 2, 3, 4)!
let linkedList2 = LinkedListNode.createLinkedList(items: 1, 2, 3, 4)!
let linkedList3 = LinkedListNode.createLinkedList(items: 5, 6, 7)!
let linkedList4 = LinkedListNode.createLinkedList(items: 5, 6, 8)!

linkedList1 == linkedList2
linkedList1 == linkedList3
linkedList3 == linkedList4

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
