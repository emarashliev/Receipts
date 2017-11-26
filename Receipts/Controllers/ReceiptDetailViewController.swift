//
//  ReceiptDetailViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 25.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class ReceiptDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        //        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back))
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor =  UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

/*
 extension ReceiptDetailViewController: UITableViewDataSource {
 
 func numberOfSections(in tableView: UITableView) -> Int {
 return 2
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 <#code#>
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 <#code#>
 }
 }
 */
