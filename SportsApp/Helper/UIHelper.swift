//
//  UIHelper.swift
//  SportsApp
//
//  Created by eslam mohamed on 25/02/2022.
//

import UIKit


struct UIHelper{
    
    static public func createVerticalFlowLayout(in superView: UIView)-> UICollectionViewLayout{
        let width                       = superView.bounds.width - 15
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = superView.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection      = .vertical
        flowLayout.minimumLineSpacing   = 0
        
        return flowLayout
    }

    static public func createHorizontalFlowLayout(in superView: UIView)-> UICollectionViewLayout{
        let width                       = superView.bounds.width - 10
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = superView.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        return flowLayout
    }
    
    static public func createHorizontalFlow(in superView: UIView)-> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout()
        let availableWidth              = superView.frame.width / 3
        flowLayout.scrollDirection      = .horizontal
        let height                      = superView.bounds.height * 0.28
        let availableHeight             = height - 20
        flowLayout.itemSize             = CGSize(width: availableWidth, height: availableHeight)
        let padding: CGFloat            = 15
        flowLayout.sectionInset         = UIEdgeInsets(top: 5, left: padding, bottom: 5, right: padding)
        return flowLayout
        
    }
    
    
}





