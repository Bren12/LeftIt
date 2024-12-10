import UIKit

let x = 8.625
let y = 0.12
let item1 = 1
let item2 = 7


let r = x.remainder(dividingBy: y)
// r == -0.375


let q = (0.0-5.0).remainder(dividingBy: Double(24))
let s = (0.0-6.0).remainder(dividingBy: Double(24))

for i in 0...24 {
    print((0.0-Double(i)).remainder(dividingBy: Double(24)))
}
