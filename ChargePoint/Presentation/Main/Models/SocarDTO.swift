//
//  SocarDTO.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//

import Foundation

// MARK: - SocarDTO
struct SocarDTO: Codable {
    let count: Int?
    let next, previous: SocarJSONNull?
    let results: [SocarResult]
}

// MARK: - Result
struct SocarResult: Codable {
    let id: String?
    let chargerCount: Int?
    let chargers: [SocarCharger]?
    let host: String?
    let latitude, longitude: Double?
    let mobileCountryCode, mobileContactNumber: String?
    let propertyManagers: [SocarJSONAny]?
    let favourite: Bool?
    let name: String?
    let contactNumber, whatsappNumber, pincode: String?
    let address, city: String?
    let state: SocarState?
    let country: SocarCountry?
    let countryISOCode: SocarJSONNull?
    let isLoadManagementEnabled: Bool?
    let maxChargingLoad: Int?
    let workingHours: SocarJSONNull?
    let facilities, otherFacilities: [String]?
    let parkingType, direction: String?
    let photos: SocarJSONNull?
    let openingTimes: SocarOpeningTimes?
    let chargingWhenClosed, availableForOcpi: Bool?
    let gracePeriod: Int?
    let propertyTimezone: String?
    let image: String?
    let updatedAt: String?
    let user: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case chargerCount = "charger_count"
        case chargers, host, latitude, longitude
        case mobileCountryCode = "mobile_country_code"
        case mobileContactNumber = "mobile_contact_number"
        case propertyManagers = "property_managers"
        case favourite, name
        case contactNumber = "contact_number"
        case whatsappNumber = "whatsapp_number"
        case pincode, address, city, state, country
        case countryISOCode = "country_iso_code"
        case isLoadManagementEnabled = "is_load_management_enabled"
        case maxChargingLoad = "max_charging_load"
        case workingHours = "working_hours"
        case facilities
        case otherFacilities = "other_facilities"
        case parkingType = "parking_type"
        case direction, photos
        case openingTimes = "opening_times"
        case chargingWhenClosed = "charging_when_closed"
        case availableForOcpi = "available_for_ocpi"
        case gracePeriod = "grace_period"
        case propertyTimezone = "property_timezone"
        case image
        case updatedAt = "updated_at"
        case user
    }
}

// MARK: - Charger
struct SocarCharger: Codable {
    let id: String?
    let connectorCount: Int?
    let connectors: [SocarConnector]?
    let capacity: Int?
    let name, lastHeartbeatOn, oemSerialNumber: String?
    let isOcppCompliant: Bool?
    let directions: String?
    let status: SocarChargerStatus?
    let isPublic, showOnMap, reservationSupported, isPromotional: Bool?
    let landmark: String?
    let model: String?
    let firmwareVersion: SocarFirmwareVersion?
    let firmwareUpdatedAt: SocarFirmwareUpdatedAt?
    let updateFirmwareVersion, hasOcppIssues: Bool?
    let lastStatusUpdatedAt, updatedAt, oem: String?

    enum CodingKeys: String, CodingKey {
        case id
        case connectorCount = "connector_count"
        case connectors, capacity, name
        case lastHeartbeatOn = "last_heartbeat_on"
        case oemSerialNumber = "oem_serial_number"
        case isOcppCompliant = "is_ocpp_compliant"
        case directions, status
        case isPublic = "is_public"
        case showOnMap = "show_on_map"
        case reservationSupported = "reservation_supported"
        case isPromotional = "is_promotional"
        case landmark, model
        case firmwareVersion = "firmware_version"
        case firmwareUpdatedAt = "firmware_updated_at"
        case updateFirmwareVersion = "update_firmware_version"
        case hasOcppIssues = "has_ocpp_issues"
        case lastStatusUpdatedAt = "last_status_updated_at"
        case updatedAt = "updated_at"
        case oem
    }
}

// MARK: - Connector
struct SocarConnector: Codable {
    let id: String?
    let name: SocarName?
    let oemConnectorNumber: Int?
    let connectorType: SocarConnectorType?
    let maxUnitPerHour: Int?
    let type: SocarTypeEnum?
    let isActive: Bool?
    let powerOutput: SocarPowerOutput?
    let status: SocarConnectorStatus?
    let updatedAt: String?
    let lastMeterValue: [SocarJSONAny]?
    let nanoID: String?
    let format: SocarFormat?
    let pricePerUnit: Double?
    let maxVoltage, maxAmperage, capacity: Int?
    let isHourlyMode, isLocked, isUnitMode, isAmountMode: Bool?
    let isSocMode, charge2_Full, wasFinishing: Bool?
    let activeTariffs: [SocarJSONAny]?
    let touActiveTariffs: [SocarTouActiveTariff]?
    let reserved: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case oemConnectorNumber = "oem_connector_number"
        case connectorType = "connector_type"
        case maxUnitPerHour = "max_unit_per_hour"
        case type
        case isActive = "is_active"
        case powerOutput = "power_output"
        case status
        case updatedAt = "updated_at"
        case lastMeterValue = "last_meter_value"
        case nanoID = "nano_id"
        case format
        case pricePerUnit = "price_per_unit"
        case maxVoltage = "max_voltage"
        case maxAmperage = "max_amperage"
        case capacity
        case isHourlyMode = "is_hourly_mode"
        case isLocked = "is_locked"
        case isUnitMode = "is_unit_mode"
        case isAmountMode = "is_amount_mode"
        case isSocMode = "is_soc_mode"
        case charge2_Full = "charge_2_full"
        case wasFinishing = "was_finishing"
        case activeTariffs = "active_tariffs"
        case touActiveTariffs = "tou_active_tariffs"
        case reserved
    }
}

// MARK: - ConnectorType
struct SocarConnectorType: Codable {
    let id: String?
    let alias: SocarAlias?
    let client, connectorType: String?
    let createdAt: SocarCreatedAt?
    let updatedAt: SocarUpdatedAt?
    let image: String?
    let name: SocarAlias?
    let powerOutput: SocarPowerOutput?
    let archive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, alias, client
        case connectorType = "connector_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image, name
        case powerOutput = "power_output"
        case archive
    }
}

enum SocarAlias: String, Codable {
    case ccs2 = "CCS 2"
    case gbT = "GB/T"
    case gbTFast = "GB/T (Fast)"
    case type2 = "TYPE 2"
}

enum SocarCreatedAt: String, Codable {
    case the20231120T030611680209Z = "2023-11-20T03:06:11.680209Z"
    case the20231120T030611755836Z = "2023-11-20T03:06:11.755836Z"
    case the20231120T030611834592Z = "2023-11-20T03:06:11.834592Z"
    case the20231120T030611874871Z = "2023-11-20T03:06:11.874871Z"
}

enum SocarPowerOutput: String, Codable {
    case ac = "AC"
    case dc = "DC"
}

enum SocarUpdatedAt: String, Codable {
    case the20231120T030611680231Z = "2023-11-20T03:06:11.680231Z"
    case the20231120T030611755856Z = "2023-11-20T03:06:11.755856Z"
    case the20231120T030611834616Z = "2023-11-20T03:06:11.834616Z"
    case the20231120T030611874894Z = "2023-11-20T03:06:11.874894Z"
}

enum SocarFormat: String, Codable {
    case cable = "CABLE"
}

enum SocarName: String, Codable {
    case connector1 = "Connector 1"
    case connector2 = "Connector 2"
}

enum SocarConnectorStatus: String, Codable {
    case available = "AVAILABLE"
    case charging = "CHARGING"
    case unavailable = "UNAVAILABLE"
}

// MARK: - TouActiveTariff
struct SocarTouActiveTariff: Codable {
    let priceComponent: [SocarPriceComponent]?
    let element, tariff: String?

    enum CodingKeys: String, CodingKey {
        case priceComponent = "price_component"
        case element, tariff
    }
}

// MARK: - PriceComponent
struct SocarPriceComponent: Codable {
    let rate: Double?
    let vat, stepSize: Int?
    let type, label: SocarLabel?

    enum CodingKeys: String, CodingKey {
        case rate, vat
        case stepSize = "step_size"
        case type, label
    }
}

enum SocarLabel: String, Codable {
    case energy = "ENERGY"
    case the030 = "0.30"
}

enum SocarTypeEnum: String, Codable {
    case ccs2 = "CCS2"
    case gbT = "GB/T"
    case type2 = "TYPE_2"
}

enum SocarFirmwareUpdatedAt: String, Codable {
    case none = "None"
    case the202501280739502151230000 = "2025-01-28 07:39:50.215123+00:00"
}

enum SocarFirmwareVersion: String, Codable {
    case v10106 = "V1.01.06"
    case v10205 = "V1.02.05"
    case v6418 = "V6.4.18"
}

enum SocarChargerStatus: String, Codable {
    case offline = "OFFLINE"
    case online = "ONLINE"
}

enum SocarCountry: String, Codable {
    case azerbaijan = "Azerbaijan"
    case azərbaycan = "Azərbaycan"
    case empty = ""
}

// MARK: - OpeningTimes
struct SocarOpeningTimes: Codable {
    let regularHours: [SocarRegularHour]?
    let twentyfourseven: Bool?
    let exceptionalClosings: [SocarExceptionalClosing]?

    enum CodingKeys: String, CodingKey {
        case regularHours = "regular_hours"
        case twentyfourseven
        case exceptionalClosings = "exceptional_closings"
    }
}

// MARK: - ExceptionalClosing
struct SocarExceptionalClosing: Codable {
    let periodEnd, periodBegin: SocarJSONNull?

    enum CodingKeys: String, CodingKey {
        case periodEnd = "period_end"
        case periodBegin = "period_begin"
    }
}

// MARK: - RegularHour
struct SocarRegularHour: Codable {
    let weekDay: Int?
    let periodEnd: SocarPeriodEnd?
    let periodBegin: SocarPeriodBegin?

    enum CodingKeys: String, CodingKey {
        case weekDay
        case periodEnd = "period_end"
        case periodBegin = "period_begin"
    }
}

enum SocarPeriodBegin: String, Codable {
    case the0000 = "00:00"
}

enum SocarPeriodEnd: String, Codable {
    case the2359 = "23:59"
}

enum SocarState: String, Codable {
    case empty = ""
    case narimanov = "Narimanov"
    case sabuncu = "Sabuncu"
}

// MARK: - Encode/decode helpers

class SocarJSONNull: Codable, Hashable {

    public static func == (lhs: SocarJSONNull, rhs: SocarJSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(SocarJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class SocarJSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class SocarJSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(SocarJSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return SocarJSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return SocarJSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: SocarJSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<SocarJSONCodingKey>, forKey key: SocarJSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return SocarJSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: SocarJSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<SocarJSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is SocarJSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                        var container: any SingleValueEncodingContainer = container.nestedContainer(keyedBy: SocarJSONCodingKey.self) as! SingleValueEncodingContainer
                        try encode(to: &container, value: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<SocarJSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = SocarJSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is SocarJSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: SocarJSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is SocarJSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try SocarJSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: SocarJSONCodingKey.self) {
                    self.value = try SocarJSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try SocarJSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try SocarJSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: SocarJSONCodingKey.self)
                    try SocarJSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try SocarJSONAny.encode(to: &container, value: self.value)
            }
    }
}
