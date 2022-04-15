//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Carlos Wilson on 14/10/21.
//

import UIKit
import Alamofire
import AlamofireImage

class PokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var pokemonsArray: Array<Pokemon> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        Network.getFromServer {
            result in
            
            switch(result) {
                case .success(let pokemons):
                    print(pokemons.count)
                    self.title = "Pokemons"
                    self.pokemonsArray = pokemons
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        // Set the pokemon name
        cell.pokemonName.text = self.pokemonsArray[indexPath.row].name
        
        // Set the pokemon image
        let url = URL(string: self.pokemonsArray[indexPath.row].image)
        cell.pokemonImage.af.setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        return height/3
    }
}


