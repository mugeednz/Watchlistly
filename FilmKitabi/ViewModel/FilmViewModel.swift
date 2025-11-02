//
//  FilmListViewModel.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 29.10.2025.
//

import Foundation

class FilmListViewModel : ObservableObject{
    
    @Published var filmler = [FilmViewModel]()
    let downloader = Downloader()
    
    func filmAramasi(filmIsmi: String) {
        downloader.filmleriIndir(seacrh: filmIsmi) { (sonuc) in
            switch sonuc {
            case.failure(let hata):
                print(hata)
                
            case.success(let filmDizisi):
                if let filmDizisi = filmDizisi {
                    DispatchQueue.main.async {
                        self.filmler = filmDizisi.map(FilmViewModel.init)
                    }
                }
            }
        }
    }
}

struct FilmViewModel {
    
    let film : Film
    
    var title : String {
        film.title
    }
    var poster : String {
        film.poster
    }
    var year : String {
        film.year
    }
    var imdbId : String {
        film.imdbId
    }
}


