//
//  TouchAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 18.02.25.
//

import Foundation
enum TouchAPIHelper {
    case touch
    
    private var mainPath: String {
        return "api/chargestations/guest"
    }
    private var baseURL: String {
        return BaseURL.touch.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .touch:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return ["accept": "application/json"]
    }
   
}
