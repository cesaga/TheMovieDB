//
//  CreditsModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

struct CreditsModel: Codable {
    let id: Int?
    let cast: [ActorModel]
}

struct ActorModel: Codable {
    let id: Int?
    let name: String?
    let birthday: String?
    let place_of_birth: String?
    let biography: String?
    let profile_path: String?
    let cast_id: Int?
    let character: String?
    
    var profileUrl : URL {
        return URL(string: "\(Constants.imageBaseUrl)\(profile_path ?? "")")!
    }
}
