//
//  ChargeDTO.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation

// MARK: - ChargeDTO
struct ChargeDTO: Codable {
    let objects: [ChargeResult]
    let totalNum: Int

    enum CodingKeys: String, CodingKey {
        case objects
        case totalNum = "total_num"
    }
}

// MARK: - Object
struct ChargeResult: Codable {
    let id, createdAt, updatedAt: Int
    let name, code, address, city: String
    let zip, postalCode: String
    let country: ChargeCountry
    let latitude, longitude: Double?
    let configurationStatus: ChargeConfigurationStatus
    let customAttributes, customFields: ChargeCustom
    let index: Int
    let connectors: [ChargeConnector]
    let chargingStation: ChargeChargingStation
    let status: ChargeStatus
    let electricCurrentType: ChargeElectricCurrentType
    let location: ChargeLocation
    let reservable, roaming: Bool
    let reportedAt: Int
    let operationalStatus: ChargeOperationalStatus

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name, code, address, city, zip
        case postalCode = "postal_code"
        case country, latitude, longitude
        case configurationStatus = "configuration_status"
        case customAttributes = "custom_attributes"
        case customFields = "custom_fields"
        case index, connectors
        case chargingStation = "charging_station"
        case status
        case electricCurrentType = "electric_current_type"
        case location, reservable, roaming
        case reportedAt = "reported_at"
        case operationalStatus = "operational_status"
    }
}

// MARK: - ChargingStation
struct ChargeChargingStation: Codable {
    let id: Int
    let name, code, serialNumber, model: String
    let vendor: String
    let operationalStatus: ChargeOperationalStatus
    let connection: ChargeConnection
    let site: ChargeSite
    let siteID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case serialNumber = "serial_number"
        case model, vendor
        case operationalStatus = "operational_status"
        case connection, site
        case siteID = "site_id"
    }
}

enum ChargeConnection: String, Codable {
    case webSocket = "web_socket"
}

enum ChargeOperationalStatus: String, Codable {
    case inoperative = "inoperative"
    case operative = "operative"
}

// MARK: - Site
struct ChargeSite: Codable {
    let id: Int
}

enum ChargeConfigurationStatus: String, Codable {
    case template = "template"
}

// MARK: - Connector
struct ChargeConnector: Codable {
    let id, createdAt, updatedAt: Int
    let name, code: String
    let index: Int
    let status: ChargeStatus
    let type: ChargeTypeEnum
    let amperageLimit, wattageLimit, voltageLimit, powerFactor: Int
    let customAttributes, customFields: ChargeCustom
    let description: String?
    let operationalStatus: ChargeOperationalStatus

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name, code, index, status, type
        case amperageLimit = "amperage_limit"
        case wattageLimit = "wattage_limit"
        case voltageLimit = "voltage_limit"
        case powerFactor = "power_factor"
        case customAttributes = "custom_attributes"
        case customFields = "custom_fields"
        case description
        case operationalStatus = "operational_status"
    }
}

// MARK: - Custom
struct ChargeCustom: Codable {
    let connectorType: String?
    let lastReportedInfo: ChargeLastReportedInfo?
    let lastReportedErrorCode: ChargeLastReportedErrorCode?
    let lastReportedVendorErrorCode: ChargeLastReportedVendorErrorCode?

    enum CodingKeys: String, CodingKey {
        case connectorType = "connector_type"
        case lastReportedInfo = "last_reported_info"
        case lastReportedErrorCode = "last_reported_error_code"
        case lastReportedVendorErrorCode = "last_reported_vendor_error_code"
    }
}

enum ChargeLastReportedErrorCode: Codable {
    case noError
    case unknown(String) // Gözlənilməyən dəyərləri saxlamaq üçün

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "NO_ERROR":
            self = .noError
        default:
            self = .unknown(rawValue) // Gözlənilməyən dəyərləri unknown case-də saxla
            print("⚠️ Unknown ChargeLastReportedErrorCode received: \(rawValue)") // Debug üçün çap et
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .noError:
            try container.encode("NO_ERROR")
        case .unknown(let value):
            try container.encode(value) // Gözlənilməyən dəyərləri JSON-a olduğu kimi yaz
        }
    }
}

enum ChargeLastReportedInfo: Codable {
    case empty
    case reasonNoneCpv0Rv0
    case reasonRmtStartCpv0Rv0
    case unknown(String) // Catch-all case for unexpected values

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "/":
            self = .empty
        case "{\"reason\":\"None\",\"cpv\":0,\"rv\":0}":
            self = .reasonNoneCpv0Rv0
        case "{\"reason\":\"rmtStart\",\"cpv\":0,\"rv\":0}":
            self = .reasonRmtStartCpv0Rv0
        default:
            self = .unknown(rawValue) // Store unexpected values
            print("⚠️ Unknown ChargeLastReportedInfo received: \(rawValue)") // Debug log
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .empty:
            try container.encode("/")
        case .reasonNoneCpv0Rv0:
            try container.encode("{\"reason\":\"None\",\"cpv\":0,\"rv\":0}")
        case .reasonRmtStartCpv0Rv0:
            try container.encode("{\"reason\":\"rmtStart\",\"cpv\":0,\"rv\":0}")
        case .unknown(let value):
            try container.encode(value) // Preserve unknown values
        }
    }
}


enum ChargeLastReportedVendorErrorCode: Codable {
    case empty
    case known(String) // Məlum dəyərləri saxlamaq üçün
    case unknown(String) // Gözlənilməyən dəyərləri saxla

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "/":
            self = .empty
        case "0x0000000000000000":
            self = .known(rawValue) // Əlavə məlum dəyərlər əlavə edilə bilər
        default:
            self = .unknown(rawValue) // Gözlənilməyən dəyərləri unknown case-də saxla
            print("⚠️ Unknown ChargeLastReportedVendorErrorCode received: \(rawValue)") // Debug üçün çap et
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .empty:
            try container.encode("/")
        case .known(let value):
            try container.encode(value)
        case .unknown(let value):
            try container.encode(value)
        }
    }
}


enum ChargeStatus: Codable {
    case available
    case charging
    case finishing
    case unavailable
    case unknown(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue {
        case "available":
            self = .available
        case "charging":
            self = .charging
        case "finishing":
            self = .finishing
        case "unavailable":
            self = .unavailable
        default:
            self = .unknown(rawValue)
            print("Unknown ChargeStatus received: \(rawValue)")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .available:
            try container.encode("available")
        case .charging:
            try container.encode("charging")
        case .finishing:
            try container.encode("finishing")
        case .unavailable:
            try container.encode("unavailable")
        case .unknown(let value):
            try container.encode(value) // Gözlənilməyən dəyəri JSON-a olduğu kimi yaz
        }
    }
}



enum ChargeTypeEnum: String, Codable {
    case cCcs1 = "c_ccs_1"
    case cCcs2 = "c_ccs_2"
    case cG105 = "c_g105"
    case cGbt = "c_gbt"
    case cType1 = "c_type_1"
}

enum ChargeCountry: String, Codable {
    case azerbaijan = "Azerbaijan"
}

enum ChargeElectricCurrentType: String, Codable {
    case acSinglePhase = "AC_single_phase"
    case dc = "DC"
}

// MARK: - Location
struct ChargeLocation: Codable {
    let latitude, longitude: Double
}

extension ChargeResult {
    func switchDTOtoDetail() -> DetailModel {
        let safeLatitude = latitude ?? 0.0
        let safeLongitude = longitude ?? 0.0

        // **Bütün `connectors` adlarını və statuslarını toplayırıq**
        let chargerNames = connectors.compactMap { $0.type.rawValue }
        let statuses = connectors.compactMap { connector in
            switch connector.status {
            case .available:
                return "Available"
            case .charging:
                return "Charging"
            case .finishing:
                return "Finishing"
            case .unavailable:
                return "Unavailable"
            case .unknown(let value):
                return value
            }
        }

        // Əgər array boşdursa, default dəyər veririk
        let safeCharger = chargerNames.isEmpty ? "No connectors" : chargerNames.joined(separator: ", ")
        let safeStatus = statuses.isEmpty ? "No status" : statuses.joined(separator: ", ")

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
