//
//  RMStatus.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/26/23.
//

import Foundation

enum RMCharacterStatus : String , Codable {
    
    case alive = "Alive"
    case unknown = "unknown"
    case Dead = "Dead"
    var text : String {
        switch self {
        case .alive,.Dead :
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
