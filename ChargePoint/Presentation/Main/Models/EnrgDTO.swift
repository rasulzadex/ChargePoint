import Foundation

// MARK: - Stansiya DTO
struct EnrgDTO: Codable {
    let id: String
    let name: String
    let location: LocationDTO
    let about: String
    let openHours: OpenHoursDTO
    let address: String
    let chargers: [ChargerDTO]
    let isOpen: Bool
    let availability: String
    let images: [String]
}

struct LocationDTO: Codable {
    let latitude: Double
    let longitude: Double
}

struct OpenHoursDTO: Codable {
    let dailyOpenHours: [DailyOpenHourDTO]
}

struct DailyOpenHourDTO: Codable {
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}

struct ChargerDTO: Codable {
    let id: String
    let stationId: String
    let connectors: [ConnectorDTO]
    let currentType: String
    let maxPower: Int
    let ownerId: String
}

struct ConnectorDTO: Codable {
    let number: Int
    let chargerId: String
    let plugType: PlugTypeDTO
    let hourlyChargingPrice: PriceDTO
    let kwhPrice: PriceDTO
    let hourlyDowntimePrice: PriceDTO
    let isAvailable: Bool
}

struct PlugTypeDTO: Codable {
    let id: Int
    let name: String
}

struct PriceDTO: Codable {
    let value: Double
    let currency: CurrencyDTO
}

struct CurrencyDTO: Codable {
    let id: Int
    let name: String
    let symbol: String?
}

// MARK: - JSON Parsing Functions
extension JSONDecoder {
    static func chargingStationDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}



//import Foundation
//
//// MARK: - Main DTO
//struct EnrgDTO: Codable {
//    let id, name: String
//    let location: EnrgLocation
//    let about: String
//    let openHours: EnrgOpenHours
//    let address: String
//    let chargers: [EnrgCharger]
//    let isOpen: Bool
//    let availability: EnrgAvailability
//    let images: [String]
//}
//
//enum EnrgAvailability: String, Codable {
//    case available = "Available"
//    case unavailable = "Unavailable"
//}
//
//// MARK: - Charger
//struct EnrgCharger: Codable {
//    let id, stationId: String
//    let connectors: [EnrgConnector]
//    let currentType: String
//    let maxPower: Int
//    let ownerId: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id, stationId, connectors, currentType, maxPower, ownerId
//    }
//}
//
//// MARK: - Connector
//struct EnrgConnector: Codable {
//    let number: Int
//    let chargerId: String
//    let plugType: EnrgPlugType
//    let hourlyChargingPrice, kwhPrice, hourlyDowntimePrice: EnrgPrice
//    let isAvailable: Bool
//}
//
//// MARK: - Price
//struct EnrgPrice: Codable {
//    let value: Double
//    let currency: EnrgCurrency
//}
//
//// MARK: - Currency
//struct EnrgCurrency: Codable {
//    let id: Int
//    let name: String
//    let symbol: EnrgJSONNull?
//}
//
//
//// MARK: - Plug Type
//struct EnrgPlugType: Codable {
//    let id: Int
//    let name: String
//}
//
//
//
//
//// MARK: - Location
//struct EnrgLocation: Codable {
//    let latitude, longitude: Double
//}
//
//// MARK: - Open Hours
//struct EnrgOpenHours: Codable {
//    let dailyOpenHours: [EnrgDailyOpenHour]
//}
//
//struct EnrgDailyOpenHour: Codable {
//    let dayOfWeek: Int
//    let startTime: String
//    let endTime: String
//}
//
//
//typealias Enrg = [EnrgDTO]
//
//// MARK: - JSON Null Helper
//class EnrgJSONNull: Codable, Hashable {
//    public static func == (lhs: EnrgJSONNull, rhs: EnrgJSONNull) -> Bool { true }
//    public func hash(into hasher: inout Hasher) {}
//    
//    public init() {}
//    
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(EnrgJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
