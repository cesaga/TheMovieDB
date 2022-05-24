//
//  ActorDetailViewModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 21-05-22.
//

import Foundation

@MainActor
class ActorDetailViewModel {
    
    weak var view: ActorDetailViewProtocol?
    private let actorDetailRepository: ActorDetailRepositoryProtocol
    private let moviesForActorRepository: MoviesForActorRepositoryProtocol
    
    init(actorDetailRepository: ActorDetailRepositoryProtocol, moviesForActorRepository: MoviesForActorRepositoryProtocol) {
        self.actorDetailRepository = actorDetailRepository
        self.moviesForActorRepository = moviesForActorRepository
    }
    
    func fetchActorDetail(actorId: Int) {
        
        Task {
            do {
                let actorDetail = try await actorDetailRepository.fetchActorDetail(actorId: actorId)
                view?.showActorDetail(actor: actorDetail)
            }
        }
    }
        
    func fetchMoviesForActor(actorId: Int) {
        
        Task {
            do {
                let moviesForActor = try await moviesForActorRepository.fetchMoviesForActor(actorId: actorId)
                view?.showMoviesForActor(movies: moviesForActor.cast)
            }
        }
        
    }
}
