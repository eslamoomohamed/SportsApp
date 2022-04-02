//
//  UIViewControllers+Extension.swift
//  SportsApp
//
//  Created by eslam mohamed on 25/02/2022.
//


import UIKit
import SafariServices
import Lottie



fileprivate var containerView: UIView!
fileprivate var animationView = AnimationView()

extension UIViewController{
    
    
    func showLoadingView(animationName: String,backgroundColor: UIColor){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = backgroundColor
        containerView.alpha           = 0
        UIView.animate(withDuration: 0.1) {containerView.alpha = 1}
        containerView.addSubview(animationView)
        animationView.loopMode  = .loop
        animationView.animation = Animation.named(animationName)
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func presentSafariVC(with url : URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    
    
    
            static func showToast(controller: UIViewController, message: String, seconds: Double) {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                // rgb(0, 129, 138)
                alert.view.backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 0.8)
               
                let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 138.0/255.0, alpha: 1.0)]
                let titleString = NSAttributedString(string: message, attributes: titleAttributes)
                alert.setValue(titleString, forKey: "attributedTitle")
                alert.view.layer.cornerRadius = 15
                controller.present(alert, animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                    alert.dismiss(animated: true)
                }
            }
    
    
    
    
    
    func presentAlert(title:String, message: String ,style:UIAlertController.Style,deleteAction:@escaping (_ action:UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle:style )
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: deleteAction))
        self.present(alert, animated: true, completion: nil)
        
        
    }

    
}
