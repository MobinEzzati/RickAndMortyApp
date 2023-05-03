//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/9/23.
//

import Foundation

protocol RMREpisodeDataRender{
    var name : String {get}
    var air_date : String {get}
    var episode : String{ get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel{
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock : ((RMREpisodeDataRender) -> Void)?
    private var episode: RMEpisodes? {
        didSet{
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?){
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func registerData(_ block:((RMREpisodeDataRender) -> Void)? ){
        self.dataBlock =  block
    }
    public func fetchEpisode() {
        print(episodeDataUrl)
        print("created:")
        
        guard !isFetching else {
            if let model = episode {
                self.dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl,
              let request = RMRequest(url: url) else {
            return
        }
        isFetching = true
        RMservices
            .shared
            .execute(request,
                     expecting: RMEpisodes.self) { result in
                switch result {
                case .success(let model):
                    print(String(describing: model))
                    DispatchQueue.main.async {
                        self.episode = model
                    }
                    
                case .failure(let failure):
                    print(String(describing: failure))
                }
            }
    }
}
