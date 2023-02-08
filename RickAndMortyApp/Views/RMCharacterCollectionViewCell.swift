//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/4/23.
//

import UIKit

class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
    
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
//        image.co
        return image
    }()
    
    
    private let nameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false

        return lable
    }()
    
    private let statusLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .light)
        lable.translatesAutoresizingMaskIntoConstraints = false


        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(imageView,nameLable,statusLable)
        contentView.layer.cornerRadius = 8
//        contentView.layer.cornerCurve = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.2
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            statusLable.heightAnchor.constraint(equalToConstant: 30),
            nameLable.heightAnchor.constraint(equalToConstant: 30),
            
        
            statusLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLable.bottomAnchor.constraint(equalTo: statusLable.topAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: nameLable.topAnchor , constant: -3 ),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor ),

        
        ])
      
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLable.text = nil
        statusLable.text = nil
        
    }
    
    public func configure(with viewModel: RMCollectionViewCellViewModel){
        nameLable.text = viewModel.characterName
        statusLable.text = "Status:\(viewModel.characterStatus)"
        viewModel.fetchImage {[weak self ] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(String(describing: error))
                
            }
        }
    }
}
