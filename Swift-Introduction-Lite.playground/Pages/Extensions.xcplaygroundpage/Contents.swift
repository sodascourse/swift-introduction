/*:

 # Extensions

 Extensions add new functionality to an existing `class`, `struct`, and `enum`.
 It can also extend types for which you do not have access to the original source code.

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

extension String {
    mutating func prepend(_ string: String) {
        self = string + self
    }
}
var string = "Hello"
string.prepend("+++ ")

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

extension Fraction {
    var doubleValue: Double {
        return Double(self.numerator) / Double(self.denominator)
    }
}

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

let oneThird = Fraction(numerator: 1, denominator: 3)!
let fourThird = Fraction(numerator: 4, denominator: 3)!
Int(fourThird)
Double(oneThird)

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
