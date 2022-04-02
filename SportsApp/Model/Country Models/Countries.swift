//
//  Countries.swift
//  SportsApp
//
//  Created by eslam mohamed on 23/02/2022.
//

import Foundation

struct Countries: Codable,Hashable {
    
    let name_en : String?

    enum CodingKeys: String, CodingKey {

        case name_en = "name_en"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
    }

}

