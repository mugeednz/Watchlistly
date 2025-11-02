//
//  Downloader.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 29.10.2025.
//

import Foundation

class Downloader {
    
    func filmleriIndir(seacrh: String, completion: @escaping(Result <[Film]?, DownloaderError>)-> Void) {
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(seacrh)&apikey=f23bd573") else {
            return completion(.failure(.yanlisURL))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            guard let filmCevabi = try? JSONDecoder().decode(GelenFilmler.self, from: data) else {
                
                return completion(.failure(.veriIslenmedi))
            }
            completion(.success(filmCevabi.filmler))
        }.resume()
    }
    
    
    
    
    func filmDetayiniindir(imdbId: String, completion: @escaping (Result<FilmDetay, DownloaderError>) -> Void) {
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=f23bd573") else {
            return completion(.failure(.yanlisURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            
            guard let gelenFilmDetayi = try? JSONDecoder().decode(FilmDetay.self, from: data) else {
                return completion(.failure(.veriIslenmedi))
            }
            completion(.success(gelenFilmDetayi))
        }.resume()
    }
}

enum DownloaderError: Error {
    case yanlisURL
    case veriGelmedi
    case veriIslenmedi
}
