//
//  MovieListViewModel.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation

@MainActor
final class MovieListViewModel {
    
    weak var view: MovieListViewProtocol?
    private let repository: MovieRepositoryProtocol
    private var page: Int = 1
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovies(nextPage: Bool = false) {
        view?.showLoading()
        page = nextPage ? page + 1 : 1
        Task {
            do {
                let movies = try await repository.fetchMovies(page: page)
                view?.renderEmptyView(render: false)
                view?.showMovies(movies: movies.results)
            } catch {
                view?.renderEmptyView(render: true)
            }
            view?.stopLoading()
        }
    }
}
