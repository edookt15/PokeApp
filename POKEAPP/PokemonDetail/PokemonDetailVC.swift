//
//  PokemonDetailVC.swift
//  POKEAPP
//
//  Created by Phincon on 23/08/21.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let img = pokemon?.image {
            pokemonImg.image = UIImage(data: img)
            pokemonName.text = pokemon?.name
        }
    }
    
    

}
