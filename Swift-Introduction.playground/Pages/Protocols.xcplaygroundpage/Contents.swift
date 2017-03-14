/*:
 
 # Protocols
 
 A protocol defines a blueprint of methods, properties, and other requirements 
 that suit a particular task or piece of functionality.
 
 */

/*:
 
 ## Movable example
 
 */

struct Point { let x: Double, y: Double }
struct Person { var name: String }

protocol Movable {
    func move(from origin: Point, to destination: Point) -> String
}
protocol Runnable: Movable {
    func run(from origin: Point, to destination: Point) -> String
}
protocol PeopleRidable {
    var passengers: [Person] { get set }
}

extension Movable {  // Provide default implementation
    func move(from origin: Point, to destination: Point) -> String {
        return "Move from \(origin) to \(destination)."
    }
}

class Vehicle {}

class Car: Vehicle, Movable, PeopleRidable {
    var passengers: [Person] = []

    func move(from origin: Point, to destination: Point) -> String {
        return "Drive from \(origin) to \(destination)."
    }
}
class Plane: Vehicle, Movable {
    func move(from origin: Point, to destination: Point) -> String {
        return "Fly from \(origin) to \(destination)."
    }
}
struct Dog: Movable {
    func move(from origin: Point, to destination: Point) -> String {
        return "Walk from \(origin) to \(destination)."
    }
}
struct MovableItem: Movable {
}

class ScreenRenderer {
    var movables: [Movable] = []
    func updateFrame() {
        let originalPoint = Point(x: 0, y: 0)
        let destinationPoint = Point(x: 100, y: 100)
        for movable in self.movables {
            print(movable.move(from: originalPoint, to: destinationPoint))
        }
    }
}

let plane = Plane()
plane.move(from: Point(x: 0, y:0), to: Point(x: 10, y:10))
let item = MovableItem()
item.move(from: Point(x: 0, y:0), to: Point(x: 10, y:10))

let renderer = ScreenRenderer()
renderer.movables = [Plane(), Car(), Dog()]
renderer.updateFrame()

/*:
 
 ## File Handler example
 
 */

protocol FileHandler {
    init(path: String)
}

struct DiskFile: FileHandler {
    init(path: String) {
        // ... implementation detail
    }
}
class InMemoryFile: FileHandler {
    required init(path: String) {
        // ... implementation detail
    }
}

/*:
 
 ## Dividable Number example
 
 */

protocol DividableNumber {
    func divided(by divisor: Self) -> (quotient: Self, remainder: Self)
}

extension Int: DividableNumber {
    func divided(by divisor: Int) -> (quotient: Int, remainder: Int) {
        return (self/divisor, self%divisor)
    }
}
extension UInt: DividableNumber {
    func divided(by divisor: UInt) -> (quotient: UInt, remainder: UInt) {
        return (self/divisor, self%divisor)
    }
}

let someInteger: Int = 42
someInteger.divided(by: 5)  // (quotient: 8, remainder: 2)


//: --------------------------------------------------------------------------------------------------------------------
//: # Advanced Example
//: --------------------------------------------------------------------------------------------------------------------

/*:

 Swift uses built-in `protocol` and `struct` to implement basic featuers
 
 ## Fraction

 */

struct Fraction {
    var numerator: Int
    var denominator: Int

    init?(numerator: Int, denominator: Int) {
        guard denominator != 0 else { return nil }
        self.numerator = numerator
        self.denominator = denominator
    }
}

extension Fraction {
    static func gcd(_ a: Int, _ b: Int) -> Int {
        let maxNumber = max(a, b)
        let minNumber = min(a, b)

        if minNumber == 0 { return maxNumber }
        else { return Fraction.gcd(minNumber, maxNumber % minNumber) }
    }

    mutating func reduce() {
        let gcd = Fraction.gcd(self.numerator, self.denominator)
        self.numerator /= gcd
        self.denominator /= gcd
    }

    func reduced() -> Fraction {
        let gcd = Fraction.gcd(self.numerator, self.denominator)
        return Fraction(numerator: self.numerator/gcd, denominator: self.denominator/gcd)!
    }

    func expanded(by value: Int) -> Fraction {
        return Fraction(numerator: self.numerator*value, denominator: self.denominator*value)!
    }
}

extension Fraction {
    var doubleValue: Double {
        return Double(self.numerator) / Double(self.denominator)
    }
}

extension Fraction: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(numerator: value, denominator: 1)!
    }
}

extension Fraction: CustomStringConvertible {
    var description: String {
        return "\(self.numerator)/\(self.denominator)"
    }
}

extension Fraction: Comparable {
    static func ==(left: Fraction, right: Fraction) -> Bool {
        let reduecdLeft = left.reduced()
        let reducedRight = right.reduced()
        return (reduecdLeft.numerator == reducedRight.numerator &&
                reduecdLeft.denominator == reducedRight.denominator)
    }

    static func <(left: Fraction, right: Fraction) -> Bool {
        return left.doubleValue < right.doubleValue
    }

    // You can even implement `>`, `<=`, and `>=` for better performance.
    // (By default, the `>`  would be implemented as `!(==) && !(<)`
}

extension Fraction {
    static func +(left: Fraction, right: Fraction) -> Fraction {
        let expandedLeft = left.expanded(by: right.denominator)
        let expandedRight = right.expanded(by: left.denominator)
        let resultNumerator = expandedLeft.numerator + expandedRight.numerator
        let resultDenominator = expandedLeft.denominator
        return Fraction(numerator: resultNumerator, denominator: resultDenominator)!
    }

    static func -(left: Fraction, right: Fraction) -> Fraction {
        let expandedLeft = left.expanded(by: right.denominator)
        let expandedRight = right.expanded(by: left.denominator)
        let resultNumerator = expandedLeft.numerator - expandedRight.numerator
        let resultDenominator = expandedLeft.denominator
        return Fraction(numerator: resultNumerator, denominator: resultDenominator)!
    }

    static func *(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator: left.numerator*right.numerator,
                        denominator: left.denominator*right.denominator)!
    }

    static func *=(left: inout Fraction, right: Fraction) {
        left.numerator *= right.numerator
        left.denominator *= right.denominator
    }

    static func /(left: Fraction, right: Fraction) -> Fraction {
        return Fraction(numerator: left.numerator*right.denominator,
                        denominator: left.denominator*right.numerator)!
    }
}

let half = Fraction(numerator: 1, denominator: 2)!
let one: Fraction = 1
let oneThird = Fraction(numerator: 4, denominator: 24)!

String(describing: oneThird)
String(describing: oneThird.reduced())

oneThird == half
oneThird > half

let oneFouth = Fraction(numerator: 1, denominator: 2)! * Fraction(numerator: 1, denominator: 2)!

var fraction1 = Fraction(numerator: 2, denominator: 5)!
fraction1 *= Fraction(numerator: 1, denominator: 3)!
String(describing: fraction1)

var fraction2 = Fraction(numerator: 1, denominator: 2)! + Fraction(numerator: 1, denominator: 2)!
fraction2.doubleValue

// Array with Elements which are `Comparable` would have `sort` method
let fractions = [
    Fraction(numerator: 1, denominator: 2)!,
    Fraction(numerator: 6, denominator: 5)!,
    Fraction(integerLiteral: 1),
    Fraction(numerator: 1, denominator: 3)!,
]
let sortedFractions = fractions.sorted()
for fraction in sortedFractions {
    String(describing: fraction)
}

//: ---
/*:

 ## LinkedList

 */

class LinkedListNode<Element>: ExpressibleByArrayLiteral {
    var nextNode: LinkedListNode<Element>? = nil
    var content: Element

    init(content: Element) {
        self.content = content
    }

    required init(arrayLiteral elements: Element...) {
        self.content = elements.first!
        var node = self
        for element in elements[1..<elements.count] {
            node.nextNode = LinkedListNode(content: element)
            node = node.nextNode!
        }
    }
}

// Make the `LinkedListNode` conforms to `Sequence` protocol to provide features like
// `for ... in`, `map`, `enumerated`, and etc.
extension LinkedListNode: Sequence {
    func makeIterator() -> AnyIterator<Element> {
        var node: LinkedListNode<Element>? = self
        return AnyIterator {
            if let currentNode = node {
                let content = currentNode.content
                node = currentNode.nextNode
                return content
            } else {
                return nil
            }
        }
    }
}

// Add `==` operator for the `LinkedListNode` only when its `Element` is equatable.
extension LinkedListNode where Element: Equatable {
    static func ==(left: LinkedListNode, right: LinkedListNode) -> Bool {
        if left.content != right.content {
            return false
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

let uppercaseLetterList: LinkedListNode<String> = ["A", "B", "C", "D"]
Array(uppercaseLetterList)
for (index, content) in uppercaseLetterList.enumerated() {
    "Item \(index) is '\(content)'."
}
let lowercaseLetterArray = uppercaseLetterList.map { $0.lowercased() }

let anotherUppercaseLetterList: LinkedListNode<String> = ["A", "B", "C", "D"]
uppercaseLetterList == anotherUppercaseLetterList
uppercaseLetterList == uppercaseLetterList

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
