//
//  TouchAzDTO.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//
import Foundation

// MARK: - TouchAzDTO
struct TouchAzDTO: Codable {
    let status: String
    let data: [TouchData]
}

// MARK: - TouchData
struct TouchData: Codable {
    let nnChargeStation: Int
    let globalID, formattedAddress, name, latitude: String
    let longitude: String
    let chargePoint: [TouchPoint]

    enum CodingKeys: String, CodingKey {
        case nnChargeStation
        case globalID = "GlobalID"
        case formattedAddress = "FormattedAddress"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case chargePoint = "ChargePoint"
    }
}

// MARK: - ChargePoint
struct TouchPoint: Codable {
    let status: TouchStatus
    let localStatus: TouchStatus?
    let socket: [TouchSocket]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case localStatus = "LocalStatus"
        case socket = "Socket"
    }
}

// MARK: - Status
struct TouchStatus: Codable {
    let nnStatus, statusKey: Int
    let name: TouchName
    let engName: TouchEngName
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case nnStatus
        case statusKey = "StatusKey"
        case name = "Name"
        case engName = "EngName"
        case isLocal
    }
}

enum TouchEngName: String, Codable {
    case available = "Available"
    case faulted = "Faulted"
    case unavailable = "Unavailable"
    case works = "Works"
}

enum TouchName: String, Codable {
    case доступна = "Доступна"
    case недоступна = "Недоступна"
    case ошибка = "Ошибка"
    case работает = "Работает"
}

// MARK: - Socket
struct TouchSocket: Codable {
    let nnStatus: Int
    let connectorType: TouchConnectorType

    enum CodingKeys: String, CodingKey {
        case nnStatus
        case connectorType = "ConnectorType"
    }
}

// MARK: - ConnectorType
struct TouchConnectorType: Codable {
    let files: TouchFiles

    enum CodingKeys: String, CodingKey {
        case files = "Files"
    }
}

// MARK: - Files
struct TouchFiles: Codable {
    let filePath: TouchFilePath

    enum CodingKeys: String, CodingKey {
        case filePath = "FilePath"
    }
}

enum TouchFilePath: String, Codable {
    case iconsConnectorTypesCcs2PNG = "/icons/connectorTypes/ccs-2.png"
    case iconsConnectorTypesGbtACPNG = "/icons/connectorTypes/gbt-ac.png"
    case iconsConnectorTypesGbtDcPNG = "/icons/connectorTypes/gbt-dc.png"
    case iconsConnectorTypesType2PNG = "/icons/connectorTypes/type-2.png"
}

extension TouchData {
    func switchDTOtoModel() -> DetailModel {
        let safeLatitude = Double(latitude) ?? 0.0
        let safeLongitude = Double(longitude) ?? 0.0

        // Bütün `ChargePoint` içindəki `Socket`-ləri toplayırıq
        let allSockets = chargePoint.compactMap { $0.socket }.flatMap { $0 }

        // Əgər heç bir `Socket` yoxdursa, default dəyər qaytarırıq
        guard !allSockets.isEmpty else {
            return DetailModel(
                name: name,
                address: formattedAddress,
                latitude: safeLatitude,
                longitude: safeLongitude,
                charger: "No connectors",
                status: "No status"
            )
        }

        // Bütün `Socket` növlərini (`ConnectorType`) və `Status` adlarını toplayırıq
        let chargerNames = allSockets.compactMap { $0.connectorType.files.filePath.rawValue }
        let statuses = chargePoint.compactMap { $0.status.engName.rawValue }

        // Əgər array boşdursa, default dəyər veririk
        let safeCharger = chargerNames.isEmpty ? "Unknown" : chargerNames.joined(separator: ", ")
        let safeStatus = statuses.isEmpty ? "Unknown" : statuses.joined(separator: ", ")

        return DetailModel(
            name: name,
            address: formattedAddress,
            latitude: safeLatitude,
            longitude: safeLongitude,
            charger: safeCharger,
            status: safeStatus
        )
    }
}
