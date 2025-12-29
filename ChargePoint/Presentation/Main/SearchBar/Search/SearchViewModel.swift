//
//  SearchViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 01.03.25.
//

import Foundation
final class SearchViewModel: BaseViewModel<BaseViewState> {
    
    private weak var navigation: SearchNavigation?
    
    init(navigation: SearchNavigation?) {
        self.navigation = navigation
    }
}
