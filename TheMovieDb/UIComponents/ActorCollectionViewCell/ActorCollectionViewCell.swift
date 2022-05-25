//
//  ActorCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 19-05-22.
//

import Foundation
import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorCharacter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(actorName: String, actorCharacter: String, actorImageUrl: URL) {
        self.actorName.text = actorName
        self.actorCharacter.text = actorCharacter
        actorImage.kfSetImage(for: actorImageUrl)
    }

    private func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
    }
}
