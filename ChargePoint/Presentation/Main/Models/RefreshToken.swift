//
//  RefreshToken.swift
//  ChargePoint
//
//  Created by Javidan on 22.02.25.
//

import Foundation

struct ChargeToken: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshExpiresIn: Int
    let refreshToken: String
    let tokenType: String
    let idToken: String
    let notBeforePolicy: Int
    let sessionState: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case idToken = "id_token"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
}


struct TokToken: Codable {
    let accessToken: String
    let expiresIn, refreshExpiresIn: Int
    let refreshToken, tokenType, idToken: String
    let notBeforePolicy: Int
    let sessionState, scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case idToken = "id_token"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
}
