//
//  AllStationsUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 17.12.25.
//
import Foundation

protocol AllStationsUseCase {
    func getSocarStations(completion: @escaping(SocarDTO?, String?) -> Void)
    func getVoltStations(completion: @escaping(VoltDTO?, String?) -> Void)
    func getChargeStations(token:String,completion: @escaping(ChargeDTO?, String?) -> Void)
    func getEnrgStations(completion: @escaping([EnrgDTO]?, String?) -> Void)
    func getTouchStations(completion: @escaping(TouchAzDTO?, String?) -> Void)
    func getGofarStations(completion: @escaping(GofarDTO?, String?) -> Void)
    func getTokStations(token:String, completion: @escaping(TokDTO?, String?) -> Void)
    func getTokToken(completion: @escaping(TokToken?, String?) -> Void)
    func getChargeRefreshToken(completion: @escaping(ChargeToken?, String?) -> Void)
}

public final class AllStationsUseCaseImplementation {
    
    private let voltRepository: VoltRepository
    private let chargeRepository: ChargeRepository
    private let enrgRepository: EnrgRepository
    private let socarRepository: SocarRepository
    private let touchRepository: TouchRepository
    private let gofarRepository: GofarRepository
    private let tokRepository: TokRepository
    private let tokTokenRepository: TokTokenRepository
    private let chargeTokenRepository: ChargeTokenRepository

    
    init() {
        self.voltRepository = VoltAPIService(apiService: .sharedApiService)
        self.chargeRepository = ChargeAPIService(apiService: .sharedApiService)
        self.enrgRepository = EnrgAPIService(apiService: .sharedApiService)
        self.touchRepository = TouchAPIService(apiService: .sharedApiService)
        self.gofarRepository = GofarAPIService(apiService: .sharedApiService)
        self.tokRepository = TokAPIService(apiService: .sharedApiService)
        self.socarRepository = SocarAPIService(apiService: .sharedApiService)
        self.tokTokenRepository = TokTokenService(apiService: .sharedApiService)
        self.chargeTokenRepository = ChargeTokenService(apiService: .sharedApiService)
    }
}

extension AllStationsUseCaseImplementation: AllStationsUseCase {
    
    func getSocarStations(completion: @escaping (SocarDTO?, String?) -> Void) {
        socarRepository.getSocarStations(completion: completion)
    }
    
    func getVoltStations(completion: @escaping (VoltDTO?, String?) -> Void) {
        voltRepository.getVoltStations(completion: completion)
    }
    
    func getChargeStations(token: String, completion: @escaping (ChargeDTO?, String?) -> Void) {
        chargeRepository.getChargeStations(token: token, completion: completion)
    }
    
    func getEnrgStations(completion: @escaping ([EnrgDTO]?, String?) -> Void) {
        enrgRepository.getEnrgStations(completion: completion)
    }
    
    func getTouchStations(completion: @escaping (TouchAzDTO?, String?) -> Void) {
        touchRepository.getTouchStations(completion: completion)
    }
    
    func getGofarStations(completion: @escaping (GofarDTO?, String?) -> Void) {
        gofarRepository.getGofarStations(completion: completion)
    }
    
    func getTokStations(token: String, completion: @escaping (TokDTO?, String?) -> Void) {
        tokRepository.getTokStations(token: token, completion: completion)
    }
    
    func getTokToken(completion: @escaping (TokToken?, String?) -> Void) {
        tokTokenRepository.getTokToken(completion: completion)
    }
    
    func getChargeRefreshToken(completion: @escaping (ChargeToken?, String?) -> Void) {
        chargeTokenRepository.getChargeRefreshToken(completion: completion)
    }
}
