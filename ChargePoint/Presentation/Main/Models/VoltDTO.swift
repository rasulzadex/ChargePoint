//
//  VoltDTO.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation

// MARK: - Response Model
struct VoltDTO: Codable {
    let success: Bool
    let timestamp: Int
    let country: String
    let result: [String: VoltResult]
}

// MARK: - Charging Station Model
struct VoltResult: Codable {
    let id: String
    let key: String
    let name: String
    let latitude: Double?
    let longitude: Double?
    let country: String
    let address: String
    let accessType: String
    let instruction: String?
    let customerNote: String?
    let openHours: String?
    let connectors: [VoltConnector]
    let images: [VoltImage]?
    let locationStats: VoltLocationStats
    let connectorStats: [String: VoltConnectorStats]
    let online: Bool
    let features: VoltFeatures
    let timestamp: Int
    let hash: Int
}

// MARK: - Connector Model
struct VoltConnector: Codable {
    let id: String
    let visibleId: String
    let evsePath: String
    let chargerName: String
    let type: String
    let state: String
    let availableAt: Int?
    let lastSeen: Int?
    let operatorName: String?
    let maxPower: Double
    let emergencyButtonPressed: Bool
    let price: VoltPrice
    let action: String?
    let country: String
    let customerMessage: String?
    let chargingStart: String?
    let reservationAllowed: Bool
    let parkingDiscount: Bool
    let hash: Int
    
    enum CodingKeys: String, CodingKey {
        case id, visibleId, evsePath, chargerName, type, state, availableAt, lastSeen
        case operatorName = "operator"
        case maxPower, emergencyButtonPressed, price, action, country, customerMessage
        case chargingStart, reservationAllowed, parkingDiscount, hash
    }
}

// MARK: - Price Model
struct VoltPrice: Codable {
    let type: String
    let modeStart: String?
    let modeKwh: String?
    let modeTime: String?
    let post: VoltPostPrice?
    let start: [String: Double]?
    let kwh: [String: Double]?
    let time: [String: Double]?
    let descriptionKwh: String?
    let descriptionTime: String?
}

// MARK: - PostPrice Model
struct VoltPostPrice: Codable {
    let type: String
    let price: VoltPriceValue?
    let gracePeriod: Double?
    let description: String?
}

// MARK: - Image Model
struct VoltImage: Codable {
    let fileName: String
    let fileSize: Int
    let src: String
}

// MARK: - LocationStats Model
struct VoltLocationStats: Codable {
    let total: Int
    let available: Int
    let networked: Int
    let inuse: Int
    let fault: Int
    let maintenance: Int
}

// MARK: - ConnectorStats Model
struct VoltConnectorStats: Codable {
    let total: Int
    let available: Int
    let networked: Int
    let inuse: Int
    let fault: Int
    let maintenance: Int
}

// MARK: - Features Model
struct VoltFeatures: Codable {
    let parkingDiscount: Bool
}
enum VoltPriceValue: Codable {
    case double(Double)
    case object([String: Any])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Əgər Double tipindədirsə, decode et
        if let doubleValue = try? container.decode(Double.self) {
            self = .double(doubleValue)
            return
        }

        // Əgər JSON obyektidirsə (Dictionary formatında)
        if let dictionaryValue = try? container.decode([String: AnyDecodable].self) {
            self = .object(dictionaryValue.mapValues { $0.value })
            return
        }

        // Əgər heç biri uyğun gəlmirsə, error atırıq
        throw DecodingError.typeMismatch(VoltPriceValue.self, DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Price neither Double nor valid dictionary."
        ))
    }

    // ✅ `Encodable` üçün xüsusi `encode(to:)` metodu
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .double(let value):
            try container.encode(value)
        case .object(let dict):
            try container.encode(dict.mapValues { AnyEncodable(value: $0) })
        }
    }
}

// 🔹 **AnyDecodable** köməkçi struct-ı (Dictionary-də Any işlədə bilmək üçün lazımdır)
struct AnyDecodable: Decodable {
    let value: Any

    init(from decoder: Decoder) throws {
        if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            self.value = doubleValue
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self.value = stringValue
        } else if let dictValue = try? decoder.singleValueContainer().decode([String: AnyDecodable].self) {
            self.value = dictValue.mapValues { $0.value }
        } else if let arrayValue = try? decoder.singleValueContainer().decode([AnyDecodable].self) {
            self.value = arrayValue.map { $0.value }
        } else {
            throw DecodingError.typeMismatch(AnyDecodable.self, DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Unsupported type in JSON"
            ))
        }
    }
}

// 🔹 **AnyEncodable** köməkçi struct-ı (Dictionary-də Any encode etmək üçün lazımdır)
struct AnyEncodable: Encodable {
    let value: Any

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let doubleValue = value as? Double {
            try container.encode(doubleValue)
        } else if let stringValue = value as? String {
            try container.encode(stringValue)
        } else if let dictValue = value as? [String: Any] {
            try container.encode(dictValue.mapValues { AnyEncodable(value: $0) })
        } else if let arrayValue = value as? [Any] {
            try container.encode(arrayValue.map { AnyEncodable(value: $0) })
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(
                codingPath: encoder.codingPath,
                debugDescription: "Unsupported type in JSON"
            ))
        }
    }
}
extension VoltResult {
    func switchDTOtoDetail() -> DetailModel {
        // Əgər koordinatlar `nil`-dırsa, `0.0` təyin edirik
        let safeLatitude = latitude ?? 0.0
        let safeLongitude = longitude ?? 0.0

        // Bütün `connectors` array-i
        let allConnectors = connectors

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
        let chargerNames = allConnectors.compactMap { $0.type }
        let statuses = allConnectors.compactMap { $0.state }

        // Əgər array boşdursa, default dəyər veririk
        let safeCharger = chargerNames.isEmpty ? "Unknown" : chargerNames.joined(separator: ", ")
        let safeStatus = statuses.isEmpty ? "Unknown" : statuses.joined(separator: ", ")

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
