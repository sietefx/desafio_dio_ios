import UIKit

var someInt: [Int] = []
print("someInt: \(someInt.count)")
someInt.append(3)

var threeDoubles = Array(repeating: 0.0, count: 3)

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles: [Double] = threeDoubles + anotherThreeDoubles

var shoppingList: [String] = ["Açúcar", "Sal", "Pimenta"]
print("A list de compras contém \(shoppingList.count) itens.")

if shoppingList.isEmpty {
    print("A lista de compras está vazia.")
} else {
    print("A lista de compras não está vazia.")
}
shoppingList.append("Farinha")

shoppingList += ["Ovos", "Café", "Queijo"]
print("A list de compras contém \(shoppingList.count) itens.")

var firstItem = shoppingList[0]
shoppingList[4...6] = ["Pão", "Manteiga"]
print(shoppingList)

shoppingList.insert("Cuzcuz", at: 0)
print(shoppingList)

let mapleSyrup = shoppingList.remove(at: 0)
print("Removido: \(mapleSyrup)")
print(shoppingList)

firstItem = shoppingList[0]
print(shoppingList)

let apple = shoppingList.removeLast()
print(shoppingList)

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

var letters = Set<Character>()
print("Letters é do tipo Set<Character>: \(letters.count) itens.")
letters.insert("a")
letters = []

var favoriteGenres: Set<String> = ["Gauchesca", "Rock", "Pop", "Hip-Hop"]
var newFavoriteGenres: Set = ["Rock", "Classic", "Blues"]

print("Eu tenho \(favoriteGenres.count) gêneros de música favoritos")
if favoriteGenres.isEmpty {
    print("Não sou exigente")
} else {
    print("Gosto de alguns gostos")
}

favoriteGenres.insert("Jazz")

if let removeGenre = favoriteGenres.remove("Hip-Hop") {
    print("Removi: \(removeGenre)")
} else {
    print("Eu nunca me importei com Hip-Hop")
}

if favoriteGenres.contains("Rock") {
    print("Adoro rock!")
} else {
    print("Tem gosto pra tudo")
}

for genre in favoriteGenres {
    print("\(genre)")
}
print(favoriteGenres)


print("Ordenado")
let arrayOrdenado = favoriteGenres.sorted()
for genre in arrayOrdenado {
    print("\(genre)")
}
print(arrayOrdenado)

let oddDigits: Set = [1, 3, 5, 7, 9]
let evendDigits: Set = [0, 2, 4, 6, 8]
let singleDigitsPrimeNumber: Set = [2, 3, 5, 7]
oddDigits.union(evendDigits).sorted()
print(oddDigits)
oddDigits.intersection(evendDigits).sorted()
oddDigits.subtracting(singleDigitsPrimeNumber).sorted()
oddDigits.symmetricDifference(singleDigitsPrimeNumber).sorted()


var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[16] = "dezesseis"
namesOfIntegers = [:]

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin", "BCN": "Barcelona"]
var literalAirports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

print("O dicionário de aeroportos contém \(airports.count) itens.")

if airports.isEmpty {
    print("O dicionário de aeroportos não está vazio.")
} else {
    print("O dicionário de aeroportos não está vazio")
}
airports["LHR"] = "London"

airports["LHR"] = "London Heathrow"

print(airports.count)

if let oldValues = airports.updateValue("Dublin", forKey: "DUB") {
    print("O valor antigo para DUB era \(oldValues)")
}

if let airportName = airports["DUB"] {
    print("O nome do aeroporto de Dublin é \(airportName)")
} else {
    print("Não tenho informação sobre o aeroporto de Dublin")
}
print(airports.count)

if let removeValue = airports.removeValue(forKey: "DUB") {
    print("Removido o \(removeValue)")
} else {
    print("O dicionário de aeroportos não contém um valor para DUB.")
}
for (airportsCode, airportName) in airports {
    print("\(airportsCode): \(airportName)")
}
