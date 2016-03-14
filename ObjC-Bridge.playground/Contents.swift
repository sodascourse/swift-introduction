//: # Objective-C Bridging
//:
//: Swift is designed to provide seamless compatibility with Cocoa and Objective-C.
//: You can use Objective-C APIs in Swift, and you can use Swift APIs in Objective-C.
//: This makes Swift an easy, convenient, and powerful tool to integrate into your
//: development workflow.
//:
//:
//: ## Module import
//:
//: In Swift, we use `import` statement to include other modules.
//:

import Foundation

//:
//: `Foundation` provides most Objective-C data structure and basic APIs.
//: 
//: There are also some common used modules:
//: * `UIKit` - provides user interfaces and platform related APIs for iOS and tvOS.
//: * `AppKit` - provides user interfaces and platform related APIs for OS X.
//: * `WatchKit` - provides user interfaces and platform related APIs for watchOS.
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Bridged Swift Types
//:
//: Swift built-in types are bridged to corresponding classes in Objective-C.
//:
//: ### `Any` and `AnyObject`
//:
//: In Swift, there's 2 protocols could be used as types representing **any instances.**
//: * `Any` - represents any instances of Swift types, including _enum_, _struct_, and _class_.
//: * `AnyObject` - represents any instances of Swift classes.
//:

class SomeClass {}
struct SomeStruct {}

var anyVar: Any = "Hello World!"
anyVar = 42
anyVar = SomeClass()
anyVar = SomeStruct()

var anyObjectVar: AnyObject = SomeClass()
//anyObjectVar = SomeStruct()  // ERROR: Uncomment this line to see what error message is emmited.

//:
//: Objective-C doesn't support the **Generic** concept. Hence generic types would be converted to `AnyObject` during
//: bridging between these 2 languages.
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: ### Bridging basic types
//:
//: To bridge Swift types to Objective-C types, just assign instances of Swift types to variables of Objective-C types.
//: But to bridge Objective-C types to Swift types, you have to use `as` cast operator explicitly.
//:

let swiftString: String = "Hello World!"
let nsString1: NSString = swiftString
let nsString2: NSString = swiftString as NSString
let swiftStringFromNSString1: String = nsString1 as String
//let swiftStringFromNSString2: String = nsString1  // ERROR: Uncomment this line to see what error message you get

let integer: Int = 42
let nsNumber = integer as NSNumber
let swiftIntegerFromNSNumber = nsNumber as Int
let swiftFloatFromNSNumber = nsNumber as Float

let boolean = true
let nsNumberBool = boolean as NSNumber
let swiftBoolFromNSNumber1 = nsNumberBool as Bool
let swiftBoolFromNSNumber2 = nsNumberBool.boolValue  // You can also use Objective-C's method

//: ### Bridging for function arguments

func swiftAdd(a: Int, _ b: Int) -> Int {
    return a + b
}

func nsAdd(a: NSNumber, _ b: NSNumber) -> NSNumber {
    return NSNumber(integer: a.integerValue + b.integerValue)
}

let nsNumber1 = 1 as NSNumber
let nsNumber2 = 2 as NSNumber
let nsNumber3: NSNumber = swiftAdd(nsNumber1 as Int, nsNumber2 as Int)

let swiftNumber1 = 1
let swiftNumber2 = 2
let swiftNumber3: Int = nsAdd(swiftNumber1, swiftNumber2) as Int

//: ### Bridging collection types
//:
//: By default, Objective-C collections would be bridged to Swift's corresponding collection types with **AnyObject** as
//: generic types.
//:
//: Use _downcast operator_ (`as?` and `as!`) to bridge Objective-C collections into Swift collection types with a 
//: restricted generic type.
//:
//: > NOTE: Check documentation of Objective-C APIs you are using before determining the type you want to cast to.
//:         Some modern Objective-C APIs are able to handle generic concept, and hence those APIs would be bridged to
//:         Swift collections with correct generic type. For such APIs, you don't have to use downcast operatos.
//:
//: > NOTE: `NSDictionary` is bridged to Swift as `[NSObject: AnyObject]` where `NSObject` is the base class of 
//:         Objective-C types.
//:

let swiftArray = [1, 2, 3] as [Int]
let nsArray1: NSArray = swiftArray
let swiftArrayFromNSArray1 = nsArray1 as [AnyObject]
let swiftArrayFromNSArray2 = nsArray1 as? [Int]
let swiftArrayFromNSArray3 = nsArray1 as! [Int]

let nsArray2: NSArray = [1, "XD", 2]
let swiftArrayFromNSArray4 = nsArray2 as? [Int]

//: --------------------------------------------------------------------------------------------------------------------
//:
//: ## Calling Objective-C's APIs with Swift types
//:
//: Swift types could call the method of their corresponding Objective-C classes directly.
//:
//: Like following example, `NSData` is the class `Foundation` used to represent bytes, and `dataUsingEncoding(_:)` 
//: is a method of `NSString` which would convert the string into bytes.
//:

let helloWorldSwiftString: String = "Hello World!"
let helloWorldNSData = helloWorldSwiftString.dataUsingEncoding(NSASCIIStringEncoding)

//:
//:
//: --------------------------------------------------------------------------------------------------------------------
//:
//: References: 
//: * [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216-CH2-ID0)
//:
