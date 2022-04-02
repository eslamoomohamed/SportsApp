//
//  HomeVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 21/02/2022.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    
    var isExpanded = false
    lazy var listLayout = FlowLayout(layoutType: .list)
    lazy var stripLayout = FlowLayout(layoutType: .strip)

    let network   = NetworkManager.shared
    var sportsArr = [Sports]()
    let urls      = Utilities.shared

    var sportsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)

//        view.backgroundColor = UIColor(red: 188/255, green: 255/255, blue: 205/255, alpha: 1)
        view.backgroundColor = .white
//        self.locationManager.requestAlwaysAuthorization()

        

        
        configureSportsCollection()
        getDataFromApi()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sports"
    }
    
    
    private func configureSportsCollection(){
        sportsCollection = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
//        sportsCollection = UICollectionView(frame: .zero, collectionViewLayout: UltravisualLayout())
        sportsCollection.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.reuseID)
        view.addSubview(sportsCollection)
        sportsCollection.dataSource = self
        sportsCollection.delegate   = self
        sportsCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sportsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sportsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sportsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sportsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getDataFromApi(){
//        showLoadingView(animationName: "soccerLoading", backgroundColor: .lightGray)
//        network.fetchAllSports { result in
//            self.dismissLoadingView()
//            switch result {
//            case .success(let sportsArr):
////                print(sportsArr.count)
//                self.sportsArr = sportsArr
//                DispatchQueue.main.async {
//                    self.sportsCollection.reloadData()
//
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        showLoadingView(animationName: "soccerLoading", backgroundColor: .lightGray)
        network.fetchDataFromApi(urlString: urls.listAllSports, baseModel: SportsRoot.self) { result in
            self.dismissLoadingView()
            switch result {
            case .success(let sportsRoot):
                guard let sports = sportsRoot.sports else{return}
                self.sportsArr = sports
                DispatchQueue.main.async {
                    self.sportsCollection.reloadData()

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    
//    func fetchData(urlString:String,completion:@escaping (Result<SportsRoot,ErrorMessage>)-> Void) {
//        network.fetchDataFromApi(urlString: urls.listAllSports,compeletion:completion)
//    }
    
    
    private func performAnimation(collectionView: UICollectionView, indexPath:IndexPath){
    
    UIView.animate(withDuration: 0.4, delay: 0,
           usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
           options: [], animations: {
        
        collectionView.cellForItem(at: indexPath)!.transform =
               CGAffineTransform(scaleX: 2.0, y: 2.0)
        collectionView.cellForItem(at: indexPath)!.transform =
               CGAffineTransform(scaleX: 1.0, y: 1.0)
    }) { _ in
        
        let leaguesNC = LeaguesVC()
        leaguesNC.sportName = self.sportsArr[indexPath.row].strSport!
//        print(sportsArr[indexPath.row].strSport!)
        self.navigationController?.pushViewController(leaguesNC, animated: true)    }
    }

   

}




extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.reuseID, for: indexPath) as! SportCollectionViewCell
        cell.configureCell(with: sportsArr[indexPath.row])
        
        return cell
    }
    
}


extension HomeVC: UICollectionViewDelegate{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performAnimation(collectionView: collectionView, indexPath: indexPath)


    }
    
    
    
    
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
