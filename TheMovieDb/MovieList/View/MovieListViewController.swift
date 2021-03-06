//
//  MovieListViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieListViewProtocol: AnyObject {
    func showLoading()
    func stopLoading()
    func renderEmptyView(render: Bool)
    func showMovies(movies: [MovieModel])
}

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let movieListViewModel: MovieListViewModel
    var movies: [MovieModel] = []
    
    init(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
        super.init(nibName: "MovieListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        movieListViewModel.fetchMovies()
        navigationItem.title = "Movies"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieCell")
    }
    
    private func showEmptyView() {
        let image = UIImage(named: "emptyView")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        tableView.backgroundView?.contentMode = .center
    }
    
    private func hideEmptyView() {
        tableView.backgroundView = nil
    }
}
    
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.configureCell(movieTitle: movie.title ?? "", posterUrl: movie.posterUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let movieDetailViewController = SceneFactory.makeMovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 3 {
            movieListViewModel.fetchMovies(nextPage: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(145)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func renderEmptyView(render: Bool) {
        
        render ? showEmptyView() : hideEmptyView()
    }

    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showMovies(movies: [MovieModel]) {
        self.movies.append(contentsOf: movies)
        tableView.reloadData()
    }
}
