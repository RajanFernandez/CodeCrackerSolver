//
//  SearchViewController+UITextFieldDelegate.swift
//  Code Cracker Solver
//
//  Created by Rajan Fernandez on 11/04/16.
//  Copyright © 2016 Rajan Fernandez. All rights reserved.
//

import UIKit
import MBProgressHUD

extension SearchViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // If there is input in the test field, search for words that match the input.
        // If the search returns matches segue to the resutls screen, and if not, show an alert.
        
        if let input = inputTextField.text {
            
            inputTextField.resignFirstResponder()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: { [weak self] in
                self?.searchForPartialWord(input, withCallback: { (results) in
                    DispatchQueue.main.async(execute: {
                        
                        MBProgressHUD.hide(for: self?.view, animated: true)
                        
                        if let results = results , results.count > 0 {
                            self?.performSegue(withIdentifier: "ToResultsView", sender: results)
                        } else {
                            self?.displayNoResultsAlert()
                        }
                    })
                })
            })
        }
        
        return true
    }
}
