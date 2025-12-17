//
//  ChargeTokenUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol ChargeTokenRepository {
    func getChargeRefreshToken(completion: @escaping(ChargeToken?, String?) -> Void)
}
