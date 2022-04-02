//
//  Sports.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import Foundation
struct SportsRoot : Codable {
    let sports : [Sports]?

    enum CodingKeys: String, CodingKey {

        case sports = "sports"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sports = try values.decodeIfPresent([Sports].self, forKey: .sports)
    }

}
