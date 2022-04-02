//
//  TeamsRoot.swift
//  SportsApp
//
//  Created by eslam mohamed on 24/02/2022.
//

import Foundation

struct TeamsRoot: Codable{
    
    let teams : [Teams]?

    enum CodingKeys: String, CodingKey {

        case teams = "teams"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teams = try values.decodeIfPresent([Teams].self, forKey: .teams)
    }

}
