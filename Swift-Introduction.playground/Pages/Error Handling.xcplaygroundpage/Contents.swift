//: # Error Handling
//:
//: Error handling is the process of responding to and recovering from error conditions in your program.
//:
//: Some operations aren’t guaranteed to always complete execution or produce a useful output. Optionals are used to 
//: represent the absence of a value, but when an operation fails, it’s often useful to understand what caused the 
//: failure, so that your code can respond accordingly.

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

struct VendingMachine {
    var items: [String: (Int, Int)]  // name: (count, price)

    mutating func vend(itemNamed name: String, coin coinsDeposited: Int) throws -> String {
        guard let (itemCount, itemPrice) = items[name] else {
            throw VendingMachineError.InvalidSelection
        }
        guard itemCount > 0 else {
            throw VendingMachineError.OutOfStock
        }
        guard itemPrice <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: itemPrice - coinsDeposited)
        }

        self.items[name] = (itemCount - 1, itemPrice)
        return "\(name)ラーメン"
    }
}

var ラーメンmachine = VendingMachine(items: [
    "醤油": (2, 700),
    "塩": (5, 600),
])

//: ## Handling Errors Using Do-Catch

do {
    try ラーメンmachine.vend(itemNamed: "味噌", coin: 1000)
} catch VendingMachineError.InvalidSelection {
    "There's no such rāmen"
} catch VendingMachineError.OutOfStock {
    "Sold out"
} catch {
    "QQ"
}

//: ## Converting Errors to Optional Values

let item1 = try? ラーメンmachine.vend(itemNamed: "塩", coin: 500)
let item2 = try? ラーメンmachine.vend(itemNamed: "塩", coin: 600)
let item3 = try! ラーメンmachine.vend(itemNamed: "塩", coin: 600)

//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
