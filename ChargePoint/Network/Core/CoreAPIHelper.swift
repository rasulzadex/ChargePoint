//
//  CoreAPIHelper.swift
//  MoovieeAPP
//
//  Created by Javidan on 24.12.24.
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
    case tok = "tok"
    case touch = "https://api.az.touch-station.com/"
    case enrg = "https://api.evpoint.az/"
    case volt = "https://api.volt-ev.ru/"
    case gofar = "https://gofar.eu.charge.ampeco.tech/"
    case socar = "https://api.yocharge.com/v3/"
    case chargeaz = "charge"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    
    func makeURL(baseURL: String,path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
}

