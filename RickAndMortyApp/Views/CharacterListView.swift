//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/1/23.
//

import Foundation
import UIKit

final class CharacterListView: UIView{

    
    
    private let viewModel = CharacterListViewModel()
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        addSubviews(spinner, collectionView)
        viewModel.fetchCharacters()
        setUpConstraint()
        setCollectionView()


    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   private func setUpConstraint() {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)

        ])
        
    }
   private func setCollectionView() {
        collectionView.dataSource = viewModel
       collectionView.delegate = viewModel
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
           
           self.spinner.stopAnimating()
           self.collectionView.isHidden = false
         
           UIView.animate(withDuration: 0.4) {
               self.collectionView.alpha = 1
           }
           
       })
        
    }
    
   
    
}


