//
//  MovieDetailEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

struct MovieDetailEndpoint: EndpointDefinition {
   
    let movieId: Int
    
    var path: String {
        return "movie/\(movieId)"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
