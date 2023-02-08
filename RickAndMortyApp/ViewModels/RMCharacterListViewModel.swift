//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/1/23.
//

import UIKit


protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadCharacters()
}

final class RMCharacterListViewModel : NSObject {
    
    public weak var  delegate : RMCharacterListViewModelDelegate?
    private var cellViewModels : [RMCollectionViewCellViewModel] = []
    private var characters:[RMcharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    func fetchCharacters(){
        
        RMservices.shared.execute(.listCharacterRequest, expecting: RMGetCharacterRespone.self) { respone in
            switch respone {
            case .success(let list):
                print("total count is : \(list.results.first?.url ?? "nil")" )
                self.characters = list.results
                DispatchQueue.main.async {
                    self.delegate?.didLoadCharacters()
                }
                 break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}

extension RMCharacterListViewModel : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      guard   let cell = collectionView
            .dequeueReusableCell(
            withReuseIdentifier:
            RMCharacterCollectionViewCell
            .cellIdentifier,
            for: indexPath) as? RMCharacterCollectionViewCell else {
          fatalError("unsupported cell ")
      }
        cell.backgroundColor = .systemFill
         
        cell.configure(with: cellViewModels[indexPath.row])
        return cell 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width,
                      height: width * 1.5)
        
    }
    
    
    
}
