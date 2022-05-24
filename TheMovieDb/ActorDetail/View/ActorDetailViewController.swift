//
//  ActorDetailViewController.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 20-05-22.
//

import Foundation
import UIKit

protocol ActorDetailViewProtocol: AnyObject {
    func showActorDetail(actor: ActorModel)
    func showMoviesForActor(movies: [MovieModel])
}

class ActorDetailViewController: UIViewController {
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let actorDetailViewModel: ActorDetailViewModel
    var actor: ActorModel
    var moviesForActor: [MovieModel] = []
    
    init(actor: ActorModel, actorDetailViewModel: ActorDetailViewModel) {
        self.actor = actor
        self.actorDetailViewModel = actorDetailViewModel
        super.init(nibName: "ActorDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
        fetchActorDetailAndActorMovies()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "MovieForActorCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieForActorCell")
    }
    
    private func setupView() {
        navigationItem.title = "Actor Detail"
       
        actorImage.kfSetImage(for: actor.profileUrl)
        actorImage.layer.cornerRadius = 8
        actorName.text = actor.name
        biographyLabel.text = actor.biography
        birthdayLabel.text = actor.birthday
        placeOfBirthLabel.text = actor.place_of_birth
    }
    
    private func fetchActorDetailAndActorMovies() {
        if let actorId = actor.id {
            actorDetailViewModel.fetchActorDetail(actorId: actorId)
            actorDetailViewModel.fetchMoviesForActor(actorId: actorId)
        }
    }
}

extension ActorDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesForActor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieForActorCell", for: indexPath) as? MovieForActorCell else {
            return UICollectionViewCell()
        }
        let movie = moviesForActor[indexPath.row]
        cell.movieImage.kfSetImage(for: movie.posterUrl)
        cell.movieTitle.text = movie.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = moviesForActor[indexPath.row]
        let movieDetailViewModel = MovieDetailViewModel(movieDetailRepository: MovieDetailRepository(),
                                                        creditsRepository: CreditsRepository())
        let movieDetailViewController = MovieDetailViewController(movie: movie, movieDetailViewModel: movieDetailViewModel)
        movieDetailViewModel.view = movieDetailViewController
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 172, height: 320)
    }
}

extension ActorDetailViewController: ActorDetailViewProtocol {
    func showActorDetail(actor: ActorModel) {
        self.actor = actor
        self.setupView()
    }
    
    func showMoviesForActor(movies: [MovieModel]) {
        moviesForActor = movies
        collectionView.reloadData()
    }
}
