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

    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var premiereDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var showImage = UIImage()
    
    var selectedShow: Show? {
        didSet {
            self.view.reloadInputViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showTitleLabel.text = selectedShow?.name
        self.navigationItem.title = selectedShow?.name
        
        showPosterImageView.image = showImage
        
        var genresText: String = "Genres:"
        
        selectedShow?.genre.forEach{ genre in
                genresText += "\n\(genre)"
        }
        
        genresLabel.text = genresText
        
        var premiereDateText: String
        if (selectedShow?.premiereDay != "Premiere Day Unavailable"){
            premiereDateText = "Premiered on:\n\(selectedShow!.premiereDay)"
        } else {
            premiereDateText = "Premiere date not available"
        }
        premiereDateLabel.text = premiereDateText
        
        let newSummary = selectedShow!.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        
        summaryLabel.numberOfLines = 0
        summaryLabel.text = "Summary:\n\(newSummary)"
        summaryLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}