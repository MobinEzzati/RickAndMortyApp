//
//  RMEpisodes.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import Foundation


struct RMEpisodes: Codable{
  let id: Int
  let name: String
  let air_date: String
  let episode: String
  let characters: [String]
  let url: String
  let created: String
}
