//
//  RMEndpoint.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/26/23.
//

import Foundation
// Represent uniq api
@frozen enum RMEndpoint : String , Codable  {
// endpoint to get Character info
   case character 
    // endpoint to get locaation info
   case location
//    endpoint to get episode info 
   case episode

    
}
