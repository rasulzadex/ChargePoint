//
//  BaseController.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import UIKit

class BaseController: UIViewController {

    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .evBlue
        configureView()
        configureConstraints()
    }
    
    open func configureView() {

    }
    
    open func configureConstraints() {
    }
    

}
