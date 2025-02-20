//
//  VoltAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class VoltAPIService: VoltUseCase {
    func getVoltStations(completion: @escaping (VoltDTO?, String?) -> Void) {
        apiService.request(
            type: VoltDTO.self,
            url: VoltAPIHelper.volt.endPoint,
            method: .GET,
            header: VoltAPIHelper.volt.makeHeader()) { [weak self] result in
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
