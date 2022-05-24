//
//  MoviesForActorRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

protocol MoviesForActorRepositoryProtocol: AnyObject {
    func fetchMoviesForActor(actorId: Int) async throws -> MoviesForActorModel
}

final class MoviesForActorRepository: MoviesForActorRepositoryProtocol {
    
    let api = RestApi()
    
    func fetchMoviesForActor(actorId: Int) async throws -> MoviesForActorModel {
        let endpoint = MoviesForActorEndpoint(actorId: actorId)
        return try await api.request(endpoint: endpoint)
    }
}
