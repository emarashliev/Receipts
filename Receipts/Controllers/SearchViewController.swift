//
//  SearchViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 24.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBAction func easyPressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        
        popover.sourceView = sender as? UIView
        popover.sourceRect = (sender as! UIView).bounds
        
        present(vc, animated: true) {
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
