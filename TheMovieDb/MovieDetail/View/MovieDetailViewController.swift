//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation
import UIKit
import YoutubePlayer

protocol MovieDetailViewProtocol: AnyObject {
    func showMovieDetail(movie: MovieModel)
    func showActors(actors:[ActorModel])
    func showMovieTrailer(trailer: Video)
}

class MovieDetailViewController: UIViewController {
        
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    let movieDetailViewModel: MovieDetailViewModel
    var movie: MovieModel
    var actors: [ActorModel] = []
    
    init(movie: MovieModel, movieDetailViewModel: MovieDetailViewModel) {
        self.movie = movie
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
        fetchMovieDetailAndCredits()
        navigationItem.title = "Movie Detail"
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "ActorCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "ActorCollectionViewCell")
    }
    
    private func configureView() {
        movieImage.kfSetImage(for: movie.posterUrl)
        movieTitle.text = movie.title
        releaseDate.text = movie.release_date
        runtime.text = movie.prettyRuntime
        movieGenre.text = movie.prettyGenres
        tagline.text = movie.tagline
        movieOverview.text = movie.overview
    }
    
    private func fetchMovieDetailAndCredits() {
        if let movieId = movie.id {
            movieDetailViewModel.fetchMovieDetail(movieId: movieId)
            movieDetailViewModel.fetchCredits(moviId: movieId)
            movieDetailViewModel.fetchMovieTrailer(movieId: movieId)
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell else { return UICollectionViewCell() }
          
        let actor = actors[indexPath.row]
        cell.configureCell(actorName: actor.name ?? "", actorCharacter: actor.character ?? "", actorImageUrl: actor.profileUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actor = actors[indexPath.row]
        let actorDetail = SceneFactory.makeActorDetailViewController(actor: actor)
        navigationController?.pushViewController(actorDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 172, height: 320)
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func showMovieDetail(movie: MovieModel) {
        self.movie = movie
        configureView()
    }
    
    func showActors(actors: [ActorModel]) {
        self.actors = actors
        collectionView.reloadData()
    }
    
    func showMovieTrailer(trailer: Video) {
        youtubeView.loadWith(videoId: trailer.key ?? "", playerVars: ["playsinline" : 1])
    }
}
