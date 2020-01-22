//
//  Header2.swift
//  circular-progress-bar
//
//  Created by mac on 22/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class Header: UIView {
    
    let content = ContentHeader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(content) { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}
