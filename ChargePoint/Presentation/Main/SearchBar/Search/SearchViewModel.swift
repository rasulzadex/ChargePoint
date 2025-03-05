//
//  SearchViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 01.03.25.
//

import Foundation
final class SearchViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error
    }
    private weak var navigation: SearchNavigation?
    
    init(navigation: SearchNavigation?) {
        self.navigation = navigation
    }
    
    var callback: ((ViewState)->Void)?
}
