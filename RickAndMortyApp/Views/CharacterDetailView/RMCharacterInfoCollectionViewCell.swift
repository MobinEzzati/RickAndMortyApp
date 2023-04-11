//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/8/23.
//

import UIKit
import Foundation

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterInfoCollectionViewCell"
//Mark -Init
    private let valueLable : UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Earth"
        lable.numberOfLines = 2
        lable.font = .systemFont(ofSize: 18 , weight: .light)
        return lable
        
    }()
    
    private let titleLabel : UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Location "
        return lable
        
    }()
    private let iconImageView : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "globe.americas.fill")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let titleContrainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(valueLable,titleContrainerView,iconImageView)
        titleContrainerView.addSubviews(titleLabel)
        setUpConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraint(){
        NSLayoutConstraint.activate([
            titleContrainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContrainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContrainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContrainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor , constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: titleContrainerView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContrainerView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContrainerView.topAnchor),

            valueLable.leftAnchor.constraint(equalTo: iconImageView.rightAnchor , constant: 10),
            valueLable.rightAnchor.constraint(equalTo: titleContrainerView.rightAnchor, constant: -10),
            valueLable.bottomAnchor.constraint(equalTo: titleContrainerView.topAnchor),
            valueLable.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 25),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 40),


        ])
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLable.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
        
    }
    public func configure (with viewModel: RMCharacterInfoCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.tintColor
        valueLable.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        
        
    }
}
