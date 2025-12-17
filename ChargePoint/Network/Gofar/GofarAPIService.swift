//
//  GofarAPIService.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation

final class GofarAPIService: GofarRepository {
    
    private let apiService: CoreApiService
    
    init(
        apiService: CoreApiService
    ) {
        self.apiService = apiService
    }
    
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
