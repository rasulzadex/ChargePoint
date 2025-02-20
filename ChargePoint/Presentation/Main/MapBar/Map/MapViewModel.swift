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
        case error(String,String)
    }
    
    var callback: ((ViewState)->Void)?
    private let socarUseCase: SocarUseCase
    private let touchUseCase: TouchUseCase
    private let gofarUseCase: GofarUseCase
    private let voltUseCase: VoltUseCase
    private let enrgUseCase: EnrgUseCase
    
    private (set) var touchDTO: TouchAzDTO?
    private (set) var socarDTO: SocarDTO?
    private (set) var gofarDTO: GofarDTO?
    private (set) var voltDTO: VoltDTO?
    private (set) var enrgDTO: EnrgDTO?

    var touchStations: [TouchData] = []
    var socarStations: [SocarResult] = []
    var voltStations: [VoltResult] = []
    var gofarStations: [GofarLocation] = []
//    var enrgStations: [EnrgLocation] = []

    private weak var navigation: MapNavigation?
    
    init(navigation: MapNavigation) {
        self.navigation = navigation
        self.touchUseCase = TouchAPIService()
        self.socarUseCase = SocarAPIService()
        self.gofarUseCase = GofarAPIService()
        self.voltUseCase = VoltAPIService()
        self.enrgUseCase = EnrgAPIService()
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
        print(#function)
        callback?(.loading)
        enrgUseCase.getEnrgStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                enrgDTO = dto
                print(dto)
                callback?(.successEnrg)
            } else if let error = error {
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
                print(dto)
                callback?(.successGofar)
            } else if let error = error {
                gofarDTO = dto
                callback?(.error("Gofar stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    func getVoltPoints() {
        print(#function)
        callback?(.loading)
        voltUseCase.getVoltStations { [weak self] dto, error in
            guard let self else {return}
            callback?(.loaded)
            if let dto = dto {
                voltDTO = dto
                voltStations = Array(dto.result.values)
                print(voltStations)
                callback?(.successVolt)
            } else if let error = error {
                callback?(.error("Volt stansiyalarını göstərmək mümkün olmadı", error))
            }
        }
    }
    
}
