//
//  MovieEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

struct MovieEndpoint: EndpointDefinition {
    
    let page: Int
    
    var path: String {
        return "movie/popular"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParams: [String : String] {
        return [
            "page": String(page)
        ]
    }    
}
