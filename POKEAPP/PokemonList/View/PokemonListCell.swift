//
//  PokemonListCell.swift
//  POKEAPP
//
//  Created by Phincon on 22/08/21.
//

import UIKit
import SkeletonView

class PokemonListCell: UITableViewCell {

    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let pokemon = CoreDataManager.sharedManager.fetchAllPersons()
        
        if pokemon == [] {
            [pokemonImg, pokemonName].forEach {
                $0?.showGradientSkeleton()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(pokemon detail: Pokemons){
        pokemonName.text = detail.name
        pokemonImg.image = UIImage(data: detail.image!)
        hideAnimation()
    }
    
    func hideAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            [self.pokemonImg, self.pokemonName].forEach {
                $0?.hideSkeleton()
            }
        }
    }
    
}
