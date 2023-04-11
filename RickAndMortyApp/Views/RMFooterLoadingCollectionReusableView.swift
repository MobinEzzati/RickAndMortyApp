//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/13/23.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true 
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    static let identifier  = "RMFooterLoadingCollectionReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraint()
    }
    required init?(coder: NSCoder){
        
        fatalError("unsupported ")
    }
    
    func addConstraint(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func startAnimating() {
        spinner.startAnimating()
    }
        
}
