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

extension EnrgDTO {
    func switchDTOtoModel() -> DetailModel {
        let safeLatitude = location.latitude ?? 0.0
        let safeLongitude = location.longitude ?? 0.0

        // Bütün `chargers` içindəki bütün `connectors`-ları toplayırıq
        let allConnectors = chargers.compactMap { $0.connectors }.flatMap { $0 }

        // Əgər heç bir `connector` yoxdursa, default dəyər qaytarırıq
        guard !allConnectors.isEmpty else {
            return DetailModel(
                name: name,
                address: address,
                latitude: safeLatitude,
                longitude: safeLongitude,
                charger: "No connectors",
                status: "No status"
            )
        }

        // **Bütün `connectors` adlarını və statuslarını toplayırıq**
        let chargerNames = allConnectors.compactMap { $0.plugType.name }
        let statuses = allConnectors.compactMap { $0.isAvailable ? "Available" : "Unavailable" }

        // Əgər array boşdursa, default dəyər veririk
        let safeCharger = chargerNames.isEmpty ? "N/A" : chargerNames.joined(separator: ", ")
        let safeStatus = statuses.isEmpty ? "N/A" : statuses.joined(separator: ", ")

        return DetailModel(
            name: name,
            address: address,
            latitude: safeLatitude,
            longitude: safeLongitude,
            charger: safeCharger,
            status: safeStatus
        )
    }
}
