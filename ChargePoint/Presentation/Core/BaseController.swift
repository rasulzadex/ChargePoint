//
//  BaseController.swift
//  ChargePoint
//
//  Created by Javidan on 01.02.25.
//

import UIKit

class BaseController: UIViewController {

    private lazy var authBG: ReusableImage = {
        let i = ReusableImage(imageName: "patternBG", contentMode: .scaleAspectFill, cornerRadius: 0)
        i.alpha = 0
        return i
    }()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .evBlue
        configureView()
        configureConstraints()
    }
    
    open func configureView() {
        view.addViews(view: [authBG])
    }
    
    open func configureConstraints() {
        authBG.fillSuperview()
    }
    

}
