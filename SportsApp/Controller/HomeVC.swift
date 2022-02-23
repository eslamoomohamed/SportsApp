//
//  HomeVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 21/02/2022.
//

import UIKit

class HomeVC: UIViewController {

    let network   = NetworkManager.shared
    var sportsArr = [Sports]()
    
    var sportsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        network.urlSession { result in
            switch result {
            case .success(let sportsArr):
//                print(sportsArr.count)
                self.sportsArr = sportsArr
                DispatchQueue.main.async {
                    self.sportsCollection.reloadData()

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        configureSportsCollection()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    
    private func configureSportsCollection(){
        sportsCollection = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        sportsCollection.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.reuseID)
        view.addSubview(sportsCollection)
//        sportsCollection.backgroundColor = .yellow
        sportsCollection.dataSource = self
        sportsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sportsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            sportsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sportsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sportsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
   

}




extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.reuseID, for: indexPath) as! SportCollectionViewCell
        
        return cell
    }
    
}


extension HomeVC: UICollectionViewDelegate{
    
    private func createFlowLayout()-> UICollectionViewLayout{
        let width                       = view.bounds.width
//        let padding: CGFloat            = 15
//        let minimumItemSpacing: CGFloat = 15
        let availableWidth              = width //- (padding * 2) //- minimumItemSpacing
        let itemSize                    = availableWidth
        let height                      = view.bounds.height * 0.28
        let availableHeight             = height
        let itemHeight                  = availableHeight
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemHeight)
        flowLayout.scrollDirection      = .vertical
        flowLayout.minimumLineSpacing   = 0
        
        return flowLayout
    }
}
