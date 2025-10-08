import UIKit

let individualScores = [73, 43, 103, 87, 12]
var teamScores = 0
for score in individualScores {
    if score > 50 {
        teamScores += 3
    } else {
        teamScores += 1
    }
}
print(teamScores)
var optionalString: String? = "Hello, world!"
print(optionalString == nil)
var optionalName: String? = "João dos Santos"
var greeting = "Hello"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

let nickName: String? = nil
let fullName: String = "João de Deus"
let informalGreeting = "Oi, \(nickName ?? fullName)"

if let nickName {
    print("Capaz, \(nickName)")
}

let vegetable = "Pimentão Vermelho"
switch vegetable {
case "Salsão":
    print("Obrigado por me pedir, mas não tenho salsão.")
case "Pepino":
    print("Adiocione um pepininho")
case let x where x.hasPrefix( "P" ):
    print("Por que consumir \(x)?")
default:
    print("Só no açúcar")
}

let interestingNumbers = [
    "Melhor": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Quadrado": [1, 4, 9, 16, 25]
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

var n = 2
while n < 100 {
    n *= 2
}
print(n)

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)

