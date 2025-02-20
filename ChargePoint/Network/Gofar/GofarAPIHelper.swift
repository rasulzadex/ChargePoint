//
//  GofarAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//

import Foundation

enum GofarAPIHelper {
    case gofar
    
    private var mainPath: String {
        return "api/v2/app/locations"
    }
    private var baseURL: String {
        return BaseURL.gofar.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .gofar:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
                "Accept": "application/json, text/plain, */*",
                "Accept-Encoding": "gzip",
                "Accept-Language": "en",
                "Connection": "Keep-Alive",
                "Content-Type": "application/json;charset=utf-8",
                "Host": "gofar.eu.charge.ampeco.tech",
                "User-Agent": "okhttp/4.9.2",
                "x-mobile-app-bundle-id": "az.gofar.app",
                "x-internal-app-version": "2.159.0"
          ]

    }
    func makeBody() -> [String:Any] {
        return  [
            "locations": [
                "8": nil,
                "21": nil,
                "16": nil,
                "7": nil,
                "23": nil,
                "25": nil,
                "27": nil,
                "12": nil,
                "24": nil,
                "20": nil,
                "19": nil,
                "11": nil,
                "26": nil
            ]
        ]
    }
   
}
