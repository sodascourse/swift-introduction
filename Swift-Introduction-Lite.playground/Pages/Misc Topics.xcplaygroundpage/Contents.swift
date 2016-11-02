/*:
 
 ## Misc Topics
 
 */

protocol Animal {}
protocol FourLegsAnimal: Animal {}

struct Cat: FourLegsAnimal {
    func asMaster() {}
}
struct Dog: FourLegsAnimal {}
class Duck: Animal {}
let zoo: [Animal] = [Cat(), Dog(), Duck(), Dog()]

var catsCount = 0
var fourLegAnimalsCount = 0
for animal in zoo {
    if animal is Cat {
        catsCount += 1
    }
    if let cat = animal as? Cat {
        cat.asMaster()
    }
    if animal is FourLegsAnimal {
        fourLegAnimalsCount += 1
    }
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
