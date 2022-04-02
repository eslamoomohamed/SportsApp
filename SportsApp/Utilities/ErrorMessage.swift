//
//  ErrorMessage.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import Foundation

enum ErrorMessage: String,Error{
    case noInternet      = "No Internet Please Check Your Connection"
    case invalidUrl      = "invalid URL, Please try again later"
    case invalidResponse = "Invalid response from the server, Please try again later"
    case invalidData     = "The data recived from the server is invalid"
    case noImageSaved    = "No Image Saved Please try again later"
}
