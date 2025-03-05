//
//  SocarAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 19.02.25.
//

import Foundation
//https://api.yocharge.com/v3/properties/homepage/?
enum SocarAPIHelper {
    case socar
    
    private var mainPath: String {
        return "properties/homepage/?client=c152ca12-8751-11ee-aef6-02420a000036&show_all=true"
    }
    private var baseURL: String {
        return BaseURL.socar.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .socar:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
                "accept": "application/json, text/plain, */*",
                "Authorization" : "Token clfajm-a6e78730ced333173533a044601312b5",
                "Content-Type" : "application/json",
                "Accept-Encoding" : "gzip",
                "User-Agent" : "okhttp/4.9.2",
                "app-version" : "2.0",
                "platform" : "mobile",
                "client-id" : "c152ca12-8751-11ee-aef6-02420a000036",
        ]
    }
   
}
