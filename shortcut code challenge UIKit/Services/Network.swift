//
//  Network.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import Foundation


public final class Network {
    
    internal let session = URLSession.shared
    
    // MARK: - Class Constructors
    public static let shared: Network = Network()
    
    // MARK: - Object Lifecycle
    private init() { }
    
    func getData<T: Codable>(url: URL?, success _success: @escaping(T) -> Void,
                             failure _failure: @escaping(NetworkErrors) -> Void) {
        
        let success: (T) -> Void = { value in
            DispatchQueue.main.async { _success(value) }
        }
        
        let failure: (NetworkErrors) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        
        
        guard let strongUrl = url else {
            failure(NetworkErrors.nilUrl)
            return
        }
        
        let task = session.dataTask(with: strongUrl) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode.isSuccessHTTPCode, let data = data else {
                if let httpStatusResponse = response as? HTTPURLResponse {
                    switch httpStatusResponse.statusCode {
                        
                    case 200...300: failure(.unknownError(errorDescription: "an error on getting data was accured"))
                        
                    case 404: failure(.notFound)
                    
                    case 500: failure(.internalServerError)
                        
                    default: failure(.unknownError(errorDescription: "unknown status code has been received"))
                        
                    }
                } else {
                    failure(.unknownError(errorDescription: "client cannot get HTTPStatus code"))
                }
                return
            }
            
            let retObj = try! JSONDecoder().decode(T.self, from: data)
                success(retObj)
        }
        
        task.resume()
    }
    
}
