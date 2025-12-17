//
//  AppDIContainer.swift
//  ChargePoint
//
//  Created by Javidan on 17.12.25.
//

final class AppDIContainer {
    
    func makeMapDIContainer() -> MapDIContainer {
        MapDIContainer(dependencies: .init(apiService: .sharedApiService))
    }
}
