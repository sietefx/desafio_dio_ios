enum Priority: Comparable, Codable, Hashable, CustomStringConvertible {
    case low
    case medium
    case high(impact: Int)

    static func < (lhs: Priority, rhs: Priority) -> Bool {
        func rank(_ p: Priority) -> Int {
            switch p {
            case .low: return 0
            case .medium: return 1
            case .high(let impact): return 2 + impact
            }
        }
        return rank(lhs) < rank(rhs)
    }

    private enum CodingKeys: String, CodingKey { case caseName, impact }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .low: try container.encode("low", forKey: .caseName)
        case .medium: try container.encode("medium", forKey: .caseName)
        case .high(let impact):
            try container.encode("high", forKey: .caseName)
            try container.encode(impact, forKey: .impact)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .caseName) {
        case "low": self = .low
        case "medium": self = .medium
        case "high": self = .high(impact: try container.decode(Int.self, forKey: .impact))
        default: throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid case"))
        }
    }

    var description: String {
        switch self {
        case .low: return "Low Priority"
        case .medium: return "Medium Priority"
        case .high(let impact): return "High Priority (impact: \(impact))"
        }
    }
}
