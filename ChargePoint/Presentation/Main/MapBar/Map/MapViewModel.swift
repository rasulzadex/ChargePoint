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
    
    private let useCase: AllStationsUseCase
    
    private(set) var touchDTO: TouchAzDTO?
    private(set) var socarDTO: SocarDTO?
    private(set) var gofarDTO: GofarDTO?
    private(set) var voltDTO: VoltDTO?
    private(set) var enrgDTO: [EnrgDTO]?
    private(set) var chargeDTO: ChargeDTO?
    private(set) var tokDTO: TokDTO?

    private(set) var chargeTokenDTO: ChargeToken?
    private(set) var tokTokenDTO: TokToken?

    var touchStations: [TouchData] = []
    var socarStations: [SocarResult] = []
    var voltStations: [VoltResult] = []
    var gofarStations: [GofarLocation] = []
    var enrgStations: [EnrgDTO] = []
    var chargeStations: [ChargeResult] = []
    var tokStations: [TokResult] = []

    private weak var navigation: MapNavigation?
    
    init(
        navigation: MapNavigation,
        useCase: AllStationsUseCase
    ) {
        self.navigation = navigation
        self.useCase = useCase
    }

    func goToDetail(with model: DetailModel) {
        navigation?.goToDetail(with: model)
    }

    
    func getTouchPoints() {
        print(#function)
        callback?(.loading)
        useCase.getTouchStations { [weak self] dto, error in
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
        useCase.getSocarStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
    
            if let dto = dto {
                socarDTO = dto
                socarStations = dto.results ?? []
                callback?(.successSocar)
            } else if let error = error {
                callback?(.error("Socar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getEnrgPoints() {
        callback?(.loading)
        useCase.getEnrgStations { [weak self] dtoArray, error in
            guard let self else {return}
            callback?(.loaded)
            if let dtoArray = dtoArray {
                enrgDTO = dtoArray
                enrgStations = dtoArray
                callback?(.successEnrg)
            }else if let error = error {
                callback?(.error("Enrg stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getGofarPoints() {
        callback?(.loading)
        useCase.getGofarStations { [weak self] dto, error in
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
        useCase.getVoltStations { [weak self] dto, error in
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
            useCase.getChargeStations(token: chargeTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
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
            useCase.getTokStations(token: tokTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
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
        useCase.getChargeRefreshToken { [weak self] dto, error in
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
        useCase.getTokToken { [weak self] dto, error in
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

