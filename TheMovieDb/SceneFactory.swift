//
//  SceneFactory.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 25-05-22.
//

import Foundation
import UIKit

@MainActor final class SceneFactory {
    
    static func makeMovieListViewController() -> UIViewController {
        
        let movieRepository = MovieRepository()
        let movieListViewModel = MovieListViewModel(repository: movieRepository)
        let movieListViewController = MovieListViewController(movieListViewModel: movieListViewModel)
        movieListViewModel.view = movieListViewController
        return movieListViewController
    }
    
    static func makeMovieDetailViewController(movie: MovieModel) -> UIViewController {
        
        let movieDetailRepository = MovieDetailRepository()
        let creditsRepository = CreditsRepository()
        let movieDetailViewModel = MovieDetailViewModel(movieDetailRepository: movieDetailRepository,
                                                        creditsRepository: creditsRepository)
        let movieDetailViewController = MovieDetailViewController(movie: movie, movieDetailViewModel: movieDetailViewModel)
        movieDetailViewModel.view = movieDetailViewController
        return movieDetailViewController
    }
    
    static func makeActorDetailViewController(actor: ActorModel) -> UIViewController {
        
        let actorDetailRepository = ActorDetailRepository()
        let moviesForActorRepository = MoviesForActorRepository()
        let actorDetailViewModel = ActorDetailViewModel(actorDetailRepository: actorDetailRepository,
                                                        moviesForActorRepository: moviesForActorRepository)
        let actorDetailViewController = ActorDetailViewController(actor: actor, actorDetailViewModel: actorDetailViewModel)
        actorDetailViewModel.view = actorDetailViewController
        return actorDetailViewController
    }
}


