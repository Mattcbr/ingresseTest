//
//  detailsViewController.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/10/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class detailsViewController: UIViewController {

    // MARK: Outlets and Vars
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var premiereDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    
    var showImage = UIImage()
    var selectedShow: Show? {
        didSet {
            self.view.reloadInputViews()
        }
    }
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        //Showing the selected show name in the label and in the navigation title
        showTitleLabel.text = selectedShow?.name
        self.navigationItem.title = selectedShow?.name
        
        //Defining the show poster
        showPosterImageView.image = showImage
        
        //This will be used to show all the genres of the show
        var genresText: String = "Genres:"
        
        //If there is an array of genres, add each of the genres to the genres string
        if(!selectedShow!.genre.isEmpty) {
            selectedShow?.genre.forEach{ genre in
                    genresText += "\n\(genre)"
            }
        } else {    //If there's no genres, show an unavailability message.
            genresText = "Genre unavailable"
        }
        
        //Show the genres in a label
        genresLabel.text = genresText
        
        //This will be used to show the premiere date of the show
        var premiereDateText: String
        if (selectedShow?.premiereDay != "Premiere Day Unavailable"){
            premiereDateText = "Premiered on:\n\(selectedShow!.premiereDay)"
        } else {
            premiereDateText = "Premiere date not available"
        }
        premiereDateLabel.text = premiereDateText
        
        //This removes the HTML Markup that comes in the summary part in the JSON
        let newSummary = selectedShow!.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        //This resizes the summary label and shows the summary in the label
        summaryLabel.numberOfLines = 0
        summaryLabel.text = "Summary:\n\(newSummary)"
        summaryLabel.sizeToFit()
        
        detailsView.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
