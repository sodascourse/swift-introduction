/*:

 # Collections

 Swift provides three primary collection types, known as arrays, sets, and dictionaries,
 for storing collections of values.

 - Arrays are **ordered** collections of values.
 - Sets are **unordered** collections of **unique values**.
 - Dictionaries are **unordered** collections of **key-value associations**.

 Arrays, sets, and dictionaries in Swift are always clear about
 the types of values and keys that they can store.

 This means that you cannot insert a value of the wrong type into a collection
 by mistake. It also means you can be confident about the type of values you
 will retrieve from a collection.

 If you create an array, a set, or a dictionary, and assign it to a variable,
 the collection that is created will be mutable. You can change the collection
 by adding, removing, or changing items in the collection.

 If you assign an array, a set, or a dictionary to a constant,
 that collection is immutable, and its size and contents cannot be changed.

 */
/*:

 ## Sets

 A set stores distinct values of the same type in a collection with no defined ordering.
 You can use a set instead of an array when the order of items is not important,
 or when you need to ensure that an item only appears once.

 ### Set creation

 Sets could be created by using Set initializers or with _the array literals_.

 */
let names = Set<String>(["Peter", "Annie", "Matt", "Spencer", "Alvin"])
let fibNumbers: Set<Int> = [1, 1, 2, 3, 5, 8, 13]

/*:

 ### Set Type

 The type of a Swift set is written in full as `Set<Element>`,
 where `Element` is the type of values the array is allowed to store.

 */
let fruits: Set<String> = ["apple", "banana", "orange"]

/*:

 ### Set operations

 You can efficiently perform fundamental set operations,
 such as combining two sets together, determining which values two sets 
 have in common, or determining whether two sets contain 
 all, some, or none of the same values.

 */
var primes: Set<Int> = [2, 2, 3, 5, 7, 11, 13, 17, 19, 6+5]
let oddNumbers = Set<Int>([1, 3, 5, 7, 9, 11, 13, 15, 17, 19])
let evenNumbers: Set<Int> = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
let smallEvenNumbers: Set<Int> = [2, 4, 6, 8]

primes.insert(21)
primes.remove(21)

let emptyIntSet = oddNumbers.intersection(evenNumbers)
let allNumbers = evenNumbers.union(oddNumbers)
let evenPrimes = primes.intersection(evenNumbers)
let nonPrimeOddNumbers = oddNumbers.subtracting(primes)
smallEvenNumbers.isSubset(of: evenNumbers)
evenNumbers.isSuperset(of: evenPrimes)
evenNumbers.isDisjoint(with: oddNumbers)
primes.contains(12)

/*:

 ### Set and Control flows

 The `for-in` loop is great to enumerate elements in a set

 */
for prime in primes {
    "\(prime) is a prime."
}

for evenNumber in evenNumbers.sorted() {
    "\(evenNumber) is an even number."
}

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
