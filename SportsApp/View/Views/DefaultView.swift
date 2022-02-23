//
//  DefaultView.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import UIKit

class DefaultView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configireView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(viewColor:UIColor, viewRaduis: CGFloat) {
        super.init(frame: .zero)
        configireView()
        self.backgroundColor    = viewColor
        self.layer.cornerRadius = viewRaduis
    }
    
    private func configireView(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor                           = .lightGray
    }
    
}
