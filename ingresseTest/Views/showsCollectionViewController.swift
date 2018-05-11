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
    // MARK: Outlets and Vars
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var searchTerm = String()
    var errorMessage = String()
    var r = Request()
    var showsArray: [Show]? {
        didSet {
            //When the array with shows has been set reloads the collection view and stops the loading view
            self.collectionView?.reloadData()
            loadingView.stopAnimating()
        }
    }
    
    // MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure and start the loading view
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        
        self.navigationItem.title = "Results"
        navigationController?.isNavigationBarHidden = false
        
        //Configure the delegate and make a request to the API with the desired term
        r.delegate = self
        r.requestInfo(searchTerm: searchTerm)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
        //Get the show selected by the user
        let showToDisplay: Show = showsArray![indexPath.row]
        
        //Configuring and starting a loading indicator to the imageview in the cell
        cell.imageLoadingIndicator.hidesWhenStopped = true
        cell.imageLoadingIndicator.startAnimating()
        
        //If the flag for "no image" has not been set, request the show image
        if(showToDisplay.thumbnailPath != "image404"){
            Alamofire.request((showToDisplay.thumbnailPath)).responseImage { response in
                if let image = response.result.value {
                    cell.showPosterImageView.image = image //Set the show image
                    cell.imageLoadingIndicator.stopAnimating() //Stop the loading indicator once the image has been loaded.
                }
            }
        } else {    //If there's no image for that show, show a default image
            cell.showPosterImageView.image = UIImage(named: "defaultImageIngresse")
            cell.imageLoadingIndicator.stopAnimating() //Stop the loading indicator once the image has been loaded.
        }
        
        //Variable that will be used to display the genre
        var genreText: String
        
        //If there is a genres array available, show the first one
        if (!showToDisplay.genre.isEmpty){
            genreText = showToDisplay.genre[0]
        } else { //If not, show a message of unavailability
            genreText = "Genre Unavailable"
        }
        
        //Configure the title and genre labels
        cell.showTitleLabel.text = showToDisplay.name
        cell.showGenreLabel.text = genreText
        return cell
    }

    // MARK: Delegate functions
    
    //Handles the success of the request and parser
    func didLoadShows(Shows: [Show]) {
        showsArray = Shows
        //In case nothing was found, call a function to show a "nothing found" alert
        if (showsArray!.count < 1) {
            showNotFoundAlert()
        }
    }
    
    //Error handler. In case there is an error in the request, save the error message and call an error alert function
    func didFailToLoadShows(withError error: Error) {
        errorMessage = error.localizedDescription
        showErrorAlert()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! detailsViewController
        let cell = sender as! showCollectionViewCell
        var selectedIndexPath = self.collectionView?.indexPath(for: cell)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Results"

        //Getting the show that was selected and its poster
        let selectedShow: Show = showsArray![(selectedIndexPath?.row)!]
        let showImage = cell.showPosterImageView.image
        
        destination.showImage = showImage!
        destination.selectedShow = selectedShow
        navigationItem.backBarButtonItem = backItem
    }
    
    
    // MARK: Alert Handling
    
    //In case the search did not return any shows, display an alert to the user.
    @IBAction func showNotFoundAlert(){
        let alert = UIAlertController(title: "Nothing found", message: "Your search for \(searchTerm) found nothing.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Back", comment: "Default action"), style: .default, handler: { _ in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //In case there happened an error in the request, show an alert with the error message to the user.
    @IBAction func showErrorAlert(){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Back", comment: "Default action"), style: .default, handler: { _ in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
