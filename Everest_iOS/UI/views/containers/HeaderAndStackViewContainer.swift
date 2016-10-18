//
//  HeaderAndStackViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO 
/*
 UI skeleton composed of a 'header' and 'content' section,
 the content section containing a stack view for uniform
 subview layout.
*/
class HeaderAndStackViewContainer: HeaderViewContainer {
    var baseInputView: BaseInputView
    
    override init(_ coder: NSCoder? = nil) {
        baseInputView = BaseInputView()
        
        if let coder = coder {
            super.init(coder)
        } else {
            super.init()
        }
        
        setContentView(view: baseInputView)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
        
        //SKO - Since sideBorder depends on constraints, call here
        self.headerView.sideBorder(side: .bottom, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
        self.statusBarView.sideBorder(side: .bottom, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        baseInputView.translatesAutoresizingMaskIntoConstraints = false
        
        baseInputView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        baseInputView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        baseInputView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    //SKO - Pass subview on for handling by BaseInputView instance
    func addArrangedSubview(view: UIView) {
        baseInputView.addArrangedSubview(view: view)
    }
}