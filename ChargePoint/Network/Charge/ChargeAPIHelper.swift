//
//  ChargeAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
//https://app.tridenstechnology.com/charge-and-drive/api/v1/chargers
enum ChargeAPIHelper {
    case charge
    
    private var mainPath: String {
        return "charge-and-drive/api/v1/chargers"
    }
    private var baseURL: String {
        return BaseURL.chargeaz.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .charge:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    
    func makeHeader(token: String) -> [String:String] {
        return [
                "Accept": "*/*",
                "Accept-Encoding": "gzip, deflate",
                "Accept-Language": "en-US,en;q=0.9",
                "Connection": "keep-alive",
                "Content-type": "application/json",
                "Host": "app.tridenstechnology.com",
                "Authorization" : "Bearer "+token,
                "Origin" : "https://localhost",
                "Referer" : "https://localhost/",
                "Sec-Fetch-Dest" : "empty",
                "Sec-Fetch-Mode" : "cors",
                "Sec-Fetch-Site" : "cors-site",
                "X-Requested-With" : "com.tridenstechnology.chargeaz"
          ]

    }

}
