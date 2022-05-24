//
//  ActorDetailRepository.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 23-05-22.
//

import Foundation

protocol ActorDetailRepositoryProtocol: AnyObject {
    func fetchActorDetail(actorId: Int) async throws -> ActorModel
}

final class ActorDetailRepository: ActorDetailRepositoryProtocol {
    
    let api = RestApi()
    
    func fetchActorDetail(actorId: Int) async throws -> ActorModel {
        let endpoint = ActorDetailEndpoint(actorId: actorId)
        return try await api.request(endpoint: endpoint)
    }
}
