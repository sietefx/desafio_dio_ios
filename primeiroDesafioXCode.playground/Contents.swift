var firstName = "Steve"
var lastName: String? = "Jobs"

// Print usando nil-coalescing como antes
print("\(firstName) \(lastName ?? "Wozniak")")

// Optional binding para desembrulhar e imprimir usando a variável desembrulhada
let finalLastName: String
if let unwrappedLastName = lastName {
    finalLastName = unwrappedLastName
} else {
    finalLastName = "Wozniak"
}
print("\(firstName) \(finalLastName)")
