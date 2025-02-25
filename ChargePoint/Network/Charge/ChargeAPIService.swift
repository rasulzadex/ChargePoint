//
//  ChargeAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class ChargeAPIService: ChargeUseCase {
    func getChargeStations(token: String, completion: @escaping (ChargeDTO?, String?) -> Void) {
        apiService.request(
            type: ChargeDTO.self,
            url: ChargeAPIHelper.charge.endPoint,
            method: .GET,
            header: ChargeAPIHelper.charge.makeHeader(token: token)) { [weak self] result in
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
