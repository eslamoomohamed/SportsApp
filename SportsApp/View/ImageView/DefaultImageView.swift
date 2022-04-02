//
//  DefaultImageView.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import UIKit

class DefaultImageView: UIImageView {
    
    let network     = NetworkManager.shared
    let cache       = NetworkManager.shared.cache

    let placeHolder = "logo"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImg()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImg(){
        
//        layer.cornerRadius = 15
        clipsToBounds      = true
        image              = UIImage(named: placeHolder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImg(from urlString: String){
        
        let cacheKy = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKy){
        
            self.image = image
            return
        }
        

        network.downloadImg(from: urlString) { result in
            switch result{
            case .success(let image):
                DispatchQueue.main.async { self.image = image }
            case .failure(let error):
                print(error)
                
            }
        }

    }
    
    
    
}
