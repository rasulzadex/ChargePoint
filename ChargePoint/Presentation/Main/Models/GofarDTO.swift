//
//  GofarDTO.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation

// MARK: - GofarDTO
struct GofarDTO: Codable {
    let locations: [GofarLocation]
    let currencies: [GofarCurrency]
    let tariffs: [GofarTariff]
}

// MARK: - Location
struct GofarLocation: Codable {
    let id: Int
    let name: String
    let address: String
    let description: String?
    let detailedDescription: String?
    let additionalDescription: String?
    let location: String
    let what3WordsAddress: String?
    let zones: [GofarZone]
    let updatedAt: String
    let workingHours: [String]?
    let timezone: String
    let locationImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, description, location, zones, updatedAt, workingHours, timezone
        case detailedDescription = "detailed_description"
        case additionalDescription = "additional_description"
        case what3WordsAddress = "what3words_address"
        case locationImage = "location_image"
    }
}

// MARK: - Zone
struct GofarZone: Codable {
    let evses: [GofarEvse]
}

// MARK: - Evse (Charging Station)
struct GofarEvse: Codable {
    let id: String
    let identifier: String
    let emi3Identifier: String?
    let label: String?
    let networkId: String
    let maxPower: Int
    let currentType: String
    let status: String
    let operatedBy: String?
    let managedByOperator: Bool
    let reservationId: String?
    let isAvailable: Bool
    let isTemporarilyUnavailable: Bool
    let isLongTermUnavailable: Bool
    let tariffId: String
    let connectors: [GofarConnector]
    let roamingEvseId: String?
    let midMeterCertificationEndYear: String?
    let qrUrl: String
    let capabilities: String
    let hasParkingBarrier: Bool
    let canReserve: Bool
    let corporateBillingAsDefaultPaymentMethod: String?
    let hasSmartCharging: Bool
    let chargePointModel: String?
    let operatorId: Int
    let socPercent: Int?
    let startedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, identifier, emi3Identifier, label, networkId, maxPower, currentType, status, operatedBy, managedByOperator, reservationId, isAvailable, isTemporarilyUnavailable, isLongTermUnavailable, tariffId, connectors, roamingEvseId, midMeterCertificationEndYear, qrUrl, capabilities, hasParkingBarrier, canReserve, corporateBillingAsDefaultPaymentMethod, hasSmartCharging, chargePointModel, operatorId, socPercent, startedAt
    }
}

// MARK: - Connector
struct GofarConnector: Codable {
    let name: String
    let icon: String
    let format: String
    let status: String
}

// MARK: - Currency
struct GofarCurrency: Codable {
    let id: Int
    let name: String
    let symbol: String
    let sign: String
    let code: String
    let formatter: String
    let unitPriceFormatter: String
    let updatedAt: String
    let minorUnitDecimal: Int
    let hasPrefix: Bool
    let hasSuffix: Bool
    let prefix: String?
    let suffix: String?
}

// MARK: - Tariff
struct GofarTariff: Codable {
    let id: String
    let currencyCode: String
    let description: String?
    let additionalInformation: String?
    let learnMoreUrl: String?
    let isAdHoc: Bool
    let priceForEnergy: Double?
    let priceForEnergyAtNight: Double?
    let priceForEnergyAtDay: Double?
    let priceForEnergyWhenOptimized: Double?
    let priceForDuration: Double?
    let priceForDurationAtNight: Double?
    let priceForDurationAtDay: Double?
    let pricingPeriodInMinutes: Int
    let durationFeeGracePeriod: Double?
    let priceForIdle: Double?
    let priceForIdleAtNight: Double?
    let priceForIdleAtDay: Double?
    let dayTariffStart: String?
    let nightTariffStart: String?
    let connectionFee: Double?
    let connectionFeeGracePeriodMinutes: Double?
    let connectionFeeGracePeriodKwh: Double?
    let minPrice: Double?
    let priceForSession: Double?
    let regularUseMinutes: Double?
    let priceType: String
    let powerLevels: String?
    let idleFeeGracePeriodMinutes: Int
    let optimisedTariffStart: String?
    let optimisedTariffEnd: String?
    let durationFeeFrom: String?
    let durationFeeTo: String?
    let defaultChargeByTime: String?
    let defaultTopUpKwh: String?
    let optimisedLabel: String?
    let offPeakHoursLabel: String?
    let peakHoursLabel: String?
    let referenceRange: String?
    let standardTariffIdleFee: String?
    let standardTariffDurationFee: String?
    let standardTariffFeePerKwh: String?
    let standardTariffDurationLastUnit: String?
    let pricePeriods: String?

    enum CodingKeys: String, CodingKey {
        case id, currencyCode, description, additionalInformation, learnMoreUrl, isAdHoc, priceForEnergy, priceForEnergyAtNight, priceForEnergyAtDay, priceForEnergyWhenOptimized, priceForDuration, priceForDurationAtNight, priceForDurationAtDay, pricingPeriodInMinutes, durationFeeGracePeriod, priceForIdle, priceForIdleAtNight, priceForIdleAtDay, dayTariffStart, nightTariffStart, connectionFee, connectionFeeGracePeriodMinutes, connectionFeeGracePeriodKwh, minPrice, priceForSession, regularUseMinutes, priceType, powerLevels, idleFeeGracePeriodMinutes, optimisedTariffStart, optimisedTariffEnd, durationFeeFrom, durationFeeTo, defaultChargeByTime, defaultTopUpKwh, optimisedLabel, offPeakHoursLabel, peakHoursLabel, referenceRange, standardTariffIdleFee, standardTariffDurationFee, standardTariffFeePerKwh, standardTariffDurationLastUnit, pricePeriods
    }
}
extension GofarLocation {
    func switchDTOtoModel() -> DetailModel? {
        let locationComponents = location.split(separator: ",")

        guard locationComponents.count == 2,
              let latitude = Double(locationComponents[0]),
              let longitude = Double(locationComponents[1]) else {
            return nil
        }

        // Bütün `zones` içindəki `evses`-lərin `connectors`-larını toplayırıq
        let allConnectors = zones.compactMap { $0.evses }
            .flatMap { $0 }
            .compactMap { $0.connectors }
            .flatMap { $0 }

        // Əgər heç bir `connector` yoxdursa, default dəyər qaytarırıq
        guard !allConnectors.isEmpty else {
            return DetailModel(
                name: name,
                address: address,
                latitude: latitude,
                longitude: longitude,
                charger: "No connectors",
                status: "No status"
            )
        }

        // Bütün `connector` adlarını və statuslarını toplayırıq
        let chargerNames = allConnectors.compactMap { $0.name }
        let statuses = allConnectors.compactMap { $0.status }

        // Əgər array boşdursa, default dəyər veririk
        let safeCharger = chargerNames.isEmpty ? "Unknown" : chargerNames.joined(separator: ", ")
        let safeStatus = statuses.isEmpty ? "Unknown" : statuses.joined(separator: ", ")

        return DetailModel(
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            charger: safeCharger,
            status: safeStatus
        )
    }
}
