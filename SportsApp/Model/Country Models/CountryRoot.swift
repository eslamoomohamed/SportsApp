//
//  CountryRoot.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import Foundation

struct CountryRoot: Codable{
    
    let countries : [Countries]?

    enum CodingKeys: String, CodingKey {

        case countries = "countries"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countries = try values.decodeIfPresent([Countries].self, forKey: .countries)
    }

}
