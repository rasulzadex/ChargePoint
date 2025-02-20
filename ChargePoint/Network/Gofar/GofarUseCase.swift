//
//  GofarUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
protocol GofarUseCase {
    func getGofarStations(completion: @escaping(GofarDTO?, String?) -> Void)
}
