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
        viewController.searchViewControllerDelegate = self
        return viewController
    }()
    
    private lazy var detailViewController: ReceiptDetailViewController = {
        let identifier = String(describing: ReceiptDetailViewController.self)
        let viewController =
            storyboard.instantiateViewController(withIdentifier: identifier) as! ReceiptDetailViewController
        return viewController
    }()
    
    private lazy var popOverViewController: PopOverViewController = {
        let identifier = String(describing: PopOverViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            as! PopOverViewController
        return viewController

    }()
    
    func start() {
        self.navigationController.viewControllers = [self.listViewController]
    }
}

// MARK: - ReceiptListControllerDelegate
extension AppCoordinator: ReceiptListControllerDelegate {
    
    func didSelect(receipt: ReceiptViewModel) {
        detailViewController.receiptViewModel = receipt
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func searchViewController() -> SearchViewController? {
        return listViewController.childViewControllers.first as? SearchViewController
    }
    
}

// MARK: - SearchViewControllerDelegate
extension AppCoordinator: SearchViewControllerDelegate {
 
    func showPopOverViewController(with sourceView: UIView) {
        popOverViewController.preferredContentSize =
            CGSize(width: UIScreen.main.bounds.width - 100, height: 100)
        popOverViewController.modalPresentationStyle = .popover
        let popover = popOverViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        
        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
        
        searchViewController()?.present(popOverViewController, animated: true)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension AppCoordinator: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
