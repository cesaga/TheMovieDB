//
//  MoviesForActorEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

struct MoviesForActorEndpoint: EndpointDefinition {
   
    let actorId: Int
    
    var path: String {
        return "person/\(actorId)/movie_credits"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
