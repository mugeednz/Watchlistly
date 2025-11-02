//
//  FilmDetayViewModel.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 2.11.2025.
//

import Foundation
import SwiftUI

class FilmDetayViewModel : ObservableObject {
    
    @Published var filmDetayi : DetayViewModel?
    
    let downloader = Downloader()
    
    
    func filmDetaylariniAl(imdbId: String) {
        downloader.filmDetayiniindir(imdbId: imdbId) { (sonuc) in
            switch sonuc {
            case .failure(let hata) :
                print(hata)
            case .success(let filmDetay):
                DispatchQueue.main.async {
                    self.filmDetayi = DetayViewModel(detay: filmDetay)
                }
            }
        }
        
    }
    
}


struct DetayViewModel {
    
    let detay : FilmDetay
    
    var title : String {
        detay.title
    }
    var poster : String {
        detay.poster
    }
    var year : String {
        detay.year
    }
    var imdbId : String {
        detay.imdbId
    }
    var director : String {
        detay.director
    }
    var writer : String {
        detay.writer
    }
    var awards : String{
        detay.awards
    }
    var plot : String {
        detay.plot
    }
}
