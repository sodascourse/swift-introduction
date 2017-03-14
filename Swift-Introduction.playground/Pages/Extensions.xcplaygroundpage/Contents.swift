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
        guard denominator != 0 else { return nil }
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

// Using
let oneThird = Fraction(numerator: 1, denominator: 3)!
let fourThird = Fraction(numerator: 4, denominator: 3)!
Int(fourThird)
Double(oneThird)
fourThird.doubleValue

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
