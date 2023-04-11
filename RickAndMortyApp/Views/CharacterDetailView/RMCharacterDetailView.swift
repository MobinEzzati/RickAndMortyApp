

import UIKit

final class RMCharacterDetailView: UIView {
    
    public var collectionView : UICollectionView?
    private var viewModel:RMCharacterDetailViewViewModel
//
//    private let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        return spinner
//    }()
    
    init(frame: CGRect, viewModel:RMCharacterDetailViewViewModel ) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple

        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        guard let collectionView = collectionView else {
            return
        }
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
            
        ])
    }
    
    private func createCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout{ sectionIndex,_ in
            return self.createSection(for : sectionIndex)
            
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharactersPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharactersPhotoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }
    
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection{
        
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex]{
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()
        case .photo:
            return viewModel.createPhotoSectionLayout()
        }
    }
}

