//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import UIKit
// controller to show character 
final class RMCharacterViewController: UIViewController , RMCharacterListViewDelegate {
  
    
    
    
    
    private let characterList = RMCharacterListView ()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title  = "Character"
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        view.backgroundColor = .systemBackground 

        view.addSubview(characterList)
        viewConstraint()
    }
    
  private  func viewConstraint() {
      characterList.delegate = self
        NSLayoutConstraint.activate([
            characterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterList.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVc = RMCharacterDetailViewController(viewModel: viewModel)
        detailVc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVc, animated: true)
    }

}
