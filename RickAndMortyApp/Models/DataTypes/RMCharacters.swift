//
//  RMCharacters.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import Foundation

struct RMcharacter: Codable {
    
         let id: Int
        let name: String
        let status: RMStatus
        let species: String
        let type:String
        let gender: String
        let origin: RMOrigin
        let location: RMPlanet
        let image: String
        let episode: [String]
        let url: String
        let created: String
    
    
    
}



