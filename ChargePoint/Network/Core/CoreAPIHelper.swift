//
//  CoreAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 13.02.25.
//

import Foundation

enum HttpMethods: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}

enum BaseURL: String {
    case tok = "https://app.tridenstechnology.com"
    case touch = "https://api.az.touch-station.com/"
    case enrg = "https://api.evpoint.az/"
    case volt = "https://api.volt-ev.ru/"
    case gofar = "https://gofar.eu.charge.ampeco.tech/"
    case socar = "https://api.yocharge.com/v3/"
    case chargeaz = "https://app.tridenstechnology.com/"
    case refresh = "https://app.tridenstechnology.com/auth/realms/"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    
    func makeURL(baseURL: String,path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
}

