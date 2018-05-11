//
//  parser.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/10/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import Foundation

class Parser {
    
    func parseInfo(response: Any) -> [Show]{
        let JSONresponse = response as? [[String : Any]]
        
        var showsArray = [Show]()
        
        JSONresponse?.forEach { item in
            
            //Colects information of each show
            let show = item["show"] as? [String: Any]
            
            let name = show!["name"] as? String
            let premiereDay = show!["premiered"] as? String
            let description = show!["summary"] as? String
            let genres = show!["genres"] as? [String]
            
            let images = show!["image"] as? [String: Any]
            var imagePath = String()
            
            if (images != nil) {
                imagePath = images!["medium"] as! String
            } else {
                imagePath = "image404"  //In case there is no image available, set this as a flag to show the default image
            }
            
            //Create a "show" object
            let finalShow = Show(name: name!,
                            genre: genres!,
                            desc: description ?? "No description Available",
                            premiereDay: premiereDay ?? "Premiere Day Unavailable",
                            thumbPath: imagePath)
            
            //Save this object in an array of objects
            showsArray.append(finalShow)
        }
    return showsArray
    }
}
