//
//  GofarUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
protocol GofarRepository {
    func getGofarStations(completion: @escaping(GofarDTO?, String?) -> Void)
}
