//
//  BaseViewState.swift
//  ChargePoint
//
//  Created by Javidan on 17.12.25.
//
import Foundation

public protocol BaseViewStateProtocol {}

public enum BaseViewState: BaseViewStateProtocol {
    case loading
    case loaded
    case error(String)
    case success
}
