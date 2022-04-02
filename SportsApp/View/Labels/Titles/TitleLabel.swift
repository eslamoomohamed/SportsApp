//
//  TitleLabel.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit

class TitleLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontColor: UIColor) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textColor     = fontColor
        configureTitleLabel()
    }
    
    private func configureTitleLabel(){
//        textColor                  = .label
        adjustsFontSizeToFitWidth  = true
        minimumScaleFactor         = 0.9
        lineBreakMode              = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
