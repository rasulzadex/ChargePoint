//
//  TouchUseCase.swift
//  ChargePoint
//
//  Created by Javidan on 18.02.25.
//

import Foundation

protocol TouchUseCase {
    func getTouchStations(completion: @escaping(TouchAzDTO?, String?) -> Void)
}
