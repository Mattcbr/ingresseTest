//
//  showsCollectionViewController.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/10/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "showCollectionViewCell"

class showsCollectionViewController: UICollectionViewController, RequestDelegate {
    
    var searchTerm = String()
    var r = Request()
    var showsArray: [Show]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.navigationItem.title = searchTerm
        r.delegate = self
        r.requestInfo(searchTerm: searchTerm)
        
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showsArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? showCollectionViewCell else {
            fatalError("Not a show collection view cell")
        }
    
        let showToDisplay: Show = showsArray![indexPath.row]
        
        if(showToDisplay.thumbnailPath != "image404"){
        Alamofire.request((showToDisplay.thumbnailPath)).responseImage { response in
            print("\nImage Request for \(showToDisplay.name) Response:\n\(response)")
            
            if let image = response.result.value {
                cell.showPosterImageView.image = image
            }
        }
        }
        
        var genreText: String
        
        if (!showToDisplay.genre.isEmpty){
            genreText = showToDisplay.genre[0]
        } else {
            genreText = "Genre Unavailable"
        }
        
        cell.showTitleLabel.text = showToDisplay.name
        cell.showGenreLabel.text = genreText
        return cell
    }

    func didLoadShows(Shows: [Show]) {
        showsArray = Shows
        print ("Array atualizado\nFUNCIONA!!")
    }
    
    func didFailToLoadShows(withError error: Error) {
        print("Deu ruim")
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
