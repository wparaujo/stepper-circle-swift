//
//  Header.swift
//  circular-progress-bar
//
//  Created by mac on 22/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SnapKit

class Header: UIView {
    
    var stepperCircleView: StepperCircleView = {
        let view = StepperCircleView()
        return view
    }()
    
    var adhesionStepDescriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "flsdjflk;sdjfldks;jafjadlsk;jfdskladsj\nfldsjafdslakjlk;j\nlkjlkjlk;jlk;jk;jlk"
        view.numberOfLines = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(stepperCircleView) { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(stepperCircleView.snp.height)
        }
        
        addSubview(adhesionStepDescriptionLabel) { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(stepperCircleView.snp.trailing).multipliedBy(1.1)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}

extension UIView {
    
    func addSubview<T: UIView>(_ view: T, _ constraints: (_ make: ConstraintMaker) -> Void) {
        addSubview(view)
        view.snp.makeConstraints(constraints)
    }
    
}

