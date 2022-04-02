//
//  NetworkManager.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import UIKit

class NetworkManager{
    
    
    static let shared = NetworkManager()
    let cache         = NSCache<NSString, UIImage>()
    let urls          = Utilities.shared
    private init(){}
   
    func fetchDataFromApi<B:Codable>(urlString:String,baseModel: B.Type,compeletion: @escaping (Result<B,ErrorMessage>)->Void) {
        
        guard let url = URL(string: urlString) else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }

            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(B.self, from: data)
                compeletion(.success(result))
                
                
            }catch{
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
        
        
        
        
    }
//    
    
    
    
    func fetchAllSports(compeletion: @escaping (Result<[Sports],ErrorMessage>)-> Void) {
        
        guard let url = URL(string: urls.listAllSports) else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(SportsRoot.self, from: data)
                guard let sportsArr = result.sports else{return}
                compeletion(.success(sportsArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func urlSessionForCountries(compeletion: @escaping (Result<[Countries],ErrorMessage>)-> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_countries.php") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let result = try decoder.decode(CountryRoot.self, from: data)
                guard let countryArr = result.countries else{return}
//                print(countryArr.count)
//                print(result)
//                print(result.countries)
                compeletion(.success(countryArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func urlSessionForCountriesNames(compeletion: @escaping (Result<CountriesName,ErrorMessage>)-> Void) {
        
        guard let url = URL(string: "https://flagcdn.com/en/codes.json") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let countryNameArr = try decoder.decode(CountriesName.self, from: data)
                compeletion(.success(countryNameArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func urlSessionForCountriesLeague(countryName: String,sportName: String,compeletion: @escaping (Result<[Leagues],ErrorMessage>)-> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=\(countryName)&s=\(sportName)") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let result = try decoder.decode(LeagueRoot.self, from: data)
                guard let leaguesArr = result.countrys else{return}
//                print(leaguesArr.count)
//                print(result)
//                print(result.countries)
                compeletion(.success(leaguesArr))
                
                
            }catch{
                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func urlSessionForAllEvents(compeletion: @escaping (Result<[Events],ErrorMessage>)-> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4328&s=2021-2022") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print("the\(data)")
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(EventsRoot.self, from: data)
                guard let eventsArr = result.events else{return}
                compeletion(.success(eventsArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func urlSessionForSpecificEvents(leagueID:String,roundNumber:String,compeletion: @escaping (Result<[Events],ErrorMessage>)-> Void) {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(leagueID)&r=\(roundNumber)&s=2021-2022") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print("the\(data)")
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(EventsRoot.self, from: data)
                guard let eventsArr = result.events else{return}
                compeletion(.success(eventsArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
     static var count = 1
    func downloadImg(from urlString: String, completion: @escaping (Result<UIImage,ErrorMessage>)-> Void){
        
        let cacheKy = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {return}
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{return}
            guard let data     = data   else{return}
            
            guard let image = UIImage(data: data) else{return}
            self.cache.setObject(image, forKey: cacheKy)
            completion(.success(image))
            NetworkManager.count += 1
//            print(NetworkManager.count)
            
            
        }
        
        
        
        
        task.resume()
        
    }
    
    
    
    
    
    
    
    func urlSessionForAllTeamsInALeague(leauge: String,Country: String,compeletion: @escaping (Result<[Teams],ErrorMessage>)-> Void) {
        
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(leauge)") else{
            guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(leauge)") else{
            compeletion(.failure(.invalidUrl))
            return }
        
        
        //            let request = URLRequest(url: url)
        //            let session = URLSession(configuration: URLSessionConfiguration .default)
        //            let task = session.dataTask(with: request) { (data, response, error) in
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                compeletion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                compeletion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                compeletion(.failure(.invalidData))
                return
            }
//            print(data)
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(TeamsRoot.self, from: data)
                guard let teamsArr = result.teams else{return}
                compeletion(.success(teamsArr))
                
                
            }catch{
//                print(error.localizedDescription)
                compeletion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
}
