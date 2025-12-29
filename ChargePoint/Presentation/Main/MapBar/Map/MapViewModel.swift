//
//  MapViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 17.02.25.
//

import Foundation

enum MapViewState: BaseViewStateProtocol {
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

final class MapViewModel: BaseViewModel<MapViewState> {
    
    private let useCase: AllStationsUseCase
    
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
        setState(state: .loading)
        useCase.getTouchStations { [weak self] dto, error in
            guard let self else {return}
            setState(state: .loaded)
            if let dto = dto {
                touchStations = dto.data
                setState(state: .successTouch)
            } else if let error = error {
                print(error)
                setState(state: .error("Touch stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getSocarPoints() {
        print(#function)
        setState(state: .loading)
        useCase.getSocarStations { [weak self] dto, error in
            guard let self else {return}
            setState(state: .loaded)
    
            if let dto = dto {
                socarStations = dto.results ?? []
                setState(state: .successSocar)
            } else if let error = error {
                setState(state: .error("Socar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getEnrgPoints() {
        setState(state: .loading)
        useCase.getEnrgStations { [weak self] dtoArray, error in
            guard let self else {return}
            setState(state: .loaded)
            if let dtoArray = dtoArray {
                enrgStations = dtoArray
                setState(state: .successEnrg)
            }else if let error = error {
                setState(state: .error("Enrg stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getGofarPoints() {
        setState(state: .loading)
        useCase.getGofarStations { [weak self] dto, error in
            guard let self else {return}
            setState(state: .loaded)
            if let dto = dto {
                gofarStations = dto.locations
                setState(state: .successGofar)
            } else if let error = error {
                setState(state: .error("Gofar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getVoltPoints() {
        setState(state: .loading)
        useCase.getVoltStations { [weak self] dto, error in
            guard let self else {return}
            setState(state: .loaded)
            if let dto = dto {
                voltStations = Array(dto.result.values)
                setState(state: .successVolt)
            } else if let error = error {
                setState(state: .error("Volt stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getChargePoints() {
        setState(state: .loading)
        getChargeToken { [weak self] in
            guard let self else { return }
            useCase.getChargeStations(token: chargeTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
                guard let self else {return}
                setState(state: .loaded)
                if let dto = dto {
                    chargeStations = dto.objects
                    setState(state: .successCharge)
                } else if let error = error {
                    setState(state: .error("Charge.az stansiyalarını göstərmək mümkün olmadı", error))
                }
            }
        }
    }
    func getTokPoints() {
        setState(state: .loading)
        getTokToken { [weak self] in
            guard let self else { return }
            useCase.getTokStations(token: tokTokenDTO?.accessToken ?? "no access") { [weak self] dto, error in
                guard let self else {return}
                setState(state: .loaded)
                if let dto = dto {
                    tokStations = dto.objects
                    setState(state: .successTok)
                } else if let error = error {
                    setState(state: .error("Tok.az stansiyalarını göstərmək mümkün olmadı", error))
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
                setState(state: .error("ChargeAz üçün Tokeni yeniləmək mümkün olmadı", error))
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
                setState(state: .error("Tok.az üçün Tokeni yeniləmək mümkün olmadı", error))
            }
        }
    }
        
    }

