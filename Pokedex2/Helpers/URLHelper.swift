//
//  URLHelper.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 10/07/2021.
//

import Foundation
class URLHelper {
    static let shared = URLHelper()
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
