//
//  SearchViewController.swift
//  Code Cracker Solver
//
//  Created by Rajan Fernandez on 11/04/16.
//  Copyright © 2016 Rajan Fernandez. All rights reserved.
//

import UIKit
import CCSolver
import MBProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        inputTextField.delegate = self
        
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultsViewController = segue.destination as! ResultsTableViewController
        resultsViewController.exactMatches = sender as? [String]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return sender != nil
    }
    
    
    // MARK: Utilities
    
    /**
     Dismisses the keyboard when the user taps the main view.
     */
    @IBAction func didTapMainView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /**
     * Searchs the dictionary for matches to an incomplete word. Unknown letters should be replaced by punctuation marks in the input string.
     */
    func searchForPartialWord(_ word: String, withCallback callback: (_ results: [String]?) -> ()) {
        
        guard let
            input = inputTextField.text,
            let word = parseInput(input) else {
                return
        }
        
        let results = CCWordSolver.shortlist(forIncompleteWord: word) as NSArray as? [String]
        callback(results)
    }
    
    /**
     * Parses a string and returns a unsolved instance of CCWord
     */
    func parseInput(_ input: String) -> CCWord? {
        
        guard input.characters.count > 0 else {
            return nil
        }
        
        var word = CCWord()
        let charSet = CharacterSet.letters
        var code = [Character : UInt]()
        
        func codeIndexForCharacter(_ character: Character) -> UInt? {
            return code[character]
        }
        
        func addCharacter(_ character: Character, forIndex index: UInt) {
            let c = CChar(String(character).utf16.first!)
            let square = CCSquare(index: index, character: c, row: 0, column: 0)
            word?.addSquare(square)
        }
        
        for character in input.characters {
            
            if let index = code[character] {
                
                addCharacter(character, forIndex: index)
                
            } else  {
                
                let index = UInt(code.count)
                
                guard index < 26 else {
                    return nil
                }
                
                code[character] = index
                addCharacter(character, forIndex: index)
            }
        }
        
        return word
    }
    
    /**
     * Displays an alert to notify the user that no words match incomplete the word they searched for.
     */
    func displayNoResultsAlert() {
        let alert = UIAlertController(title: "No Results", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            DispatchQueue.main.async(execute: { 
                self.inputTextField.becomeFirstResponder()
            })
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
