//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/27/23.
//

import Foundation
enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
}
/// primary network service for getting data
///
///
final class RMservices {
//    / singelton instance
    static let shared = RMservices()
//
    private init() {}
    
    public func execute<T: Codable>(_ request:RMRequest, expecting type: T.Type, completion: @escaping(Result<T , Error>) -> Void ){
        
        guard  let urlRequest = self.request(from: request)  else {
            
            return completion(.failure(ServiceError.failedToCreateRequest))
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, resopne, error in
            guard let data = data, error == nil else{
                completion(.failure( error ?? ServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try! JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    private func request (from rmRequest: RMRequest) -> URLRequest? {
       
        guard rmRequest.url != nil else  {
            return nil
        }
  
        var request = URLRequest(url: rmRequest.url)
        request.httpMethod = rmRequest.hettsMethod
        return request
        
    }
}
