//
//  MovieRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

protocol MovieRepositoryProtocol: AnyObject {
    func fetchMovies(page: Int) async throws -> MovieListModel
}

final class MovieRepository: MovieRepositoryProtocol {
    
    let api = RestApi()
    
    func fetchMovies(page: Int) async throws -> MovieListModel {
        let endpoint = MovieEndpoint(page: page)
        return try await api.request(endpoint: endpoint)
    }
}
