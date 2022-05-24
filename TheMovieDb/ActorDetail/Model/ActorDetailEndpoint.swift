//
//  ActorDetailEndpoint.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

struct ActorDetailEndpoint: EndpointDefinition {
   
    let actorId: Int
    
    var path: String {
        return "person/\(actorId)"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
