//
//  EnrgAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//
//https://api.evpoint.az/Station?

import Foundation
enum EnrgAPIHelper {
    case enrg
    
    private var mainPath: String {
        return "Station?"
    }
    private var baseURL: String {
        return BaseURL.enrg.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .enrg:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
//                "accept": "application/json, text/plain, */*",
//                "Authorization" : "Token ckimt9-8c50184e5d7fe93087bcb7437fc205e9",
//                "Content-Type" : "application/json",
                "Accept-Encoding" : "gzip",
                "user-agent" : "Dart/3.4 (dart:io)",
                "host" : "api.evpoint.az",
                
        ]
    }
   
}
