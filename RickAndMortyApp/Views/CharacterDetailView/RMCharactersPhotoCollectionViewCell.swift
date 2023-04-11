//
//  RMCharactersPhotoCollectionViewCellsCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/8/23.
//

import UIKit

final class RMCharactersPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharactersPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
    
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraint(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil 
    }
    public func configure (with viewModel: RMCharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage {
            [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)

                }
            case .failure(let failure):
                break
            }
        }
    }
}
