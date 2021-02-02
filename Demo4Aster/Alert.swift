//
//  Alert.swift
//  Demo4Aster
//
//  Created by Kaustubh on 02/02/21.
//

import Foundation
import UIKit

class Alert {

    static var rootViewController: UIViewController!
    static var alertController: UIAlertController!

    static func show(title: String, message: String, buttonTitle: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        if let controller = UIApplication.shared.windows.last?.rootViewController {
            if !(controller.presentedViewController is UIAlertController) {
                rootViewController = controller
                rootViewController.present(alertController, animated: true)
            }
        }
    }
}
