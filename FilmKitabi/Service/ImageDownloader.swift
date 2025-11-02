//
//  ImageDownloader.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 2.11.2025.
//

import Foundation

class ImageDownloader : ObservableObject {
    
    @Published var indirilenGorsel : Data?
    
    func gorselIndir(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.indirilenGorsel = data
            }
        }.resume()
    }
    
    
}
