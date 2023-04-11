//
//  RMCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/4/23.
//

import Foundation


final class  RMCollectionViewCellViewModel : Hashable, Equatable {
  
  
    
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
        RMImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    
    
    // Mark : - hashable
    static func == (lhs: RMCollectionViewCellViewModel, rhs: RMCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatusText)
        hasher.combine(characterImageUrl)


    }
}
