//
//  ImageButton.swift
//  SportsApp
//
//  Created by eslam mohamed on 28/02/2022.
//

import UIKit

class ImageButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(typeOfBtn: typeOfButton){
        super.init(frame: .zero)
        configure()
        switch typeOfBtn {
        case .returnBtn:
            setImage(UIImage(named: "left-arrow8"), for: .normal)
        case .shareLink:
            setImage(UIImage(named: "share"), for: .normal)
        case .facebook:
            setImage(UIImage(named: "facebookIcon"), for: .normal)
        case .instagram:
            setImage(UIImage(named: "instagramIcon"), for: .normal)
        case .youtube:
            setImage(UIImage(named: "youtubeIcon"), for: .normal)
            self.tintColor = .white
        case .addToFavorite:
            setImage(UIImage(named: "favoriteIcon"), for: .normal)
        case .twitter:
            setImage(UIImage(named: "twitterIcon"), for: .normal)
        }
    }
    
    
    private func configure(){ translatesAutoresizingMaskIntoConstraints = false }
    
    

}



