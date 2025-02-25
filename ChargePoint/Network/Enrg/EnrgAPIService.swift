//
//  EnrgAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class EnrgAPIService: EnrgUseCase {
    func getEnrgStations(completion: @escaping ([EnrgDTO]?, String?) -> Void) {
        apiService.request(
            type: [EnrgDTO].self,
            url: EnrgAPIHelper.enrg.endPoint,
            method: .GET,
            header: EnrgAPIHelper.enrg.makeHeader()) { [weak self] result in
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
