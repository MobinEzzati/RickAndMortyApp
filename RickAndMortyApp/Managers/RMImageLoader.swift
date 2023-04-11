//
//  ImageLoader.swift
//  RickAndMortyApp
//
//  Created by mobin on 2/22/23.
//

import Foundation

final class RMImageLoader {
    static let shared  = RMImageLoader()
    private var imageCatch = NSCache<NSString, NSData>()
    private init (){}
    
    /// get image content with url
    /// - Parameters:
    ///   - url: Source Url
    ///   - completion: Call back
    public func downloadImage(_ url: URL , completion: @escaping(Result<Data,Error>) -> Void){
        let request = URLRequest(url: url)
        let key = url.absoluteString as NSString
        
        if let data = imageCatch.object(forKey: key) {
            print("reading from catch \(data)")
            completion(.success(data as Data))
            return
        }

        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
        
            guard let data = data , error == nil else{
                completion(.failure(error
                                    ?? URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageCatch.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
        
    }
}
