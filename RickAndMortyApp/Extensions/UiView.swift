//
//  UiView.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/1/23.
//

import Foundation
import UIKit


extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach {
            addSubview($0)
        }
    }
}
