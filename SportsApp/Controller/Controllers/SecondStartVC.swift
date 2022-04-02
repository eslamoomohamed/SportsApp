//
//  SecondStartVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 27/02/2022.
//

import UIKit

class SecondStartVC: UIViewController {

    
    enum Section{ case main }

    let networkShared                    = NetworkManager.shared
    var countryArr: [String]          = []
    var filterdCountriesArr: [String] = []
    var countriesName:CountriesName!
    let searchControllerr                = UISearchController()
    var isSearching                      = false
    var countryCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,String>!
    var newdataSource: UICollectionViewDiffableDataSource<Section,String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        getCountryArrData()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
    }
    

    private func configureNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Countries"
    }
    
    func getCountryArrData(){
        networkShared.urlSessionForCountries { result in
            switch result{
            case .success(let countries):
                print(countries[0].name_en!)
                for i in 0...countries.count - 1{
                    self.countryArr.append(countries[i].name_en!)
                }
                self.updateUI()
//                self.countryArr.sort()
                self.updateData(country: self.countryArr)
            case .failure(let error):
                print(error)
            }
        }
        
        
        networkShared.urlSessionForCountriesNames { result in
            switch result{
            case .success(let countriesName):
                self.countriesName = countriesName
                
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.countryCollectionView.reloadData()
        }
        
    }

    

    
    func configureCollectionView(){
        countryCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout:createThreeColumnFlowLayout() )
        view.addSubview(countryCollectionView)
        countryCollectionView.delegate = self
        countryCollectionView.backgroundColor = .systemBackground
        countryCollectionView.register(CountryCollectioCell.self, forCellWithReuseIdentifier: CountryCollectioCell.reuseID)
        
    }
    
    

    
    func configureSearchController(){
        
        let searchControllerr                                   = UISearchController()
        searchControllerr.searchResultsUpdater                  = self
        searchControllerr.searchBar.delegate                    = self
        searchControllerr.searchBar.placeholder                 = "search for country "
        searchControllerr.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                         = searchControllerr
        
    }
        
    
    
    func configureDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: countryCollectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectioCell.reuseID, for: indexPath)as! CountryCollectioCell
//            cell.setCell(country: self.countryArr[indexPath.row])
            
            cell.setCellWithUrl(country: self.countryArr[indexPath.row], Url: "https://flagcdn.com/80x60/eg.png")
            return cell
        })
        
        
    }
    
    
    func updateData(country: [String]){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,String>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(country)
        print(country[0])
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
     
    }
    
    
}




extension SecondStartVC: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
}


extension SecondStartVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
//        filterdCountriesArr.removeAll()  
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{return}
        isSearching = true
        filterdCountriesArr = countryArr.filter { $0.lowercased().contains(filter.lowercased()) }
        print(filterdCountriesArr)
        updateData(country: filterdCountriesArr)
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(country: countryArr)
    }
    
    
    
    
}



extension SecondStartVC{
    
    func createThreeColumnFlowLayout()-> UICollectionViewLayout{
        
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemSize                    = availableWidth / 3
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemSize, height: itemSize + 40)
        return flowLayout
        
    }

        }


