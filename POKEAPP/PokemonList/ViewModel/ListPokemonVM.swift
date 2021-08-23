//
//  ListPokemon.swift
//  POKEAPP
//
//  Created by Phincon on 21/08/21.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

class ListPokemonVM {
    
    var listPokemonData: Bindable<[Pokemons]?> = Bindable([])
    var showError: Bindable<AlertError?> = Bindable(nil)
    
    func listPokemon(){
        APIServices.shared.request(url: Constant.baseUrl + "pokemon", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self](listPokemon: ListPokemonModel?, _ errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            
            if let _ = error {
                self.showErrors(title: "ERROR", description: "Please check your connection")
            } else if let errorModel  = errorModel  {
                self.showErrors(title: "Error", description: errorModel.status_message ?? "")
            } else {
                CoreDataManager.sharedManager.DeleteAllData()
                if let listPokemon = listPokemon {
                    for data in listPokemon.results ?? [] {
                        if let name = data.name {
                            self.pokemonDetail(pokemon: name)
                        }
                    }
                }
            }
        }
    }
    
    func pokemonDetail(pokemon name: String){
        APIServices.shared.request(url: Constant.baseUrl + "pokemon-form/\(name)", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self](listPokemon: PokemonDetail?, _ errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            
            if let _ = error {
                self.showErrors(title: "ERROR", description: "Please check your connection")
            } else if let errorModel  = errorModel  {
                self.showErrors(title: "Error", description: errorModel.status_message ?? "")
            } else {
                
                if let listPokemon = listPokemon {
                    
                    guard let url = URL(string: "\(listPokemon.sprites.frontDefault)") else { return }
                    let pokemonImgUrl = ImageResource(downloadURL: url)
                    
                    KingfisherManager.shared.retrieveImage(with: pokemonImgUrl, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                        
                        
                        if let convertUrlToImage = image?.pngData(), let pokemon = CoreDataManager.sharedManager.insertPerson(name: listPokemon.pokemon.name, image: convertUrlToImage){
                            
                            self.listPokemonData.value?.append(pokemon)
                            
                        }
                    })
                    
                }
            }
        }
    }
    
    func showErrors(title: String, description: String){
        let error = AlertError(title: title, description: description, action: AlertAction(title: "OK", handle: {
            self.listPokemon()
        }))
        self.showError.value = error
    }
}
