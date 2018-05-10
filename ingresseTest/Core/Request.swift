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
        
        let requestURL = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        
        let p = Parser()
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let heroesArray = p.parseInfo(response: JSON)
                self.delegate?.didLoadShows(Shows: heroesArray)
            case .failure(let error):
                self.delegate?.didFailToLoadShows(withError: error)
            }
        }
    }
}
