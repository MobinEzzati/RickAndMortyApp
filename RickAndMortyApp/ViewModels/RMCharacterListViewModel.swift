//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/1/23.
//

import UIKit


protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadCharacters()
    func didSelectCharacter(_ character: RMCharacter)
    func didLoadMoreCharacters(with newIndexPaths : [IndexPath])
}

/// view Model to handle character list View logic
final class RMCharacterListViewModel : NSObject {
    
    public weak var  delegate : RMCharacterListViewModelDelegate?
    private var cellViewModels : [RMCollectionViewCellViewModel] = []
    private var apiInfo : Info? = nil
    private var isLoading = true
    private var characters:[RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageUrl: URL(string: character.image))
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }

            }
        }
    }
    private var isLoadingMoreCharacter = false
    
    public func fetchAdditonalCharacters(url : URL  ){
        guard !isLoadingMoreCharacter else{
            return
        }
        isLoadingMoreCharacter = true
        print("fetching more characters")

        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacter = false
            print("failed to create ")
            return
        }


        RMservices.shared.execute(request, expecting: RMGetCharacterRespone.self) {
            [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let respondModel):
                print("preupdate update is :\(strongSelf.cellViewModels.count)")
            
                let moreResult = respondModel.results
                print("first Item is :\(moreResult.first?.name)")
                let info = respondModel.info
               strongSelf.apiInfo = info
                let orginialCount = strongSelf.characters.count
                let newCount = moreResult.count
                let total = orginialCount + newCount
                let startingIndex = total - newCount - 1
                
                let indexPathsToAdd :[IndexPath] =
                Array(startingIndex..<(startingIndex + newCount) + 1).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
               strongSelf.characters.append(contentsOf: moreResult)
                print("post update is :\(strongSelf.cellViewModels.count)")
                DispatchQueue.main.async {
                    strongSelf
                    .delegate?
                    .didLoadMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacter = false

                }

            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacter = false
            }
        }
    }
    
    
    public var shouldLoadMoreIndicator:Bool {
        return  apiInfo?.next != nil
    }
    
    func fetchCharacters(){
        RMservices.shared.execute(.listCharacterRequest, expecting: RMGetCharacterRespone.self) { respone in
            switch respone {
            case .success(let list):
                print("total count is : \(list.results.count)" )
                self.characters = list.results
                self.apiInfo = list.info
                DispatchQueue.main.async {
                    self.delegate?.didLoadCharacters()
                    self.isLoadingMoreCharacter = false
                }
                 break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}

// collection view implmentaion
extension RMCharacterListViewModel : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("unsupported")

        }
        
        footer.startAnimating()
        return footer
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
        
    }
    
}

extension RMCharacterListViewModel : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldLoadMoreIndicator,
              !cellViewModels.isEmpty,
              !isLoadingMoreCharacter,
              let nextUrlString = apiInfo?.next,
        let url = URL(string: nextUrlString)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrolViewFixedHeight  = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrolViewFixedHeight - 120){
                self.fetchAdditonalCharacters(url: url)
            }
            t.invalidate()
           
        }
        
     
        
    }
}

