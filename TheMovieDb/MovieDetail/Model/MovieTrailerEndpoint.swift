//
//  MovieTrailerEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import Foundation
import Alamofire

struct MovieTrailerEndpoint: EndpointDefinition {
   
    let movieId: Int
    
    var path: String {
        return "movie/\(movieId)/videos"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
