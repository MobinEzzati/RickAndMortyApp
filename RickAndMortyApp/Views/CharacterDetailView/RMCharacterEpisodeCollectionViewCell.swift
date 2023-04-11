//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/8/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraint(){
        
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    public func configure (with viewModel: RMCharacterEpisodeCollectionViewCellViewModel){
        
    }
}
