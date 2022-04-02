//
//  StartScreenVC.swift
//  SportsApp
//
//  Created by eslam mohamed on 27/02/2022.
//

import UIKit
import Reachability

class StartScreenVC: UIViewController {

    enum Section{ case main }

    let networkShared                    = NetworkManager.shared
    let reachability                     = try? Reachability()

    var countryArr: [Countries]          = []
    var filterdCountriesArr: [Countries] = []
    let searchControllerr                = UISearchController()
    var isSearching                      = false
    var countryTableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section,Countries>!

    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .white
        checkNetwork()
        configureNavigationBar()
        getCountryArrData()
        configureTableView()
        configureSearchController()
        configureDataSource()
        
    }
    
    func checkNetwork(){


        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func configureNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title          = "Countries"
        let skipBtn    = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipBtnTapped))
        let selectBtn  = UIBarButtonItem(image: UIImage(named: "selectIcon"), style: .plain, target: self, action: #selector(selectAllRows))
        navigationItem.rightBarButtonItems = [skipBtn]

    }
    
    func getCountryArrData(){
        networkShared.urlSessionForCountries { result in
            switch result{
            case .success(let countries):
                self.countryArr = countries
                self.updateUI()
//                self.countryArr.sort()
                self.updateData(countries: self.countryArr)
            case .failure(let error):
                print(error)
            }
        }
    }


    @objc func selectAllRows() {
        for section in 0..<countryTableView.numberOfSections {
            for row in 0..<countryTableView.numberOfRows(inSection: section) {
                countryTableView.selectRow(at: IndexPath(row: row, section: section), animated: false, scrollPosition: .none)
            }
        }
        

    }
    
    
    @objc func skipBtnTapped(){
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: []) {
//
//            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//            sceneDelegate!.window?.rootViewController = sceneDelegate?.createTabBarController()
//        }, completion: { true in
//            print("finished")
//
//        }
        
        
        UIView.animate(withDuration: 2, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
            self.showLoadingView(animationName: "soccerLoading", backgroundColor: .lightGray)

        }) { res in
//            self.dismissLoadingView()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate!.window?.rootViewController = sceneDelegate?.createTabBarController()
        }



    }

    
    
    
    func configureTableView(){
                
        countryTableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(countryTableView)
        countryTableView.delegate        = self
        countryTableView.backgroundColor = .clear
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseID)
        countryTableView.separatorStyle = .none
        countryTableView.allowsMultipleSelection = true
        
        
        
        NSLayoutConstraint.activate([
        
            countryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            countryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            countryTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            countryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
        ])
    
        
    }
    
    func configureSearchController(){
        searchControllerr.searchResultsUpdater                  = self
        searchControllerr.searchBar.delegate                    = self
        searchControllerr.searchBar.placeholder                 = "search for Country "
        searchControllerr.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                         = searchControllerr
        
    }
    
//    func configureSearchBar(){
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.delegate = self
//    }
    
    
    func updateUI(){
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
        
    }

    
    
    
    func configureDataSource(){
  
        dataSource = UITableViewDiffableDataSource<Section,Countries>(tableView: countryTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
            cell.setCell(country: self.countryArr[indexPath.row])
            return cell
        })

        
        
    }

    
    
    
    func updateData(countries: [Countries]){
        
//        print("arr is \(countries)")
        var snapshot = NSDiffableDataSourceSnapshot<Section,Countries>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countries)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
        
    }

    
    
    
    


}


extension StartScreenVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
        cell.setCell(country: countryArr[indexPath.row])
        return cell
    }
    
    
}

extension StartScreenVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.setSelected(true, animated: true)
    }
    
}


extension StartScreenVC: UISearchResultsUpdating, UISearchBarDelegate{
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text?.lowercased(), !filter.isEmpty else{return}
        isSearching = true
        filterdCountriesArr = countryArr.filter { $0.name_en!.lowercased().starts(with: filter) }
        print("filterdCountriesArr \(filterdCountriesArr)")
        updateData(countries: filterdCountriesArr)
        
//        for i in countryArr{
//            print(i.name_en)
//            if (i.name_en)?.lowercased() == filter{
//                filterdCountriesArr.append(i)
//            }
//        }
//        print("filterdCountriesArr \(filterdCountriesArr)")

        
//        updateData(countries: [countryArr[0],countryArr[1]])

        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(countries: countryArr)
    }
    
    
    
    
}
