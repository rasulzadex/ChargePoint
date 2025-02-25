//
//  TokDTO.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//
import Foundation

// MARK: - TokDTO
struct TokDTO: Codable {
    let objects: [TokResult]
    let totalNum: Int

    enum CodingKeys: String, CodingKey {
        case objects
        case totalNum = "total_num"
    }
}

// MARK: - Object
struct TokResult: Codable {
    let id, createdAt, updatedAt: Int
    let name, code, address, city: String
    let zip, postalCode: String
    let country: TokCountry
    let latitude, longitude: Double?
    let configurationStatus: TokConfigurationStatus
    let customAttributes, customFields: TokCustom
    let index: Int
    let connectors: [TokConnector]
    let chargingStation: TokChargingStation
    let status: TokStatus
    let electricCurrentType: TokElectricCurrentType
    let location: TokLocation
    let reservable, roaming: Bool
    let roamingID: String?
    let reportedAt: Int
    let operationalStatus: TokOperationalStatus

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
        case roamingID = "roaming_id"
        case reportedAt = "reported_at"
        case operationalStatus = "operational_status"
    }
}

// MARK: - ChargingStation
struct TokChargingStation: Codable {
    let id: Int
    let name, code, serialNumber, model: String
    let vendor: TokVendor
    let operationalStatus: TokOperationalStatus
    let connection: TokConnection
    let site: TokSite
    let siteID: Int
    let physicalAddress: String?

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case serialNumber = "serial_number"
        case model, vendor
        case operationalStatus = "operational_status"
        case connection, site
        case siteID = "site_id"
        case physicalAddress = "physical_address"
    }
}

enum TokConnection: String, Codable {
    case webSocket = "web_socket"
}

enum TokOperationalStatus: String, Codable {
    case inoperative = "inoperative"
    case operative = "operative"
}

// MARK: - Site
struct TokSite: Codable {
    let id: Int
}

enum TokVendor: String, Codable {
    case internet = "'internet'"
    case simpleCharge = "SimpleCharge"
    case tokaz = "TOKAZ"
    case tokazLlc = "TOKAZ LLC"
    case zjbeny = "ZJBENY"
}

enum TokConfigurationStatus: String, Codable {
    case template = "template"
}

// MARK: - Connector
struct TokConnector: Codable {
    let id, createdAt, updatedAt: Int
    let name, code: String
    let index: Int
    let status: TokStatus
    let type: TokTypeEnum
    let amperageLimit, wattageLimit, voltageLimit, powerFactor: Int
    let customAttributes, customFields: TokCustom
    let roamingID: String?
    let operationalStatus: TokOperationalStatus
    let description: String?

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
        case roamingID = "roaming_id"
        case operationalStatus = "operational_status"
        case description
    }
}

// MARK: - Custom
struct TokCustom: Codable {
    let lastReportedInfo: TokLastReportedInfo
    let lastReportedErrorCode: TokLastReportedErrorCode
    let lastReportedVendorErrorCode: String

    enum CodingKeys: String, CodingKey {
        case lastReportedInfo = "last_reported_info"
        case lastReportedErrorCode = "last_reported_error_code"
        case lastReportedVendorErrorCode = "last_reported_vendor_error_code"
    }
}


enum TokLastReportedErrorCode: Codable {
    case noError
    case otherError
    case unknown(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "NO_ERROR":
            self = .noError
        case "OTHER_ERROR":
            self = .otherError
        default:
            self = .unknown(rawValue) // Gözlənilməyən dəyərləri unknown case-də saxla
            print("Unknown ChargeLastReportedErrorCode received: \(rawValue)") // Debug üçün çap et
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .noError:
            try container.encode("NO_ERROR")
        case .unknown(let value):
            try container.encode(value) // Gözlənilməyən dəyərləri JSON-a olduğu kimi yaz
        case .otherError:
            try container.encode("OTHER_ERROR")
        }
    }
}


enum TokLastReportedInfo: String, Codable {
    case empty = "/"
}

enum TokStatus: String, Codable {
    case available = "available"
    case charging = "charging"
    case faulted = "faulted"
    case finishing = "finishing"
    case unavailable = "unavailable"
    case unknown

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self = TokStatus(rawValue: (try? container.decode(String.self)) ?? "") ?? .unknown
        }
}


enum TokTypeEnum: String, Codable {
    case cCcs1 = "c_ccs_1"
    case cCcs2 = "c_ccs_2"
    case cGbt = "c_gbt"
}

enum TokCountry: String, Codable {
    case azerbaijan = "Azerbaijan"
}

enum TokElectricCurrentType: String, Codable {
    case dc = "DC"
}

// MARK: - Location
struct TokLocation: Codable {
    let latitude, longitude: Double
}

