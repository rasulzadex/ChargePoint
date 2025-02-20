//
//  VoltUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
protocol VoltUseCase {
    func getVoltStations(completion: @escaping(VoltDTO?, String?) -> Void)
}
