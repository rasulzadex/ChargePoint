//
//  DetailModel.swift
//  ChargePoint
//
//  Created by Javidan on 24.02.25.
//

import Foundation

struct DetailModel {
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let charger: String
    let status: String

    // **Connector-ləri array kimi saxlamaq**
    var connectors: [String] {
        return charger.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }

    // **Status-ları array kimi saxlamaq**
    var statuses: [String] {
        return status.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }
}
