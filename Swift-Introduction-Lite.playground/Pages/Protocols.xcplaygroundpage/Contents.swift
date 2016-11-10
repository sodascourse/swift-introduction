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
    func move(from origin: Point, to destination: Point)
}
protocol Runnable: Movable {
    func run(from origin: Point, to destination: Point)
}
protocol PeopleRidable {
    var passengers: [Person] { get set }
}

class Vehicle {}

class Car: Vehicle, Movable, PeopleRidable {
    var passengers: [Person] = []

    func move(from origin: Point, to destination: Point) {
        print("Drive from \(origin) to \(destination).")
    }
}
class Plane: Vehicle, Movable {
    func move(from origin: Point, to destination: Point) {
        print("Fly from \(origin) to \(destination).")
    }
}
struct Dog: Movable {
    func move(from origin: Point, to destination: Point) {
        print("Walk from \(origin) to \(destination).")
    }
}

class ScreenRenderer {
    var movables: [Movable] = []
    func updateFrame() {
        let originalPoint = Point(x: 0, y: 0)
        let destinationPoint = Point(x: 100, y: 100)
        for movable in self.movables {
            movable.move(from: originalPoint, to: destinationPoint)
        }
    }
}

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

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
