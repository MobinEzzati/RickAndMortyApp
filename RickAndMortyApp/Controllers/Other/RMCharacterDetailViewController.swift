//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/9/23.
//

import UIKit

/// View cotroller to show info about single character
class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewViewModel
    private let detailView :RMCharacterDetailView
    
    init(viewModel: RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("it does not support")
    }
    
    // life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ferry.fill"),
                                                            style: .plain
                                                            , target: self,
                                                        action: #selector(didTapOnButton))
        view.addSubview(detailView)
        addConstrains()
        viewModel.fetchCharacterData()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    @objc
    func didTapOnButton(){
        print("ddfdf")
    }

    private  func addConstrains (){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension RMCharacterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType{
        case .photo( let viewModel):
            guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: RMCharactersPhotoCollectionViewCell.cellIdentifer,
                    for: indexPath)
                    as? RMCharactersPhotoCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        case .information(let viewModel):
            guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifer,
                    for: indexPath)
                    as? RMCharacterInfoCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModel[indexPath.row])

            return cell
        case .episodes(let viewModel):
            guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifer,
                    for: indexPath)
                    as? RMCharacterEpisodeCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModel[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let sectionType = viewModel.sections[section]
        
        switch sectionType{
            
        case .photo(viewModel: let viewModel):
            return 1
        case .information(viewModel: let viewModel):
            return viewModel.count
        case .episodes(viewModel: let viewModel):
            return viewModel.count
        }
        
    }
}
