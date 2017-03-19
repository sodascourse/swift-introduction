/*:
 
 # Memory Management

 Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage.
 
 As the name implies, the ARC thing only applies to reference types. 
 Reference counting only applies to instances of classes. Structures and enumerations 
 are value types, not reference types, and are not stored and passed by reference.
 
 In most cases, this means that memory management “just works” in Swift, 
 and you do not need to think about memory management yourself. However, 
 in a few cases ARC requires more information about the relationships 
 between parts of code in order to manage memory for you.
 
 */

/*:
 
 `init` is the initializer which would be called when creating instances of a Type.
 `deinit` is the deinitializer, called when a reference type instance being freed.
 
 */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

print("Matt's section begins -----------------------")
var matt: Person? = Person(name: "Matt")
matt = nil
print("Matt's section ends -------------------------\n\n\n")


print("John's section begins -----------------------")
var person1: Person? = Person(name: "John")
var person2: Person? = person1
person1 = nil
print(">>> 'person1' is set to nil.")
person2 = nil
print(">>> 'person2' is set to nil.")
print("John section ends -------------------------\n\n\n")

/*:
 
 ARC requires extra information when there's a cycle in the graph of 
 the replationship among classes.
 
 */

class Author {
    let name: String
    var books = [Book]()

    init(name: String) {
        self.name = name
        print("<Author: \(name)> is being initialized")
    }
    deinit {
        print("<Author: \(name)> is being deinitialized")
    }
}

protocol Book {
    var title: String { get }
    var author: Author { get }
}

class BrokenBook: Book {
    let title: String
    let author: Author

    init(title: String, author: Author) {
        self.title = title
        self.author = author
        print("<BrokenBook: \(title)> is being initialized")
    }
    deinit {
        print("<BrokenBook: \(title)> is being deinitialized")
    }
}

/*:
 
 Using `unowned`

 */

class GoodBook: Book {
    let title: String
    unowned let author: Author

    init(title: String, author: Author) {
        self.title = title
        self.author = author
        print("<GoodBook: \(title)> is being initialized")
    }
    deinit {
        print("<GoodBook: \(title)> is being deinitialized")
    }
}

print("Broken Book's section begins -----------------------")
var rowling: Author? = Author(name: "J.K. Rowling")
var brokenBook1: Book? = BrokenBook(title: "Harry Potter 1", author: rowling!)
var brokenBook2: Book? = BrokenBook(title: "Harry Potter 2", author: rowling!)
rowling!.books.append(brokenBook1!)
rowling!.books.append(brokenBook2!)
print(">>> Start to clean objects ...")
brokenBook1 = nil
brokenBook2 = nil
rowling = nil
print("Broken Book's section ends -------------------------\n\n\n")



print("Good Book's section begins -----------------------")
var brown: Author? = Author(name: "Dan Brown")
var goodBook1: Book? = GoodBook(title: "Digital Fortress", author: brown!)
var goodBook2: Book? = GoodBook(title: "The Da Vinci Code", author: brown!)
brown!.books.append(goodBook1!)
brown!.books.append(goodBook2!)
print(">>> Start to clean objects ...")
goodBook1 = nil
goodBook2 = nil
brown = nil
print("Good Book's section ends -------------------------\n\n\n")

/*:

 Using `weak`

 */

class Dictionary {
    var bookmarks = [Bookmark]()
}

class Bookmark {
    weak var dictionary: Dictionary?
}

var dictionary: Dictionary? = Dictionary()
var bookmark: Bookmark? = Bookmark()
bookmark!.dictionary = dictionary!
dictionary!.bookmarks.append(bookmark!)

dictionary = nil
bookmark!.dictionary == nil

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
