//
//  ChargeTokenService.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class ChargeTokenService: ChargeTokenUseCase {
    func getChargeRefreshToken(completion: @escaping (ChargeToken?, String?) -> Void) {
        apiService.request(
            type: ChargeToken.self,
            url: ChargeTokenHelper.chargeToken.endPoint,
            method: .POST,
            header: ChargeTokenHelper.chargeToken.makeHeader(),
            body: ChargeTokenHelper.chargeToken.makeBody().data(using: .utf8)) { [weak self] result in
                guard let self else {return}
                switch result {
                case .success(let success):
                    completion(success, nil)
                case .failure(let failure):
                    completion(nil, failure.localizedDescription)

                }
            }
    }
}
