//
//  AppCoordinator.swift
//  Receipts
//
//  Created by Emil Marashliev on 25.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
    
    
    lazy var rootViewController: UIViewController = {
        return self.navigationController
    }()
    
    private let storyboard = UIStoryboard(name: "App", bundle: nil)
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    private lazy var listViewController: ReceiptListController = {
        let identifier = String(describing: ReceiptListController.self)
        let viewController =
            self.storyboard.instantiateViewController(withIdentifier: identifier) as! ReceiptListController
        return viewController
    }()
    
    private lazy var detailViewController: ReceiptDetailViewController = {
        let identifier = String(describing: ReceiptDetailViewController.self)
        let viewController =
            self.storyboard.instantiateViewController(withIdentifier: identifier) as! ReceiptDetailViewController
        return viewController
    }()
    
    func start() {
        self.navigationController.viewControllers = [self.listViewController]
    }

}
