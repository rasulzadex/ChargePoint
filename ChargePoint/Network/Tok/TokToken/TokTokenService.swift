//
//  TokTokenService.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class TokTokenService: TokTokenUseCase {
    func getTokToken(completion: @escaping (TokToken?, String?) -> Void) {
        apiService.request(
            type: TokToken.self,
            url: TokTokenHelper.tokToken.endPoint,
            method: .POST,
            header: TokTokenHelper.tokToken.makeHeader(),
            body: TokTokenHelper.tokToken.makeBody().data(using: .utf8)) { [weak self] result in
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
