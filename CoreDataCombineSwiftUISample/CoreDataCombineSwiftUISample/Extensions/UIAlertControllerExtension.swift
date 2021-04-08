//
//  UIAlertControllerExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func showPermissionsPopup(withMessage alertMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil,
                                          message: alertMessage,
                                          preferredStyle: .alert)
            let notNowAction = UIAlertAction(title: "Not Now",
                                             style: .cancel,
                                             handler: nil)
            alert.addAction(notNowAction)
            let settingsAction = UIAlertAction(title: "Go To Settings",
                                               style: .default){ void in
                guard let url = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            alert.addAction(settingsAction)
            alert.preferredAction = settingsAction
            alert.showOnTopWindow()
        }
    }
    
    class func showAlert(withTitle title: String?, message: String?, actionTitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: actionTitle,
                                             style: .cancel,
                                             handler: nil)
            alert.addAction(cancelAction)
            alert.showOnTopWindow()
        }
    }
    
    func showOnTopWindow() {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(self, animated: true, completion: nil)
        }
//        guard var topController = UIApplication.shared.keyWindow?.rootViewController else {
//            return
//        }
//        while let presentedViewController = topController.presentedViewController {
//            topController = presentedViewController
//        }
//        topController.present(self, animated: true, completion: nil)
    }
}
