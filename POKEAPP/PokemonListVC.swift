//
//  ViewController.swift
//  POKEAPP
//
//  Created by Phincon on 21/08/21.
//

import UIKit

class PokemonListVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vm = ListPokemonVM()
    var pokemonList: [Pokemons]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func setupView(){
        tableView.register(UINib(nibName: "PokemonListCell", bundle: nil), forCellReuseIdentifier: "PokemonListCell")
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.9176470588, blue: 0.8392156863, alpha: 1)
    }
    
    func fetchData(){
        let pokemon = CoreDataManager.sharedManager.fetchAllPersons()
        
        if pokemon != [] {
            pokemonList = pokemon
            tableView.reloadData()
        } else {
            vm.showError.bind { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(with: error)
                    self.tableView.reloadData()
                }
            }
            vm.listPokemonData.bind { [weak self] pokemon in
                guard let self = self else { return }
                self.pokemonList = pokemon
                self.tableView.reloadData()
            }
            vm.listPokemon()
        }
    }
}

extension PokemonListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListCell", for: indexPath) as! PokemonListCell
        if let pokemonList = pokemonList {
            cell.setContent(pokemon: pokemonList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PokemonDetailVC()
        vc.pokemon = pokemonList?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

