//
//  VoltAPIHelper.swift
//  ChargePoint
//
//  Created by Javidan on 20.02.25.
//

import Foundation
enum VoltAPIHelper {
    case volt


    private var mainPath: String {
        return "quantum/rest/q/v2/cc/locations?lat1=38.57598&lon1=48.39117&lat2=42.05817&lon2=50.6218&locale=az_VOLT&tags="
    }
    private var baseURL: String {
        return BaseURL.volt.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .volt:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
                "accept": "application/json, text/plain, */*",
                "authorization" : "Bearer cd480519f8ea2ae53016662ade256c5c7931e709f892064d78f68cf0be3bb7bf",
                "Content-Type" : "application/json",
                "Connection" : "Keep-Alive",
                "Accept-Encoding" : "gzip",
                "Host" : "api.volt-ev.ru",
                "User-Agent" : "okhttp/4.9.2",
                "x-appcorrelationid" : "9E3RND",
                "x-appdeviceinfo" : "Samsung/unknown/13/TQ2B.230505.005.A1/1e4666d70fdf3496/Android",
                "x-applocale" : "az",
                "x-applocation" : "40.392326 49.8767463",
                "x-appname" : "volt",
                "x-appservices" : "CarCharging",
                "x-apptimestamp" : "1740068943790",
                "x-appversion" : "1090402502"
        ]
    }
   
}
