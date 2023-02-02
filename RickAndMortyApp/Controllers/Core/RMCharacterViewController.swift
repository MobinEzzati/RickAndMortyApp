//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import UIKit
// controller to show character 
final class RMCharacterViewController: UIViewController {
    
    
    
    private let characterList = CharacterListView ()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        view.backgroundColor = .systemBackground 

        view.addSubview(characterList)
        viewConstraint()
    }
    
  private  func viewConstraint() {
        NSLayoutConstraint.activate([
            characterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterList.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
