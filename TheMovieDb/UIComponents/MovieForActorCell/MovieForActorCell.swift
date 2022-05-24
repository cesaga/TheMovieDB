//
//  MovieForActorCell.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 20-05-22.
//

import Foundation
import UIKit

class MovieForActorCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
    }
}
