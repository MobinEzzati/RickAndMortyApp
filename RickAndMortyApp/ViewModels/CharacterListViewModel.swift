//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/1/23.
//

import UIKit
// views that handeling showing list of the characters
final class CharacterListViewModel : NSObject {
    
    func fetchCharacters(){
        
        RMservices.shared.execute(.listCharacterRequest, expecting: RMGetCharacterRespone.self) { respone in
            switch respone {
            case .success(let list):
                print("total count is : \(list.info.count)" )

                 break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}

extension CharacterListViewModel : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width,
                      height: width * 1.5)
        
    }
    
    
    
}
