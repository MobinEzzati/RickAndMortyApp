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
    
    
    public var urlString: String {
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
    
    /// attempt to request
    /// - Parameter url: url to pars
    convenience init?(url : URL){
        let string = url.absoluteString
       
        if !string.contains(Constants.baseUrl){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/?") {
            let components = trimmed.components(separatedBy: "/?")
            if !components.isEmpty, components.count >= 2{
                let endpointString = components[0]
                let queryItemsString = components[1]
              
                let queryItems:[URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({

                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")


                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]

                    )
                })
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    print("endPoint is \(rmEndpoint)")
                    self.init(endpoint: rmEndpoint , queryParameters:queryItems)
                    return
                }
            }
        }else if trimmed.contains("/"){
            
            
            let components = trimmed.components(separatedBy: "/")

            if !components.isEmpty , components.count > 1{
                var  pathComponents:[String] = []
                pathComponents.append(components[1])
                
                let   endpoint = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpoint){
                    print("trimmed :\(trimmed)")

                    self.init(endpoint: rmEndpoint , pathComponents: pathComponents)
                    return

                }
            }
            
        }
        return nil
    }
}

extension RMRequest {
    static let listCharacterRequest = RMRequest(endpoint: .character)
}
