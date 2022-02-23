//
//  NetworkManager.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    func urlSession(compeletion: @escaping (Result<[Sports],ErrorMessage>)-> Void) {
            guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else{ return }
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration .default)
            let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else{return}
            print(data)
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(SportsRoot.self, from: data)
                    
                    guard let sportsArr = result.sports else{return}
                    print(sportsArr.count)
//                    for sport in sportsArr {
//                        print(sport)
//                    }
                    compeletion(.success(sportsArr))
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }

}
