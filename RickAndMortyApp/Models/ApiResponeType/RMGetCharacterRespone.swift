//
//  RMGetCharacterRespone.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/29/23.
//

import Foundation

struct Info : Codable {
    let count: Int
    let pages : Int
    let next: String?
    let prev: String?
}

struct RMGetCharacterRespone: Codable {
 
    let info: Info
    let results:[RMCharacter]
}

