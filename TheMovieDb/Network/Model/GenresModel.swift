//
//  GenresModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 24-05-22.
//

import Foundation

struct GenresModel: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Equatable {
    let id: Int
    let name: String
}
