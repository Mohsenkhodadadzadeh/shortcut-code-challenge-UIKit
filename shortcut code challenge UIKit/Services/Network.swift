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
        
        var state200: NetworkChainProtocol = Response200()
        var state404: NetworkChainProtocol = NotResponse404()
        let state500: NetworkChainProtocol = ServerError500()
        
        
        state200.next = state404
        state404.next = state500
        
        let task = session.dataTask(with: strongUrl) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, let data = data {
                do {
                    let val: T = try state200.calculate(data, status: httpResponse.statusCode)
                    success(val)
                } catch {
                    if let err = error as? NetworkErrors {
                        failure(err)
                    } else {
                        failure(.unknownError(errorDescription: error.localizedDescription))
                    }
                }
            } else {
                failure(.unknownError(errorDescription: "server did not respond"))
            }
        }
        
        task.resume()
    }
    
}
