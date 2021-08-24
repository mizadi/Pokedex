//
//  APIHandler.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
import RxSwift
import Alamofire
class APIHandler {
    
    struct Constants {
        static let limit = "150"
        struct urls {
            static let baseUrl = "https://pokeapi.co/api/v2/"
        }
        struct requestTypes {
            static let pokemon = "pokemon"
        }
        struct httpParameters {
            static let limit = "limit="
        }
        struct RequestHttpType {
            static let get = "GET"
            static let post = "POST"
        }
        struct RequestHeaders {
            static let contentType = "Content-Type"
            static let applicationJSON = "application/json"
        }
    }
    
    static let shared = APIHandler()
    
    func pullPokemons() -> Observable<[PokemonObject]> {
        return Observable<[PokemonObject]>.create { observer in
                    let request = self.buildGetRequest(Constants.urls.baseUrl + Constants.requestTypes.pokemon+"?"+Constants.httpParameters.limit+Constants.limit)
            let alamoRequest = AF.request(request).responseDecodable { (response: DataResponse<ResultContainer,AFError>) in
                switch response.result {
                case .failure(let error):
                    observer.onError(error)
                    print(error)
                case .success(let resultObject):
                    observer.onNext(resultObject.pokemon)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                alamoRequest.cancel()
                observer.onCompleted()
            }
        }
    }
    
    func pullSinglePokemon(_ url: String) -> Observable<PokemonSprites>  {
        return Observable<PokemonSprites>.create { observer in
            let request = self.buildGetRequest(url)
            let alamoRequest = AF.request(request).responseDecodable { (response: DataResponse<PokemonSprites,AFError>) in
                switch response.result {
                case .failure(let error):
                    observer.onError(error)
                    print(error)
                case .success(let resultObject):
                    observer.onNext(resultObject)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                alamoRequest.cancel()
                observer.onCompleted()
            }
        }
    }
    
    func buildGetRequest(_ url: String) -> URLRequest {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = Constants.RequestHttpType.get
        request.timeoutInterval = 20
        request.setValue(Constants.RequestHeaders.applicationJSON, forHTTPHeaderField: Constants.RequestHeaders.contentType)
        return request
    }
}
