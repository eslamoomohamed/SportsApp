//
//  ErrorMessage.swift
//  SportsApp
//
//  Created by eslam mohamed on 22/02/2022.
//

import Foundation

enum ErrorMessage: String,Error{
    case noInternet = "No Internet Please Check Your Connection"
    case invalidResponse = "Invalid response from the server, Please try again later"
    case invalidData     = "The data recived from the server is invalid"

}
