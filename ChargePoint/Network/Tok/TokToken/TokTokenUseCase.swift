//
//  TokTokenCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol TokTokenRepository {
    func getTokToken(completion: @escaping(TokToken?, String?) -> Void)
}
