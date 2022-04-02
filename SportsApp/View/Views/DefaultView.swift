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
    
    
    func addShadow(){
        layer.shadowColor = UIColor.init(_colorLiteralRed: 241/255, green: 241/255, blue: 241/255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
    
    
    func addBorder(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
