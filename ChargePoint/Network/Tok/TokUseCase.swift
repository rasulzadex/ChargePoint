//
//  TokUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol TokRepository {
    func getTokStations(token:String, completion: @escaping(TokDTO?, String?) -> Void)
}
