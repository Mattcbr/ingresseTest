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
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var searchTerm = String()
    var errorMessage = String()
    var r = Request()
    var showsArray: [Show]? {
        didSet {
            self.collectionView?.reloadData()
            loadingView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        
        self.navigationItem.title = "Results"
        r.delegate = self
        r.requestInfo(searchTerm: searchTerm)
        
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        
        cell.imageLoadingIndicator.hidesWhenStopped = true
        cell.imageLoadingIndicator.startAnimating()
        
        if(showToDisplay.thumbnailPath != "image404"){
            Alamofire.request((showToDisplay.thumbnailPath)).responseImage { response in
                print("\nImage Request for \(showToDisplay.name) Response:\n\(response)")
                
                if let image = response.result.value {
                    cell.showPosterImageView.image = image
                }
            }
        } else {
            cell.showPosterImageView.image = UIImage(named: "defaultImageIngresse")
        }
        cell.imageLoadingIndicator.stopAnimating()
        
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
        if (showsArray!.count < 1) {
            showNotFoundAlert()
        }
    }
    
    func didFailToLoadShows(withError error: Error) {
        errorMessage = error.localizedDescription
        showErrorAlert()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! detailsViewController
        let cell = sender as! showCollectionViewCell
        var selectedIndexPath = self.collectionView?.indexPath(for: cell)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Results"

        let selectedShow: Show = showsArray![(selectedIndexPath?.row)!]
        let showImage = cell.showPosterImageView.image
        
        destination.showImage = showImage!
        destination.selectedShow = selectedShow
        navigationItem.backBarButtonItem = backItem
    }
    
    
    // MARK: Alert Handling
    @IBAction func showNotFoundAlert(){
        let alert = UIAlertController(title: "Nothing found", message: "Your search for \(searchTerm) found nothing.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Back", comment: "Default action"), style: .default, handler: { _ in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showErrorAlert(){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Back", comment: "Default action"), style: .default, handler: { _ in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

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
