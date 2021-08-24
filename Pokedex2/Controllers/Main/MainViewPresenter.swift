//
//  MainViewPresenter.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
import RxSwift
import CoreData
protocol MainViewPresenterDelegate {
    func finishedPullPokemon()
    func requestWithPokemonResult(_ pokemon: PokemonContainerResponse)
    func reloadDataAtIndex(_ sprite: String, _ index: Int)
}
class MainViewPresenter {
    
    var delegate: MainViewPresenterDelegate
    
    var isRequesting = false
    
    private var disposeBag = DisposeBag()
    
    init(_ delegate: MainViewPresenterDelegate) {
        self.delegate = delegate
    }
    
//    func pullPokemons() {
//        APIHandler.shared.pullPokemons().observe(on: MainScheduler.instance)
//            .subscribe { result in
//                if result.count > 0 {
//                    // Enter to local data base + Show on screen
//                    self.delegate.requestWithPokemonResult(result)
//                }
//            } onError: { error in
//                print(error)
//            } onCompleted: {
//                self.delegate.finishedPullPokemon()
//            } .disposed(by: disposeBag)
//    }
    
    func pullSinglePokemon(results: [PokemonResultPage], offset: String) {
        let group = DispatchGroup()
        for (index,poke) in results.enumerated() {
            group.enter()
            //print("pulling with index: \(index + Int(offset)!)")
            self.makeSinglePokemonRequest(url: poke.url) { sprite in
                group.leave()
                self.delegate.reloadDataAtIndex(sprite, index + Int(offset)!)
                //self.cvMain.reloadData()
            }
            
        }
        
    }
    
    func makeSinglePokemonRequest(url: String,completion: @escaping (_ spirte: String) -> Void) {
        NetworkEngine.request(endpoint: PokemonEndPoint.pullSinglePokemon(url: url)) { (result: Result < PokemonSprites, Error > ) in
            switch result {
                case.success(let response):
                    completion(response.frontDefault)
                    //completion(result.frontDefault)
                case.failure(let error):
                    print(error)
            }
        }
    }
//
//    APIHandler.shared.pullSinglePokemon(url).observe(on: MainScheduler.instance)
//        .subscribe { result in
//            completion(result.frontDefault)
//        } onError: { error in
//            print(error)
//        } onCompleted: {
//            self.delegate.finishedPullPokemon()
//        }.disposed(by: disposeBag)
    
    func makePokemonCall() {
        NetworkEngine.request(endpoint: PokemonEndPoint.pullPokemonContainer(limit: "150")) {
            (result: Result < PokemonContainerResponse, Error > ) in
            switch result {
                case.success(let response):
                    self.delegate.requestWithPokemonResult(response)
                case.failure(let error):
                    print(error)
            }
        }
    }
    
    func pullNextBatchOfPokemon(url: String) {
        isRequesting = true
        NetworkEngine.request(endpoint: PokemonEndPoint.pullMorePokemon(url: url)) {
            (result: Result < PokemonContainerResponse, Error > ) in
            switch result {
                case.success(let response):
                    self.delegate.requestWithPokemonResult(response)
                    self.isRequesting = false
                case.failure(let error):
                    print(error)
                    self.isRequesting = false
            }
        }
    }
    
//    func saveToDatabase(_ response: PokemonContainerResponse) {
//        let container = Container(context: DatabaseHelper.sharedInstance.container.viewContext)
//        container.count = response.count
//        container.next = response.next
//        container.previous = response.previous
//        DatabaseHelper.sharedInstance.saveContext()
//    }
    
}
