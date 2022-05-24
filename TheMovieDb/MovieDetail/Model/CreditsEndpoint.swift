//
//  CreditsEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

struct CreditsEndpoint: EndpointDefinition {
   
    let movieId: Int
    
    var path: String {
        return "movie/\(movieId)/credits"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
