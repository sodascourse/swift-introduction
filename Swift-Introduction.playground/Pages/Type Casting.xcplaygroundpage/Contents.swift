/*:

 # Type Check and Casting

 Type casting is a way to check the type of an instance, or to treat that 
 instance as a different superclass or subclass from somewhere 
 else in its own class hierarchy.
 
 Type casting in Swift is implemented with the `is` and `as` operators.
 These two operators provide a simple and expressive way to 
 check the type of a value or cast a value to a different type.

 */

protocol Animal {}
protocol FourLegsAnimal: Animal {}

struct Cat: FourLegsAnimal {
    func asMaster() -> String {
        return "Meow, I'm your master."
    }
}

class Dog: FourLegsAnimal {}
class Duck: Animal {}

let zoo: [Animal] = [Cat(), Dog(), Duck(), Dog(), Cat(), Cat()]

//: Use `is` to test whether this variable is an instance of Class/Struct or Protocol conformance

var catsCount = 0, dogsCount = 0, fourLegsCount = 0
for animal in zoo {
    if animal is Cat {
        catsCount += 1
    }
    if animal is Dog {
        dogsCount += 1
    }
    if animal is FourLegsAnimal {
        fourLegsCount += 1
    }
}
"We have \(catsCount) cats in the zoo."
"We have \(dogsCount) dogs in the zoo."
"We have \(fourLegsCount) four-leg animals."

//: Use `as` to cast type of instance

for animal in zoo {
    if let cat = animal as? Cat {
        cat.asMaster()
    }
}

//: The Swift compiler would help you to check the casting between types.

let cat = Cat()

//cat is Animal  // Uncomment to see the warning Xcode yields.
//cat is Dog  // Uncomment to see the warning Xcode yields.
let animal = cat as Animal  // Up-casting. Use `option+click` to see the type of `animal`
//let dog = cat as? Dog  // Check the warning and the value of `dog`
//let someDog = cat as Dog  // Uncomment to see the error Xcode yields.
//let someDog2 = cat as! Dog  // Uncomment to see the error Xcode yields.
let someCat = animal as? Cat // // Down-casting. Use `option+click` to see the type of `someCat`
let someDog3 = animal as? Dog  // Down-casting. Check the value and the type of `someDog3`

/*:
 
 ## `Any` and `AnyObject`
 
 Swift provides two special types for working with nonspecific types:
 - `Any` can represent an instance of any type at all, including function types.
 - `AnyObject` can represent an instance of any class type.

 Use `Any` and `AnyObject` only when you explicitly need the behavior and capabilities they provide.
 It is always better to be specific about the types you expect to work with in your code.
 By making the type context clear, Swift could keep your code safe to execute.

 */

var anything: [Any] = [-1, "XD", ["yo"], ["answer": 42], true, 57, "Hello"]
var stringCount = 0, sumOfAllInt = 0

for item in anything {
    // Here we uses "Pattern Matching" (google 'Swift Pattern Matching')
    // But anyway, you can still use `if-else` to implement this.
    switch item {
    case is String:
        stringCount += 1
    case let integer as Int:
        sumOfAllInt += integer
    default: ()  // Do nothing
    }
}

stringCount
sumOfAllInt

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
