//
//  TokAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class TokAPIService: TokUseCase {
    func getTokStations(token: String, completion: @escaping (TokDTO?, String?) -> Void) {
        apiService.request(
            type: TokDTO.self,
            url: TokAPIHelper.tok.endPoint,
            method: .GET,
            header: TokAPIHelper.tok.makeHeader(token: token)) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let success):
                    completion(success, nil)
                case .failure(let failure):
                    completion(nil, failure.localizedDescription)

                }
            }
    }
}
