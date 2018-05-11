//
//  ViewController.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/9/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: Default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.placeholder = "Type your search here"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //First verify if the user typed something
        if (searchTextField.text?.isEmpty)!{
            showEmptyAlert() //If the search is empty, show an alert
        }
        
        let destination = segue.destination as! showsCollectionViewController
        
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        
        destination.searchTerm = searchTextField.text ?? ""
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK: Alert Handling
    
    @IBAction func showEmptyAlert(){
        let alert = UIAlertController(title: "Empty Search", message: "Please type a term to search for", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: { _ in
            print("Ok pressed")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
