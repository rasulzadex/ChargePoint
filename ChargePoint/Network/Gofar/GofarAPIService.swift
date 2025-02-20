//
//  GofarAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
private let apiService = CoreAPIManager.instance
final class GofarAPIService: GofarUseCase {
    func getGofarStations(completion: @escaping (GofarDTO?, String?) -> Void) {
        apiService.request(
            type: GofarDTO.self,
            url: GofarAPIHelper.gofar.endPoint,
            method: .POST,
            header: GofarAPIHelper.gofar.makeHeader(),
            body: GofarAPIHelper.gofar.makeBody()) { [weak self] result in
             
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
