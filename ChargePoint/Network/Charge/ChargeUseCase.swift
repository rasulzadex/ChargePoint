//
//  ChargeUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol ChargeUseCase {
    func getChargeStations(token:String,completion: @escaping(ChargeDTO?, String?) -> Void)
}
