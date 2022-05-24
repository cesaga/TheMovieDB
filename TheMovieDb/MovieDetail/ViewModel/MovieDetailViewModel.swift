//
//  MovieDetailViewModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 20-05-22.
//

import Foundation

@MainActor
final class MovieDetailViewModel {
    
    weak var view: MovieDetailViewProtocol?
    private let movieDetailRepository: MovieDetailRepositoryProtocol
    private let creditsRepository: CreditsRepositoryProtocol
    
    init(movieDetailRepository: MovieDetailRepositoryProtocol, creditsRepository: CreditsRepositoryProtocol) {
        self.movieDetailRepository = movieDetailRepository
        self.creditsRepository = creditsRepository
    }
    
    func fetchMovieDetail(movieId: Int) {
        Task {
            do {
                let movieDetail = try await movieDetailRepository.fetchMovieDetail(movieId: movieId)
                view?.showMovieDetail(movie: movieDetail)
            }
        }
    }
    

    func fetchCredits(moviId: Int) {
        Task {
            do {
                let credits = try await creditsRepository.fetchCredits(movieId: moviId)
                view?.showActors(actors: credits.cast)
            }
        }
    }
    
    func fetchMovieTrailer(movieId: Int) {
        Task {
            do {
                let movieVideos = try await movieDetailRepository.fetchMovieTrailer(movieId: movieId)
                for video in movieVideos.results {
                    if video.type == "Trailer" {
                        view?.showMovieTrailer(trailer: video)
                    }
                }
            }
        }
    }
}
