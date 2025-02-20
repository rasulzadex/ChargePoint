//
//  SocarUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//

import Foundation
protocol SocarUseCase {
    func getSocarStations(completion: @escaping(SocarDTO?, String?) -> Void)
}
