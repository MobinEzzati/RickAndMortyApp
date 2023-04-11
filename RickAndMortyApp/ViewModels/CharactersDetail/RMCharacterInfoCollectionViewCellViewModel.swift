//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mobin on 3/9/23.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private  let type :charTypes
    public let value: String
    
    static let dateFormater:DateFormatter = {
       let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        return formatter
    }()
    static let shortDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    public var title: String{
        self.type.displayTitle
    }
    public var displayValue:String {
        if value == "" {return "None"}
        
        if type == .created{
            print("format:\(value)")
        }
        if let date = Self.dateFormater.date(from: value),
           type == .created {

            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    public var iconImage: UIImage? {
        return type.iconImage
    }
    public var tintColor: UIColor? {
        return type.tintColor
    }
    
    enum charTypes:String{
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        var tintColor : UIColor? {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemGray
            case .species:
                return .systemMint
            case .origin:
                return .systemCyan
            case .created:
                return .systemTeal
            case .location:
                return .systemPink
            case .episodeCount:
                return .systemMint
            }
        }
        var iconImage : UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        var displayTitle:String {
            switch self {
            case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EpisodeCount"
            }
        }
    }
    init(
        type: charTypes,
        value : String
    ){
        self.type = type
        self.value = value
    }
}
