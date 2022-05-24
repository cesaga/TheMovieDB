//
//  MovieListModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int
    let results: [MovieModel]
}

