/*:

 # Add Food Recommendation

 We want this oven smart, so it should be able to hint the user about suitable
 food for current temperature setting.

 */

let ovenPanel = OvenPanel.thermometerFixedPanel()

/*:
 
 To achieve this, you have to write a function which accepts a `Float` parameter, the 
 current temperature, as input. And the function would return a `String` output, the name
 of recommended food.
 
 Like this
 ```
 func recommendFood(for temperture: Float) -> String {
     return "meat"
 }
 ```
 
 And for your reference, the food we recommend are:
 - **Vegetables** from _60 °C_ to _120 °C_
 - **Beef Steak** from _121 °C_ to _180 °C_
 - **Fish Fillets** from _181 °C_ to _240 °C_
 - **Cookies and Cake** from _241 °C_ to _300 °C_
 
 */

//ovenPanel.getRecommendedFood = ...

/*:

 Let's show the enhanced oven panel in the playground

 */
ovenPanel.showInPlayground()

//: ---
//:
//: [<- Previous](@previous)
//:
