//
//  ResultsTableViewController+UITableViewDataSource.swift
//  Code Cracker Solver
//
//  Created by Rajan Fernandez on 11/04/16.
//  Copyright © 2016 Rajan Fernandez. All rights reserved.
//

import UIKit

extension ResultsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if let exactMatches = exactMatches , exactMatches.count > 0 {
            sections += 1
        }
        if let partialMatches = partialMatches , partialMatches.count > 0 {
            sections += 1
        }
        return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return exactMatches?.count ?? 0
        case 1:
            return partialMatches?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        switch (indexPath as NSIndexPath).section {
        case 0:
            guard let exactMatches = exactMatches else {
                break
            }
            cell.textLabel?.text = exactMatches[(indexPath as NSIndexPath).row]
        case 1:
            guard let partialMatches = partialMatches else {
                break
            }
            cell.textLabel?.text = partialMatches[(indexPath as NSIndexPath).row]
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Exact Matches"
        case 1:
            return "Partial Matches"
        default:
            return nil
        }
    }
    
}
