/*:

 # Struct and Class

 */

/*:
 
 ## Struct
 
 ### Point example

 */
struct Point {
    let x: Double
    let y: Double

    static let origin = Point(x: 0, y: 0)

    func distance(to another: Point) -> Double {
        let deltaX = self.x - another.x
        let deltaY = self.y - another.y
        return (deltaX*deltaX + deltaY*deltaY).squareRoot()
    }

    var distanceToOrigin: Double {
        return self.distance(to: Point.origin)
    }
}
let point1 = Point(x: 3, y: 4)
let point2 = Point(x: 15, y: 9)
let origin = Point.origin
point1.distanceToOrigin
point1.distance(to: point2)

/*:
 
 ### Tour example
 
 */
struct Tour {
    var origin: String
    var destination: String
}
let tour = Tour(origin: "Taipei", destination: "Tokyo")
//tour.destination = "Osaka"
// Try to uncomment above line to see what Xcode yields.

/*:
 
 ### Back Account example
 
 */
struct BankAccount {
    var deposit: Int {
        willSet {
            print(">>> Deposit value will change from \(self.deposit) to \(newValue).")
        }
        didSet {
            print(">>> Deposit value did change from \(oldValue) to \(self.deposit).")
        }
    }
}
var account = BankAccount(deposit: 1000)
account.deposit += 10

/*:
 
 ### Rectangle example
 
 */

struct Rect {
    struct Point { var x, y: Double }
    struct Size {
        var width, height: Double
        mutating func scale(by times: Double) {
            self.width *= times
            self.height *= times
        }
    }

    var origin: Point, size: Size
    var center: Point {
        get {
            return Point(x: self.origin.x + self.size.width/2,
                         y: self.origin.y + self.size.height/2)
        }
        set(newCenter) {
            self.origin.x = newCenter.x - self.size.width/2
            self.origin.y = newCenter.y - self.size.height/2
        }
    }

    mutating func move(toX x: Double, y: Double) {
        self.origin.x = x
        self.origin.y = y
    }
    mutating func scaleSize(by times: Double) {
        self.size.scale(by: times)
    }
}

/*:
 
 ### Book example
 
 */

import Foundation

struct Book {
    var title: String
    let author: String
    var price = 10.0
    let publishDate = Date()

    init(title: String, author: String, price: Double) {
        self.title = title
        self.author = author
        self.price = price
    }

    init(title: String, author: String) {
        self.init(title: title, author: author)
    }
}

/*:
 
 ### Fraction and Complex example
 
 */
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

    init(_ integer: Int) {
        self.init(numerator: integer, denominator: 1)!
    }
}

struct Complex {
    var real: Double
    var imaginary: Double

    var isReal: Bool {
        return self.imaginary == 0
    }
}

let someComplexNumber = Complex(real: 1, imaginary: 2)  // 1+2i

/*:
 
 ### Audio channel example
 
 */
struct AudioChannel {
    static let thresholdLevel = 10  // Use as constants
    static var maxLevelOfAllChannels = 0  // Use as shared variables
    var currentLevel: Int = 0 {
        didSet {
            if (self.currentLevel > AudioChannel.thresholdLevel) {
                self.currentLevel = AudioChannel.thresholdLevel
            }
            if (self.currentLevel > AudioChannel.maxLevelOfAllChannels) {
                AudioChannel.maxLevelOfAllChannels = self.currentLevel
            }
        }
    }
}

//: --------------------------------------------------------------------------------------------------------------------

/*:
 
 ## Class
 
 ### Animal example
 
 */
class Animal {
    var name: String?
    func makeNoise() {}
    init(name: String) { self.name = name }
}
class Cat: Animal {
    override func makeNoise() { print("meow~") }
}
class Dog: Animal {
    override func makeNoise() { print("wof!") }
}
let kitty = Cat(name: "Kitty")
let puppy = Dog(name: "Puppy")

print("\n\n---")
kitty.makeNoise()  // meow~
kitty.name  // Kitty
puppy.makeNoise()  // wof!


/*:
 
 ### View example
 
 */
struct Frame { var x, y, width, height: Double }

class View {
    var frame: Frame
    init(frame: Frame) { self.frame = frame }
    func draw() {
        print("Start to draw a view at (x=\(self.frame.x), y=\(self.frame.y)).")
        print("The size of this view is \(self.frame.width)*\(self.frame.height).")
    }
}
class BorderedView: View {
    override func draw() {
        super.draw()
        print("Draw a stroke for this view.")
    }
}

print("\n\n---")
let borderedView = BorderedView(frame: Frame(x: 10.0, y: 10.0, width: 200.0, height: 300.0))
borderedView.draw()

/*:
 
 ### Student example
 
 */
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
class Student: Person {
    var school: String
    var department: String?
    init(name: String, school: String, department: String?) {
        self.school = school
        self.department = department
        super.init(name: name)
    }
    convenience init(name: String, school: String) {
        self.init(name: name, school: school, department: nil)
    }
}

/*:
 
 ### Reference example
 
 */
let person1 = Person(name: "Peter")
let person2 = person1
let person3 = Person(name: "Peter")
person1 == person2
person1 == person3
person1 === person2  // Check identity: Memory block
person1 === person3  // Check identity: Memory block
person1.name = "Annie"
person2.name  // Also changed, because `person1` and `person2` are the same memory block.
person3.name  // Still "Peter".

var fraction1 = Fraction(numerator: 1, denominator: 2)!
var fraction2 = fraction1
fraction1.denominator = 3
fraction2.denominator  // Still 2, because Fraction is a struct, value type.

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
