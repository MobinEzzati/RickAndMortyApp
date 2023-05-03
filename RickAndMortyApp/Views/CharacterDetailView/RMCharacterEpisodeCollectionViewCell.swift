//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/8/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Earth"
        lable.font = .systemFont(ofSize: 18 , weight: .regular)
        return lable
        
    }()
    private let nameLabel : UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Earth"
        lable.font = .systemFont(ofSize: 18 , weight: .regular)
        return lable
        
    }()
    private let airDateLabel : UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Earth"
        lable.font = .systemFont(ofSize: 18 , weight: .light)
        return lable
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.addSubviews(seasonLabel,nameLabel,airDateLabel)
        setUpConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraint(){
        
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            seasonLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: airDateLabel.topAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
            
   



        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
        
    }
    public func configure (with viewModel: RMCharacterEpisodeCollectionViewCellViewModel){
     
        viewModel.fetchEpisode()
        viewModel.registerData {[weak self ] data in
        
            self?.seasonLabel.text = data.episode
            self?.nameLabel.text = data.name
            self?.airDateLabel.text = data.air_date
        }

    }
}
