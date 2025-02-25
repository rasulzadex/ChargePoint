//
//  TokTokenHelper.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
//https://app.tridenstechnology.com/auth/realms/tokaz/protocol/openid-connect/token

enum TokTokenHelper {
    case tokToken
    
    private var mainPath: String {
        return "tokaz/protocol/openid-connect/token"
    }
    private var baseURL: String {
        return BaseURL.refresh.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .tokToken:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
                "Accept": "*/*",
                "Accept-Encoding": "gzip, deflate",
                "Accept-Language": "en-US,en;q=0.9",
                "Connection": "keep-alive",
                "Content-type": "application/x-www-form-urlencoded",
                "Cookie" : "AUTH_SESSION_ID=14771af8-82cd-4bb8-92d8-8164a55ff660.4ec48c3580d3-26931; KEYCLOAK_IDENTITY=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzZTNlOTZjNS1kZjM4LTQ0YTQtYWM5NC1jODBiYmUxZWE3NWMifQ.eyJleHAiOjE3MzgzNTgwMjgsImlhdCI6MTczODMyMjAyOCwianRpIjoiMTI0NjVmNjItNjQ1MS00MGVjLWFhMTYtNmE5ZDVlNzNiMjdkIiwiaXNzIjoiaHR0cHM6Ly9hcHAudHJpZGVuc3RlY2hub2xvZ3kuY29tL2F1dGgvcmVhbG1zL3Rva2F6Iiwic3ViIjoiYWYzZDVjMTUtOTI4Yy00M2JlLWE5MmYtYmM1OTQzNjJlYTM1IiwidHlwIjoiU2VyaWFsaXplZC1JRCIsInNlc3Npb25fc3RhdGUiOiIxNDc3MWFmOC04MmNkLTRiYjgtOTJkOC04MTY0YTU1ZmY2NjAiLCJzaWQiOiIxNDc3MWFmOC04MmNkLTRiYjgtOTJkOC04MTY0YTU1ZmY2NjAiLCJzdGF0ZV9jaGVja2VyIjoieFRnZWZpcDJFRzlCbnFzWF9xamRzQUZrUksta2Rxdm9fRXQtc2VYYThTVSJ9.2PuuQnGzqR6-9ntMWKQHf4wMg6LSkV3vSmzDgU8OBnE",
                "Host": "app.tridenstechnology.com",
                "Origin" : "https://localhost",
                "Referer" : "https://localhost/",
                "Sec-Fetch-Dest" : "empty",
                "Sec-Fetch-Mode" : "cors",
                "Sec-Fetch-Site" : "cors-site",
                "X-Requested-With" : "com.tridenstechnology.tokaz"
          ]

    }
    func makeBody() -> String {
        let params = [
            "grant_type": "refresh_token",
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzZTNlOTZjNS1kZjM4LTQ0YTQtYWM5NC1jODBiYmUxZWE3NWMifQ.eyJpYXQiOjE3NDAxNjg1OTMsImp0aSI6Ijk1MjJjYTE4LWFkOGYtNDY1Zi1hNTc5LTY5YzU4ZjdhNGQ1MiIsImlzcyI6Imh0dHBzOi8vYXBwLnRyaWRlbnN0ZWNobm9sb2d5LmNvbS9hdXRoL3JlYWxtcy90b2theiIsImF1ZCI6Imh0dHBzOi8vYXBwLnRyaWRlbnN0ZWNobm9sb2d5LmNvbS9hdXRoL3JlYWxtcy90b2theiIsInN1YiI6ImFmM2Q1YzE1LTkyOGMtNDNiZS1hOTJmLWJjNTk0MzYyZWEzNSIsInR5cCI6Ik9mZmxpbmUiLCJhenAiOiJtb2JpbGUiLCJub25jZSI6ImNmZDNkYjc5LTY4MTUtNDA1ZS04OTQ2LTU0OWM4ODIxOGQ3OSIsInNlc3Npb25fc3RhdGUiOiIxNDc3MWFmOC04MmNkLTRiYjgtOTJkOC04MTY0YTU1ZmY2NjAiLCJzY29wZSI6Im9wZW5pZCB0b2theiB1c2VyaW5mbyBlbWFpbCBvZmZsaW5lX2FjY2VzcyBwcm9maWxlIiwic2lkIjoiMTQ3NzFhZjgtODJjZC00YmI4LTkyZDgtODE2NGE1NWZmNjYwIn0.G8rHGZygYF8yghopkyqVW8uiCooxGfRTNY1sWbTIpzM",
            "client_id": "mobile"
        ]
        return params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }


   
}
