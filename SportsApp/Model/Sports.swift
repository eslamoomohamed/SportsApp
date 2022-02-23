//
//  Sport.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import Foundation
struct Sports : Codable {
    let idSport : String?
    let strSport : String?
    let strFormat : String?
    let strSportThumb : String?
    let strSportIconGreen : String?
    let strSportDescription : String?

    enum CodingKeys: String, CodingKey {

        case idSport = "idSport"
        case strSport = "strSport"
        case strFormat = "strFormat"
        case strSportThumb = "strSportThumb"
        case strSportIconGreen = "strSportIconGreen"
        case strSportDescription = "strSportDescription"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idSport = try values.decodeIfPresent(String.self, forKey: .idSport)
        strSport = try values.decodeIfPresent(String.self, forKey: .strSport)
        strFormat = try values.decodeIfPresent(String.self, forKey: .strFormat)
        strSportThumb = try values.decodeIfPresent(String.self, forKey: .strSportThumb)
        strSportIconGreen = try values.decodeIfPresent(String.self, forKey: .strSportIconGreen)
        strSportDescription = try values.decodeIfPresent(String.self, forKey: .strSportDescription)
    }

}
