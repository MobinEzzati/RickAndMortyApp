//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/26/23.
//

import Foundation

/// primary network service for getting data
final class NetworkService {
//    / singelton instance
    static let shared = NetworkService()
// 
    private init() {}
    
    public func execute(_ request:ApiRequest, completion:@escaping() -> Void){
        
    }
}
