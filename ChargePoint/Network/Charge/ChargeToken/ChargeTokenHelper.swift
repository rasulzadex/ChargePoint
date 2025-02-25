//
//  File.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation
//https://app.tridenstechnology.com/auth/realms/charge-az/protocol/openid-connect/token

enum ChargeTokenHelper {
    case chargeToken
    
    private var mainPath: String {
        return "charge-az/protocol/openid-connect/token"
    }
    private var baseURL: String {
        return BaseURL.refresh.rawValue
    }
    
     var endPoint: URL? {
        switch self {
        case .chargeToken:
            return CoreAPIHelper.instance.makeURL(baseURL: baseURL , path: mainPath)
        }
    }
    
    func makeHeader() -> [String:String] {
        return [
                "Accept": "*/*",
                "Accept-Encoding": "gzip, deflate",
                "Accept-Language": "en-US,en;q=0.9",
                "Connection": "keep-alive",
                "Content-Length" : "842",
                "Content-type": "application/x-www-form-urlencoded",
                "Cookie" : "AUTH_SESSION_ID=5dfe695c-db3b-4187-be5d-7fcf0807ab37.4ec48c3580d3-26931; KEYCLOAK_IDENTITY=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJhZTliZDY3Ny04NGQ2LTQ2NzAtOGQxMi00M2Y0YTEwZmEwZmMifQ.eyJleHAiOjE3MzgzOTgwOTIsImlhdCI6MTczODM2MjA5MiwianRpIjoiY2NhZmNmZjgtMjEyOS00NmE5LWE4M2ItYTkxZjg2YjhhMmM1IiwiaXNzIjoiaHR0cHM6Ly9hcHAudHJpZGVuc3RlY2hub2xvZ3kuY29tL2F1dGgvcmVhbG1zL2NoYXJnZS1heiIsInN1YiI6Ijg5ZTQyZDhmLWFlNTctNDNmNi05MDlmLTU3ODIwNzFjOTNhZCIsInR5cCI6IlNlcmlhbGl6ZWQtSUQiLCJzZXNzaW9uX3N0YXRlIjoiNWRmZTY5NWMtZGIzYi00MTg3LWJlNWQtN2ZjZjA4MDdhYjM3Iiwic2lkIjoiNWRmZTY5NWMtZGIzYi00MTg3LWJlNWQtN2ZjZjA4MDdhYjM3Iiwic3RhdGVfY2hlY2tlciI6IjZyZDd0ZkNzZHVnU3BERVUwd2FzenM1bDJXcE1KdENCRUtHblFndHdSWjgifQ.vz97tZUrsX16-F2F_Nu6XgubGHbkvVFBGh7ILKetbE0",
                "Host": "app.tridenstechnology.com",
                "Origin" : "https://localhost",
                "Referer" : "https://localhost/",
                "Sec-Fetch-Dest" : "empty",
                "Sec-Fetch-Mode" : "cors",
                "Sec-Fetch-Site" : "cors-site",
                "X-Requested-With" : "com.tridenstechnology.chargeaz"
          ]

    }
    func makeBody() -> String {
        let params = [
            "grant_type": "refresh_token",
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJhZTliZDY3Ny04NGQ2LTQ2NzAtOGQxMi00M2Y0YTEwZmEwZmMifQ.eyJpYXQiOjE3NDAxNTg4MTQsImp0aSI6ImQwZDNiMDdhLWUyYzUtNGFiYS05MzVmLWMwMGY4MTk3NDVhYSIsImlzcyI6Imh0dHBzOi8vYXBwLnRyaWRlbnN0ZWNobm9sb2d5LmNvbS9hdXRoL3JlYWxtcy9jaGFyZ2UtYXoiLCJhdWQiOiJodHRwczovL2FwcC50cmlkZW5zdGVjaG5vbG9neS5jb20vYXV0aC9yZWFsbXMvY2hhcmdlLWF6Iiwic3ViIjoiODllNDJkOGYtYWU1Ny00M2Y2LTkwOWYtNTc4MjA3MWM5M2FkIiwidHlwIjoiT2ZmbGluZSIsImF6cCI6Im1vYmlsZSIsIm5vbmNlIjoiMGIxMzYwNGYtNGQzZi00MmI0LThhNGItNWYxOTNjOTZkYzg1Iiwic2Vzc2lvbl9zdGF0ZSI6IjVkZmU2OTVjLWRiM2ItNDE4Ny1iZTVkLTdmY2YwODA3YWIzNyIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgb2ZmbGluZV9hY2Nlc3MgY2hhcmdlLWF6IHVzZXJpbmZvIGVtYWlsIiwic2lkIjoiNWRmZTY5NWMtZGIzYi00MTg3LWJlNWQtN2ZjZjA4MDdhYjM3In0.bXecnwkE7uJM9JAY74xMbJvuKgcS8xuJbQvJTaliUrs",
            "client_id": "mobile"
        ]
        return params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }


   
}
