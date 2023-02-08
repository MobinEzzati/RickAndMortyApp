//
//  RMCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/4/23.
//

import Foundation


final class  RMCollectionViewCellViewModel {
public let characterName:String
public let characterStatusText: RMCharacterStatus
public let characterImageUrl: URL?
    
    init (
        characterName:String,
        characterStatusText: RMCharacterStatus,
        characterImageUrl: URL?
    
    ){
        self.characterStatusText = characterStatusText
        self.characterName =  characterName
        self.characterImageUrl = characterImageUrl
        
    }
    
    
    public var characterStatus : String {
        
        return characterStatusText.text
    }
    
    
    public func  fetchImage (completion : @escaping((Result<Data, Error>) -> Void)){
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data , error == nil else{
                completion(.failure(error
                                    ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        
    }
}
