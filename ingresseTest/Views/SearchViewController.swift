//
//  ViewController.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/9/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchTextField.placeholder = "Type your search here"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! showsCollectionViewController
        
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        
        destination.searchTerm = searchTextField.text ?? ""
        navigationItem.backBarButtonItem = backItem
    }

}

