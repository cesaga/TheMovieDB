//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import Foundation

struct MovieModel: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let genres: [Genre]?
    let runtime: Int?
    let tagline: String?
    
    var posterUrl: URL {
        return URL(string: "\(Constants.imageBaseUrl)\(poster_path ?? "")")!
    }
    
    var prettyGenres: String {
        var result: [String] = []
        for genre in genres ?? [] {
            result.append(genre.name)
        }
        let joinedGenres = result.joined(separator: ", ")
        return joinedGenres
    }
}
