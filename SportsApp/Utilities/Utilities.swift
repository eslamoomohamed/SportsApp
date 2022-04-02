//
//  Utilities.swift
//  SportsApp
//
//  Created by eslam mohamed on 24/02/2022.
//

import Foundation

class Utilities{
    
    static let shared = Utilities()
    private init(){}
    
    
    let listAllSports  = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"

    let listAllCountries = "https://www.thesportsdb.com/api/v1/json/2/all_countries.php"

    
    let listAllLeagues                 = "https://www.thesportsdb.com/api/v1/json/2/all_leagues.php"
    let listAllLeaguesByCountry        = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England"
    let listAllLeaguesByCountryAndSpor = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=Soccer"
    let listAllSeasonsInALeague        = "https://www.thesportsdb.com/api/v1/json/2/search_all_seasons.php?id=4328"

    

    let allEventsInSpecificLeagueBySeason = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4328&s=2014-2015"
    let specificEventsInRoundByLeagueIdRoundSeason = "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38&s=2014-2015"
    let last5EventsByTeamId = "https://www.thesportsdb.com/api/v1/json/2/eventslast.php?id=133602"
    
    let teamsURL = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?L=Soccer&c=Egypt"
    let listAllTeamsInALeagueBySportAndCountry = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?s=Soccer&c=Spain"
}


enum typeOfButton{
    case returnBtn
    case shareLink
    case facebook
    case youtube
    case twitter
    case instagram
    case addToFavorite
}
