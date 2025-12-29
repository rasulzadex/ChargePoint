//
//  BaseViewModel.swift
//  ChargePoint
//
//  Created by Javidan on 17.12.25.
//

public protocol BaseViewModelDelegate: AnyObject {
    func didChangeState(to newState: BaseViewStateProtocol)
}

public protocol BaseViewModelProtocol: AnyObject {
    associatedtype StateType: BaseViewStateProtocol
    var onStateChange: ((StateType) -> Void)? { get set }
    var baseDelegate: BaseViewModelDelegate? { get set }
    func setState(state: StateType)
}

open class BaseViewModel<State: BaseViewStateProtocol>: BaseViewModelProtocol {
    
    public typealias StateType = State
    
    public var onStateChange: ((State) -> Void)?
    public weak var baseDelegate: BaseViewModelDelegate?
    
    public init() {
        // Default empty implementation
    }
    
    open func setState(state: State) {
        onStateChange?(state)
        baseDelegate?.didChangeState(to: state)
    }
}
