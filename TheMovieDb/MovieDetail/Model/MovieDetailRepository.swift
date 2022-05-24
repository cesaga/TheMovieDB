//
//  MovieDetailRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

protocol MovieDetailRepositoryProtocol: AnyObject {
    func fetchMovieDetail(movieId: Int) async throws -> MovieModel
    func fetchMovieTrailer(movieId: Int) async throws -> VideoModel
}

final class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    let api = RestApi()
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieModel {
        let endpoint = MovieDetailEndpoint(movieId: movieId)
        return try await api.request(endpoint: endpoint)
    }
    
    func fetchMovieTrailer(movieId: Int) async throws -> VideoModel {
        let endpoint = MovieTrailerEndpoint(movieId: movieId)
        return try await api.request(endpoint: endpoint)
    }
}

