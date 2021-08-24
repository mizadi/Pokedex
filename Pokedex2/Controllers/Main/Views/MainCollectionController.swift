//
//  MainCollectionController.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
import UIKit

protocol MainCollectionControllerDelegate {
    func scrolledToBottom()
}

class MainCollectionController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data: [PokemonResultPage]
    
    var delegate: MainCollectionControllerDelegate
    
    var happened = false
    
    init(_ data: [PokemonResultPage], delegate: MainCollectionControllerDelegate) {
        self.data = data
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        if let sprites = data[indexPath.row].sprites, !sprites.isEmpty {
            if let spriteURL = URL(string: sprites[0]) {
                cell.ivMain.loadImage(at: spriteURL)
            }
        }
        //        if let sprites = data[indexPath.row].sprites, !sprites.isEmpty {
        //            if let spriteURL = URL(string: sprites[0]) {
        //                URLSession.shared.dataTask(with: spriteURL) { data, response, error in
        //                    if error == nil {
        //                        if spriteURL.absoluteString == sprites[0] {
        //                            if let data = data {
        //                                DispatchQueue.main.async {
        //                                    cell.ivMain.image = UIImage(data: data)
        //                                }
        //                            }
        //                        }
        //                    }
        //                }.resume()
        //            }
        //        }
        cell.lbTitle.text = data[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.width / 3.5)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //reach bottom
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            if !happened {
                happened = true
                delegate.scrolledToBottom()
            }
        }
    }
    
    func setData(_ data: [PokemonResultPage]) {
        self.data.append(contentsOf: data)
    }
    
    
}
