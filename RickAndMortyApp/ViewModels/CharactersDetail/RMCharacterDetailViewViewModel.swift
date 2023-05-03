//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/9/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    public var episodes: [String]{
        character.episode
    }
    enum SectionTypes {
        case photo(viewModel:RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModel:[RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModel:[RMCharacterEpisodeCollectionViewCellViewModel])
    }
    public var sections :[SectionTypes] = []
    
    public var requestUrl : URL? {
        return URL(string: character.url)
    }
    public var title :String {
        character.name.uppercased()
    }
    
    init(character: RMCharacter) {
        self.character = character
        setUpConnections()
    }
    
    func setUpConnections(){
        sections = [
            .photo(viewModel:.init(imageUrl: URL(string: character.image)!)),
            .information(viewModel: [
                .init(type:.status, value: character.status.text),
                .init(type:.gender,value: character.gender),
                .init(type:.type,value: character.type),
                .init(type:.species,value: character.species),
                .init(type:.origin,value: character.origin.name ),
                .init(type:.location,value: character.location.name ),
                .init(type:.episodeCount,value: "\(character.episode.count)"),
                .init(type: .created, value: character.created)
                
            ]
            )
            ,
            .episodes(viewModel: character.episode.compactMap({ string in
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: string))
            }))
        ]
    }
    
    public func fetchCharacterData() {
        guard let url = requestUrl,
              let request = RMRequest(url: url) else {
            print("failed to create")
            return 
        }
       
        RMservices.shared.execute(request, expecting: RMCharacter.self) { result in
            switch result {
            case .success(let success):
//                print( String(describing: success))
                print(" ")
            case .failure(let failure):
                print( String(describing: failure))

            }
        }
    }
     public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
            
                                          )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                      leading: 0,
                                                      bottom: 10,
                                                      trailing: 0)
      
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(320)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:.fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
            
                                          )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1,
                                                      leading: 2,
                                                      bottom: 2,
                                                      trailing: 2)
      
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150)),
            subitems: [item ]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
            widthDimension:.fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
            
                                          )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                      leading: 8,
                                                      bottom: 10,
                                                      trailing: 8)
      
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
