//
//  SocarAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class SocarAPIService: SocarUseCase {
    func getSocarStations(completion: @escaping (SocarDTO?, String?) -> Void) {
        apiService.request(
            type: SocarDTO.self,
            url: SocarAPIHelper.socar.endPoint,
            method: .GET,
            header: SocarAPIHelper.socar.makeHeader()) { [weak self] result in
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
