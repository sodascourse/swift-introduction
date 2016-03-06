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
    var items: [String: (count: Int, price: Int)]  // name: (count, price)

    mutating func vend(itemNamed itemName: String, coin coinsDeposited: Int) throws -> String {
        guard let (itemCount, itemPrice) = items[itemName] else {
            throw VendingMachineError.InvalidSelection
        }
        guard itemCount > 0 else {
            throw VendingMachineError.OutOfStock
        }
        guard itemPrice <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: itemPrice - coinsDeposited)
        }

        self.items[itemName] = (count: itemCount - 1, price: itemPrice)
        return "\(itemName)ラーメン"
    }
}

var ラーメンmachine = VendingMachine(items: [
    "醤油": (count: 2, price: 700),
    "塩": (count: 5, price: 600),
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

do {
    try ラーメンmachine.vend(itemNamed: "塩", coin: 150)
} catch VendingMachineError.InvalidSelection {
    "There's no such rāmen"
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    "Require more coins: \(coinsNeeded)"
} catch {
    "QQ"
}

//: ## Converting Errors to Optional Values
//:
//: Sometimes we don't care about what error happened.

let item1 = try? ラーメンmachine.vend(itemNamed: "塩", coin: 500)
let item2 = try? ラーメンmachine.vend(itemNamed: "塩", coin: 600)
let item3 = try! ラーメンmachine.vend(itemNamed: "塩", coin: 600)

//: NOTE: Use "_option+click_" on above variables to see the type infered by the Swift compiler.
//:
//: --------------------------------------------------------------------------------------------------------------------
//: [<- previous](@previous) | [next ->](@next)
