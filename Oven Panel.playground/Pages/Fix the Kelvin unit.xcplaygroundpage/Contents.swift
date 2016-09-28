/*:

 # Fix the Kelvin Unit

 */

let ovenPanel = OvenPanel()

/*:

 To fix the Kelvin unit, I create a convert function like this:

 */
func convertKelvin(from celsius: Float) -> Float {
    return celsius + 273.15
}

/*:
 
 And then assign it (via the name of the function) to a property of 
 the oven panel called `kelvinConverter`.
 
 */
ovenPanel.kelvinConverter = convertKelvin(from:)

/*:
 
 Now, the Kelvin unit is fixed.
 
 */
ovenPanel.showInPlayground()

//: ---
//:
//: [<- Previous](@previous) | [Next ->](@next)
//:
