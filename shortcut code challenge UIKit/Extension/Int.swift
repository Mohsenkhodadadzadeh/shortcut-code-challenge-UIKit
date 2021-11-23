//
//  Int.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import Foundation

extension Int {
  public var isSuccessHTTPCode: Bool {
    return 200 <= self && self < 300
  }
}
