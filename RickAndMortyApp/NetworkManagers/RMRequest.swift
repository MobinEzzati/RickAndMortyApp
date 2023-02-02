//
//  ApiCall .swift
//  RickAndMortyApp
//
//  Created by mobin on 1/26/23.
//

import Foundation
// object that represent single api call 
final class RMRequest {
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    //n desired endpoint
    let endpoint : RMEndpoint
    // Path component for api
    let pathComponents:[String]
    //Query argument for api
    let queryParameters: [URLQueryItem]
    //constructed url api 
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        string += "/"

        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "\($0)"
                
            }
        }
        if !queryParameters.isEmpty{
            string += "?"
            let argumentString = queryParameters.compactMap({
                return "\($0.name)=\($0.value ?? "nil")"
            }).joined(separator: "&")
            string  += argumentString
        }
        return string
    }
    
//    constructed url for api
    
    public var url : URL {
        return URL(string: urlString)!
    }
// request method
    public let hettsMethod = "GET"
    
    
    
   public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let listCharacterRequest = RMRequest(endpoint: .character)
}
