//
//  MapDIContainer.swift
//  ChargePoint
//
//  Created by Javidan on 17.12.25.
//

import Foundation

final class MapDIContainer {
    
    //MARK: - Dependencies Struct
    struct Dependencies {
        let apiService: CoreApiService
    }
    
    private let dependencies: Dependencies
    
    init(
        dependencies: Dependencies
    ) {
        self.dependencies = dependencies
    }
}

extension MapDIContainer {
    
    //MARK: - UseCase functions
    func makeAllStationsUseCase() -> AllStationsUseCase {
        return AllStationsUseCaseImplementation(
            voltRepository: makeVoltRepository(),
            chargeRepository: makeChargeRepository(),
            enrgRepository: makeEnrgRepository(),
            socarRepository: makeSocarRepository(),
            touchRepository: makeTouchRepoistory(),
            gofarRepository: makeGofarRepository(),
            tokRepository: makeTokRepository(),
            tokTokenRepository: makeTokTokenRepository(),
            chargeTokenRepository: makeChargeTokenRepository()
        )
    }
    
    
    //MARK: - Repository Functions
    private func makeVoltRepository() -> VoltRepository {
        VoltAPIService(apiService: dependencies.apiService)
    }
    
    private func makeChargeRepository() -> ChargeRepository {
        ChargeAPIService(apiService: dependencies.apiService)
    }
    
    private func makeEnrgRepository() -> EnrgRepository {
        EnrgAPIService(apiService: dependencies.apiService)
    }
    
    private func makeSocarRepository() -> SocarRepository {
        SocarAPIService(apiService: dependencies.apiService)
    }
    
    private func makeTouchRepoistory() -> TouchRepository {
        TouchAPIService(apiService: dependencies.apiService)
    }
    
    private func makeGofarRepository() -> GofarRepository {
        GofarAPIService(apiService: dependencies.apiService)
    }
    
    private func makeTokRepository() -> TokRepository {
        TokAPIService(apiService: dependencies.apiService)
    }
    
    private func makeTokTokenRepository() -> TokTokenRepository {
        TokTokenService(apiService: dependencies.apiService)
    }
    
    private func makeChargeTokenRepository() -> ChargeTokenRepository {
        ChargeTokenService(apiService: dependencies.apiService)
    }
}
