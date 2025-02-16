//
//  AuthNavigation.swift
//  ChargePoint
//
//  Created by Javidan on 07.02.25.
//

import Foundation
protocol AuthNavigation: AnyObject {
    func goRegister()
    func pop()
    func goHome()
}
