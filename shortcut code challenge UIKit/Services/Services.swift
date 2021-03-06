//
//  RemoteServices.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import Foundation
import UIKit

public final class Services {
    
    fileprivate static var _generalUrl: String?
    
    fileprivate static var generalUrl: String {
        get {
            if Services._generalUrl == nil {
                Services._generalUrl = Services.getGeneralUrl()
            }
            return Services._generalUrl!
        }
    }
    
    fileprivate static func getGeneralUrl() -> String {
        let file = Bundle.main.path(forResource: "ServerEnvironments", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        let serviceURLString = dictionary["service_url"] as! String
        let destinationFileString = dictionary["destination_file"] as! String
        let retObj = "\(serviceURLString){0}/\(destinationFileString)"
        return retObj
    }
    
    static func urlGenerator(with id: Int? = nil) -> URL? {
        if let fileId = id {
            let urlString = Services.generalUrl.replacingOccurrences(of: "{0}", with: "\(fileId)")
            return URL(string: urlString)
        } else {
            let urlString = Services.generalUrl.replacingOccurrences(of: "{0}/", with: "")
            return URL(string: urlString)
        }
    }
    
    static func loadRemoteImage(url: URL, success _success: @escaping(UIImage?) -> Void,
    failure _failure: @escaping(NetworkErrors) -> Void) {
        
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        _success(UIImage(data: data))
                    }//: DISPATCHQUEUE MAIN
                } else {
                    DispatchQueue.main.async {
                        _failure(.notFound)
                    }//: DISPATCHQUEUE MAIN
                    
                }
            }//: DISPATCHQUEUE GLOBAL
            
        
    }
    
    
    
}
