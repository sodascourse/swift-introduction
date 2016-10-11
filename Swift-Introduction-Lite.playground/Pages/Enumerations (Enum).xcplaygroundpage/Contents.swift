/*:

 # Enum, Enumerations

 An enumeration defines a common type for a group of related values 
 and enables you to work with those values in a type-safe way within your code.
 
 */
/*:

 Let's see an bad example without Enum's help first:

 */
let CoffeeCupSizeLarge = 750
let CoffeeCupSizeMedium = 500
let CoffeeCupSizeSmall = 360

func brewCoffee(_ cupSize: Int) -> String {
    if cupSize == CoffeeCupSizeLarge {
        return "Hey Bro, A large size coffee brewed."
    } else if cupSize == CoffeeCupSizeMedium {
        return "Hi, A medium size coffee brewed."
    } else if cupSize == CoffeeCupSizeSmall {
        return "Here's your small size coffee."
    } else {
        return "Err, Unknown cup size ..."
    }
}
brewCoffee(CoffeeCupSizeLarge)
// How's if someone calls the function with an unknown value ...
brewCoffee(600)

/*:

 ## Declare and Use an Enumeration
 
 - We use the `enum` keyword to declare enumerations.
 - The naming convention still follows the **CamelCase**.
   But since `enum` is actually a _Type_ in Swift, the first letter should be **capital**.
 - We list all possible values of this `enum` with the `case` keyword.
 - If this values in this `enum` represent other values, we use `:` to 
   declare the type of raw values.

 */

// A simple/plan enum (without raw value)
enum CompassPoint {
    case north, south, east, west
}
CompassPoint.north

// A enum whose values are based on 'Character'
enum ASCIIEscapeCharacter: Character {
    case tab = "\t"
    case lineBreak = "\n"
}

// A enum whose values are based on 'Float'
enum Coin: Float {
    case cent       = 0.01
    case nickel     = 0.05
    case dime       = 0.10
    case quarter    = 0.25
    case half       = 0.50
    case dollarCoin = 1.00

//    case tenCents = 0.10
}
Coin.quarter.rawValue

/*:
 
 Enums could be initialized with its raw value.

 */
func coinName(of price: Float) -> String? {
    guard let coin = Coin(rawValue: price) else {
        // NOTE: Why is the value returned by `Coin(rawValue:)` an optional value?
        return nil
    }
    return String(describing: coin)
}
coinName(of: 0.5)
coinName(of: 0.75)

/*:
 
 ### Implicitly Assigned Raw Values
 
 When you’re working with enumerations that store integer or string raw values, 
 you don’t have to explicitly assign a raw value for each case. When you don’t,
 Swift will automatically assign the values for you.
 
 */
enum TaipeiDistrict: String {
    case 北投區
    case 士林區
    case 內湖區
    case 大同區
    case 中山區
    case 松山區
    case 南港區
    case 萬華區
    case 中正區
    case 大安區
    case 信義區
    case 文山區
}

//CompassPoint.north.rawValue
// Uncomment the above line to see what Xcode yields.
let daanDistrict = TaipeiDistrict.大安區
let dannDistrictName = TaipeiDistrict.大安區.rawValue
// Use "option+click" to see the difference of the above two constants
let xinyiDistrict = TaipeiDistrict(rawValue: "信義區")

enum JapaneseNumber: Int {
    case いち = 1, に, さん, よん, ご, ろく, なな, はち, きゅう, じゅう
}
let yon = JapaneseNumber.よん
yon.rawValue

/*:

 Rewrite the coffee brewer with enum. Enum works perfectly with `switch-case`.
 _But it's still ok to use enums with `if-else` statement.

 */

enum CoffeeCupSize: Int {
    case large = 750
    case medium = 500
    case small = 360
}
func brewCoffee(with cupSize: CoffeeCupSize) -> String {
    switch cupSize {
    case .large:
        return "Hey, a large coffee for you."
    case .medium:
        return "Here's your medium coffee."
    case .small:
        return "Your small coffee is ready."
    }
}
brewCoffee(with: CoffeeCupSize.large)
//brewCoffee(with: 600)  // Uncomment this line to see what Xcode yields.

/*:
 
 When passing enums as arguments, or when the contextual type of the variable is clear,
 you can use the enum's value in shorthand form: The value prefixed with a dot.

 */
let neihuDistrict: TaipeiDistrict = .內湖區
//let neihuDistrict = .內湖區
// Uncomment above line to see what Xcode yields
brewCoffee(with: .medium)

/*:
 
 ## Associated Values
 
 Enums are able to store associated values.

 */
enum VisitingReason {
    case travel
    case business
    case studying
    case others(String)
}
func immigtationCheck(person: String, for reason: VisitingReason) -> String {
    switch reason {
    case .travel:
        return "\(person) comes to the states for travel."
    case .business:
        return "\(person) comes to the states for business."
    case .studying:
        return "\(person) comes to the states for studying."
    case .others(let otherReason):
        // Use the value binding syntax to extract associated value
        return "\(person) comes to the states with other reason: \(otherReason)"
    }
}
immigtationCheck(person: "Peter", for: .travel)
immigtationCheck(person: "Kate", for: .studying)
immigtationCheck(person: "James", for: .others("scerect services"))

enum Coordinate2D {
    case cartesian(x: Float, y: Float)
    case polar(radius: Float, angle: Float)

    func distanceToOrigin() -> Float {
        switch self {  // The `self` means for any instances of `Coordinate2D`.
        case let .cartesian(x, y):
            return (x*x + y*y).squareRoot()
        case .polar(let radius, _):
            return radius
        }
    }
}
let somePoint1 = Coordinate2D.cartesian(x: 3, y: 4)
let somePoint2: Coordinate2D = .polar(radius: 2.0, angle: Float.pi/2)
somePoint1.distanceToOrigin()
somePoint2.distanceToOrigin()

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
