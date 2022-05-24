//
//  EndpointDefinition.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation
import Alamofire

protocol EndpointDefinition {
    var baseURL: String { get }
    var path: String { get }
    var queryParams: [String: String] { get }
    var method: HTTPMethod { get }
}

extension EndpointDefinition {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var queryParams: [String: String] {
        return [:]
    }
}
