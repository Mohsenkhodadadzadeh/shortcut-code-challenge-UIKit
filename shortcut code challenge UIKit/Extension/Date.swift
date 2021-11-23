//
//  Date.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import Foundation

extension Date {
    static func convertToDate(_ objects: String...) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        if objects.isEmpty { return nil}
        let retObj = dateFormatter.date(from: "\(objects[safe: 0] ?? "1990" )-\(objects[safe: 1] ?? "01")-\(objects[safe: 2] ?? "01")T\(objects[safe: 3] ?? "00:00:00")+0000")
        
        return retObj
    }
    
    mutating func convertToLongDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
            
        return dateFormatter.string(from: self)
        
    }
}
