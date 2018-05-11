//
//  request.swift
//  ingresseTest
//
//  Created by Matheus Queiroz on 5/10/18.
//  Copyright © 2018 mattcbr. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestDelegate: class{
    func didLoadShows(Shows: [Show])
    func didFailToLoadShows(withError error: Error)
}

class Request {
    
    weak var delegate: RequestDelegate?
    
    func requestInfo(searchTerm: String) {
        
        //Makes a request with the searched term
        let requestURL = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        
        let p = Parser()
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):    //In case it succeds, it parses the received information and returns it to the shows collection view
                let heroesArray = p.parseInfo(response: JSON)
                self.delegate?.didLoadShows(Shows: heroesArray)
            case .failure(let error):   //In case of failure, return the error to the error handler in the shows collection view
                self.delegate?.didFailToLoadShows(withError: error)
            }
        }
    }
}
