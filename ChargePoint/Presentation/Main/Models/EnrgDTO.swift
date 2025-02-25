import Foundation

// MARK: - Stansiya DTO
struct EnrgDTO: Codable {
    let id: String
    let name: String
    let location: EnrgLocation
    let about: String
    let openHours: EnrgOpenHours
    let address: String
    let chargers: [EnrgCharger]
    let isOpen: Bool
    let availability: String
    let images: [String]
}

struct EnrgLocation: Codable {
    let latitude: Double?
    let longitude: Double?
}

struct EnrgOpenHours: Codable {
    let dailyOpenHours: [EnrgDailyOpenHour]
}

struct EnrgDailyOpenHour: Codable {
    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}

struct EnrgCharger: Codable {
    let id: String
    let stationId: String
    let connectors: [EnrgConnector]
    let currentType: String
    let maxPower: Int
    let ownerId: String
}

struct EnrgConnector: Codable {
    let number: Int
    let chargerId: String
    let plugType: EnrgPlugType
    let hourlyChargingPrice: EnrgPrice
    let kwhPrice: EnrgPrice
    let hourlyDowntimePrice: EnrgPrice
    let isAvailable: Bool
}

struct EnrgPlugType: Codable {
    let id: Int
    let name: String
}

struct EnrgPrice: Codable {
    let value: Double
    let currency: EnrgCurrency
}

struct EnrgCurrency: Codable {
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

typealias EnergyDTO = [EnrgDTO]
