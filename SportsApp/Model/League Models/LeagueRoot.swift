//
//  LeagueRoot.swift
//  SportsApp
//
//  Created by eslam mohamed on 24/02/2022.
//

import Foundation

struct LeagueRoot: Codable{
    let countrys : [Leagues]?

    enum CodingKeys: String, CodingKey {

        case countrys = "countrys"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countrys = try values.decodeIfPresent([Leagues].self, forKey: .countrys)
    }

}

