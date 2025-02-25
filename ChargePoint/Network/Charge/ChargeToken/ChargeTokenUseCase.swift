//
//  ChargeTokenUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
protocol ChargeTokenUseCase {
    func getChargeRefreshToken(completion: @escaping(ChargeToken?, String?) -> Void)
}
