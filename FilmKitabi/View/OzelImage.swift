//
//  OzelImage.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 2.11.2025.
//

import SwiftUI

struct OzelImage: View {
    
    let url : String
    @ObservedObject var imageDowloader = ImageDownloader()
    
    init(url : String) {
        self.url = url
        self.imageDowloader.gorselIndir(url: self.url)
    }
    
    
    var body: some View {
        if let data = imageDowloader.indirilenGorsel,
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
                .resizable()
        } else {
            return Image("placeholder")
                .resizable()
        }

        
    }
}

#Preview {
    OzelImage(url: "https://m.media-amazon.com/images/M/MV5BNWE5MGI3MDctMmU5Ni00YzI2LWEzMTQtZGIyZDA5MzQzNDBhXkEyXkFqcGc@._V1_SX300.jpg")
}
