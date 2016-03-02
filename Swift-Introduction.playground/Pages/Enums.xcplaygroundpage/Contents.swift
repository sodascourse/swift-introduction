//: # Enumerations
//:

import Foundation

//:
//: An enumeration defines a common type for a group of related values and enables you to work with those values in a 
//: type-safe way within your code. It's better and safer than a group of constants. Like:

// Bad example with constants
let LargeCupSizeConstants: Int = 750
let MediumCupSizeConstants: Int = 500
let SmallCupSizeConstants: Int = 350

func brewCoffee1(cupSize: Int) -> String {
    return "Brewing coffee for a \(cupSize) c.c. cup"
}
brewCoffee1(LargeCupSizeConstants)

// With Enum
enum CupSize: Int {
    case Large = 750
    case Medium = 500
    case Small = 350
}
func brewCoffee2(cupSize: CupSize) -> String {
    return "Brewing coffee for a \(cupSize.rawValue) c.c. cup"
}
brewCoffee2(CupSize.Large)
brewCoffee2(.Medium)

let someCupSize = CupSize.Large
switch someCupSize {
case .Large:
    "A large cup"
default:
    "Other cups"
}

if someCupSize == .Small {
    "A small cup"
}

//: ## Enums are also value types
//:
//: Like `struct`, they are passed by copy. Also you can define methods for them.

enum Suit {
    case Spades, Hearts, Diamonds, Clubs

    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

Suit.Hearts.simpleDescription()

//: ## Raw Values
//:
//: As above example, enums may have a raw value. Like the `CupSize`, it does have raw value in Int. And like `Suit`, 
//: it doesn't have a raw value at all.
//:
//: When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign 
//: a raw value for each case. When you don’t, Swift will automatically assign the values for you.

enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
Planet(rawValue: 7)!

enum SuitString: String {
    case Spades, Hearts, Diamonds, Clubs
}
Suit.Spades  // which doesn't have a raw value
SuitString.Spades.rawValue  // which has a string raw value

//: ## Associated Values

enum Coordinate {
    case Spherical(Float, Float)  // Use the distance to origin and the angle with x-axis as coordinate
    case Cartesian(Float, Float)  // Use the distance to x-axis and y-axis as coordinate

    var distanceFromOrigin: Float {
        switch self {
        case .Spherical(let radius, _):
            return radius
        case .Cartesian(let x, let y):
            return sqrt(x*x + y*y)
        }
    }

    var angleFromXAxis: Float {
        switch self {
        case .Spherical(_, let angle):
            return angle
        case .Cartesian(let x, let y):
            return atan(y/x)
        }
    }
}

let coordinate1: Coordinate = .Spherical(20, Float(M_PI))
coordinate1.angleFromXAxis
coordinate1.distanceFromOrigin

let coordinate2 = Coordinate.Cartesian(3.0, 3.0)
coordinate2.angleFromXAxis
coordinate2.distanceFromOrigin

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
