//
//  TouchAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 18.02.25.
//

import Foundation

private let apiService = CoreAPIManager.instance
final class TouchAPIService: TouchUseCase {
    func getTouchStations(completion: @escaping (TouchAzDTO?, String?) -> Void) {
        apiService.request(
            type: TouchAzDTO.self,
            url: TouchAPIHelper.touch.endPoint,
            method: .POST,
            header: TouchAPIHelper.touch.makeHeader()) { [weak self] result in
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
