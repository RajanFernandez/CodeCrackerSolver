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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // If there is input in the test field, search for words that match the input.
        // If the search returns matches segue to the resutls screen, and if not, show an alert.
        
        if let input = inputTextField.text {
            
            inputTextField.resignFirstResponder()
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { [weak self] in
                self?.searchForPartialWord(input, withCallback: { (results) in
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        MBProgressHUD.hideHUDForView(self?.view, animated: true)
                        
                        if let results = results where results.count > 0 {
                            self?.performSegueWithIdentifier("ToResultsView", sender: results)
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