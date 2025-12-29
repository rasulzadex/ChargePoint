//
//  ProfileViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 20.12.25.
//

import Foundation

final class ProfileViewModel: BaseViewModel<BaseViewState> {
    
    private weak var router: ProfileCoordinatorRouter?
    
    init(
        router: ProfileCoordinatorRouter
    ) {
        self.router = router
    }
}
