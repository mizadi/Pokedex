//
//  PokemonCell.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
import UIKit
class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivMain.backgroundColor = .white
        ivMain.image = nil
        ivMain.cancelImageLoad()
    }
}
