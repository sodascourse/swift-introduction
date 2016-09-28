/*:

 # Fix the Fahrenheit Unit
 
 Now, it's your turn to fix the Fahrenheit unit.
 
 > Hint: The convert function should accept a `Float` parameter which is the 
 >       temperature to convert. And it should return a `Float` output which
 >       is the converted value.

 */

let ovenPanel = OvenPanel()

// Apply previous fix to the Kelvin unit
func convertKelvin(from celsius: Float) -> Float {
    return celsius + 273.15
}
ovenPanel.kelvinConverter = convertKelvin(from:)

//:
//: Write your fix in following lines:
//: 1. Create a converter function for the Fahrenheit unit
//: 2. Assign the function to `ovenPanel.fahrenheitConverter`
//:

//ovenPanel.fahrenheitConverter = ...

/*:

 Let's show the fixed oven panel in the playground

 */
ovenPanel.showInPlayground()

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
