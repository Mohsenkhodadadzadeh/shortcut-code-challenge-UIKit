//
//  NotificationPermission.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import UIKit
import UserNotifications

extension BrowseVC {
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
           
//           AppDelegate.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//               if let error = error {
//                   print("Error: ", error)
//               }
//           }
    }
}
