//
//  CreditsRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

protocol CreditsRepositoryProtocol: AnyObject {
    func fetchCredits(movieId: Int) async throws -> CreditsModel
}

final class CreditsRepository: CreditsRepositoryProtocol {
    
    let api = RestApi()
    
    func fetchCredits(movieId: Int) async throws -> CreditsModel {
        let endpoint = CreditsEndpoint(movieId: movieId)
        return try await api.request(endpoint: endpoint)
    }
}
