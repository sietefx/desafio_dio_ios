import Foundation

struct Order {
    let id: Int
}

class ShippingService {
    func bestShippingQuote(for order: Order) async throws -> String {
        // Simulate a network call that might fail
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "Best quote for order \(order.id)"
    }
}

@MainActor
func runScenario() async throws {
    let order = Order(id: 123)
    let shippingService = ShippingService()
    let quote = try await shippingService.bestShippingQuote(for: order)
    print(quote)
}

Task { @MainActor in
    do {
        try await runScenario()
    } catch {
        print("Error: \(error)")
    }
}
