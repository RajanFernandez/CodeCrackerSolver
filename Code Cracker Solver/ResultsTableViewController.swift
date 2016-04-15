//
//  ResultsTableViewController.swift
//  Code Cracker Solver
//
//  Created by Rajan Fernandez on 11/04/16.
//  Copyright © 2016 Rajan Fernandez. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var exactMatches: [String]?
    var partialMatches: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Results"
    }
    
    
}
