//
//  MoviesForActorModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

struct MoviesForActorModel: Decodable {
    let cast: [MovieModel]
}
