//
//  EnrgUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
protocol EnrgUseCase {
    func getEnrgStations(completion: @escaping([EnrgDTO]?, String?) -> Void)
}
