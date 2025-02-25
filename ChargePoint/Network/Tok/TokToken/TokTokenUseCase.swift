//
//  TokTokenCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol TokTokenUseCase {
    func getTokToken(completion: @escaping(TokToken?, String?) -> Void)
}
