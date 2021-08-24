//
//  ViewController.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var cvMain: UICollectionView!
    var presenter: MainViewPresenter!
    var collectionControler: MainCollectionController!
    
    var container: PokemonContainerResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(self)
        let container = DatabaseHelper.sharedInstance.getContainers()
        presenter.makePokemonCall()
        //presenter.pullPokemons()
        initCollectionView()
    }
    func initCollectionView() {
        collectionControler = MainCollectionController([PokemonResultPage](),delegate: self)
        cvMain.delegate = collectionControler
        cvMain.dataSource = collectionControler
    }
    
    
    
}

extension MainViewController: MainViewPresenterDelegate {
    
    func requestWithPokemonResult(_ pokemon: PokemonContainerResponse) {
        var offset = "0"
        if let next = container?.next {
            offset = URLHelper.shared.getQueryStringParameter(url: next, param: "offset")!
        }
        container = pokemon
        saveToDatabase(pokemon)
        collectionControler.setData(pokemon.results)
        cvMain.reloadData()
        presenter.pullSinglePokemon(results: pokemon.results, offset: offset)
        
    }
    
    func reloadDataAtIndex(_ sprite: String, _ index: Int) {
        self.collectionControler.data[index].addSpirte(sprite)
        self.cvMain.reloadItems(at: [IndexPath(row: index, section: 0)])
        if index == collectionControler.data.count - 1 {
            collectionControler.happened = false
        }
    }
    
    func saveToDatabase(_ pokemonContainer: PokemonContainerResponse) {
        let container = Container(context:  DatabaseHelper.sharedInstance.container.viewContext)
        container.count = pokemonContainer.count
        container.next = pokemonContainer.next
        container.previous = pokemonContainer.previous
        for result in pokemonContainer.results {
            let pageResult = ResultPage(context: DatabaseHelper.sharedInstance.container.viewContext)
            pageResult.name = result.name
            pageResult.url = result.url
            container.addToResults(pageResult)
        }
        DatabaseHelper.sharedInstance.saveContext()
    }
    
    func finishedPullPokemon() {
        
    }
    
    //    func requestWithPokemonResult(_ pokemon: [PokemonObject]) {
    //        collectionControler.setData(pokemon)
    //        cvMain.reloadData()
    //        let group = DispatchGroup()
    //        for (index,poke) in pokemon.enumerated() {
    //            group.enter()
    //            print("pulling with index: \(index)")
    //                self.presenter.pullSinglePokemon(poke, index: index) { sprite, index in
    //                    group.leave()
    //                    self.collectionControler.data[index].addSprite(sprite)
    //                    self.cvMain.reloadItems(at: [IndexPath(row: index, section: 0)])
    //                }
    //
    //        }
    //    }
    
    
}

extension MainViewController: MainCollectionControllerDelegate {
    func scrolledToBottom() {
        if let next = container.next {
            presenter.pullNextBatchOfPokemon(url: next)
        }
    }
    
    
}
