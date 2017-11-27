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
            storyboard.instantiateViewController(withIdentifier: identifier) as! ReceiptListController
        viewController.delegate = self
        return viewController
    }()
    
    private lazy var detailViewController: ReceiptDetailViewController = {
        let identifier = String(describing: ReceiptDetailViewController.self)
        let viewController =
            storyboard.instantiateViewController(withIdentifier: identifier) as! ReceiptDetailViewController
        return viewController
    }()
    
    private lazy var popOverController: PopOverViewController = {
        let identifier = String(describing: PopOverViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            as! PopOverViewController
        return viewController

    }()
    
    func start() {
        self.navigationController.viewControllers = [self.listViewController]
    }
}


extension AppCoordinator: ReceiptListControllerDelegate {
    
    func didSelect(receipt: Receipt) {
        detailViewController.receipt = receipt
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func popOverViewController() -> PopOverViewController {
        return popOverController
    }
}


