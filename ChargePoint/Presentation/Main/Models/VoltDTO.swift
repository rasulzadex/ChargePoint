//
//  VoltDTO.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
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
    let openHours: String
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
    let maxPower: Int
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
    let price: Double?
    let gracePeriod: Int?
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
