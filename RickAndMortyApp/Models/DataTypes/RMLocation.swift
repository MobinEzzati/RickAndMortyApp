//
//  RMLocation.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import Foundation


struct RMLocation: Codable {

         let id:  Int
         let name:  String
         let type:  String
         let dimension: String
         let residents:  [String]
         let url:  String
         let created:  String
}
