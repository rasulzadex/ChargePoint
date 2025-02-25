//
//  MapViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import Foundation

final class MapViewModel {
    enum ViewState {
        case loading
        case loaded
        case success
        case successSocar
        case successTouch
        case successGofar
        case successVolt
        case successEnrg
        case successCharge
        case successTok
        case error(String,String)
    }
    var callback: ((ViewState)->Void)?
    
    private let socarUseCase: SocarUseCase
    private let touchUseCase: TouchUseCase
    private let gofarUseCase: GofarUseCase
    private let voltUseCase: VoltUseCase
    private let enrgUseCase: EnrgUseCase
    private let chargeUseCase: ChargeUseCase
    private let tokUseCase: TokUseCase
    
    private (set) var touchDTO: TouchAzDTO?
    private (set) var socarDTO: SocarDTO?
    private (set) var gofarDTO: GofarDTO?
    private (set) var voltDTO: VoltDTO?
    private (set) var enrgDTO: [EnrgDTO]?
    private (set) var chargeDTO: ChargeDTO?
    private (set) var tokDTO: TokDTO?

    
    private (set) var chargeTokenDTO: ChargeToken?
    private (set) var tokTokenDTO: TokToken?
    private let chargeTokenUseCase: ChargeTokenUseCase
    private let tokTokenUseCase: TokTokenUseCase

    var touchStations: [TouchData] = []
    var socarStations: [SocarResult] = []
    var voltStations: [VoltResult] = []
    var gofarStations: [GofarLocation] = []
    var enrgStations: [EnrgLocation] = []
    var chargeStations: [ChargeResult] = []
    var tokStations: [TokResult] = []

    private weak var navigation: MapNavigation?
    
    init(navigation: MapNavigation) {
        self.navigation = navigation
        self.touchUseCase = TouchAPIService()
        self.socarUseCase = SocarAPIService()
        self.gofarUseCase = GofarAPIService()
        self.voltUseCase = VoltAPIService()
        self.enrgUseCase = EnrgAPIService()
        self.chargeUseCase = ChargeAPIService()
        self.tokTokenUseCase = TokTokenService()
        self.chargeTokenUseCase = ChargeTokenService()
        self.tokUseCase = TokAPIService()
    }

    
    func goDetail(){
        navigation?.goDetail()
    }
    
    func getTouchPoints() {
        print(#function)
        callback?(.loading)
        touchUseCase.getTouchStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                touchDTO = dto
                touchStations = dto.data
                callback?(.successTouch)
            } else if let error = error {
                print(error)
                callback?(.error("Touch stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getSocarPoints() {
        print(#function)
        callback?(.loading)
        socarUseCase.getSocarStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                socarDTO = dto
                socarStations = dto.results
                callback?(.successSocar)
            } else if let error = error {
                callback?(.error("Socar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getEnrgPoints() {
        callback?(.loading)
        enrgUseCase.getEnrgStations { [weak self] dtoArray, error in
            guard let self else {return}
            callback?(.loaded)
            if let dtoArray = dtoArray {
                enrgDTO = dtoArray
                enrgStations = dtoArray.map { $0.location }
                callback?(.successEnrg)
            }else if let error = error {
                callback?(.error("Enrg stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getGofarPoints() {
        callback?(.loading)
        gofarUseCase.getGofarStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                gofarDTO = dto
                gofarStations = dto.locations
                callback?(.successGofar)
            } else if let error = error {
                gofarDTO = dto
                callback?(.error("Gofar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getVoltPoints() {
        callback?(.loading)
        voltUseCase.getVoltStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                voltDTO = dto
                voltStations = Array(dto.result.values)
                callback?(.successVolt)
            } else if let error = error {
                callback?(.error("Volt stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getChargePoints() {
        callback?(.loading)
        getChargeToken { [weak self] in
            guard let self else { return }
            chargeUseCase.getChargeStations(token: chargeTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
                guard let self else {return}
                callback?(.loaded)
                if let dto = dto {
                    chargeDTO = dto
                    chargeStations = dto.objects
                    callback?(.successCharge)
                } else if let error = error {
                    callback?(.error("Charge.az stansiyalarını göstərmək mümkün olmadı", error))
                }
            }
        }
    }
    func getTokPoints() {
        callback?(.loading)
        getTokToken { [weak self] in
            guard let self else { return }
            tokUseCase.getTokStations(token: tokTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
                guard let self else {return}
                callback?(.loaded)
                if let dto = dto {
                    tokDTO = dto
                    tokStations = dto.objects
                    callback?(.successTok)
                } else if let error = error {
                    callback?(.error("Tok.az stansiyalarını göstərmək mümkün olmadı", error))
                }
            }
        }
    }
    
    func getChargeToken(completion: @escaping () -> Void) {
        chargeTokenUseCase.getChargeRefreshToken { [weak self] dto, error in
            guard let self else {return}
            if let dto = dto {
                chargeTokenDTO = dto
                completion()
            } else if let error = error {
                callback?(.error("ChargeAz üçün Tokeni yeniləmək mümkün olmadı", error))
            }
        }
    }

    func getTokToken(completion: @escaping () -> Void) {
        tokTokenUseCase.getTokToken { [weak self] dto, error in
            guard let self else {return}
            if let dto = dto {
                tokTokenDTO = dto
                completion()
            } else if let error = error {
                callback?(.error("Tok.az üçün Tokeni yeniləmək mümkün olmadı", error))
            }
        }
    }
        
    }

