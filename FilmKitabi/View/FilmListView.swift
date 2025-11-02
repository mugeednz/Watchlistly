//
//  ContentView.swift
//  FilmKitabi
//
//  Created by Müge Deniz on 29.10.2025.
//

import SwiftUI

struct FilmListView: View {
    
    @ObservedObject var filmListeViewModel : FilmListViewModel
    
    @State var aranacakFilm = ""
    
    init() {
        filmListeViewModel = FilmListViewModel()
      
    }
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Film Ara", text: $aranacakFilm) {
                    self.filmListeViewModel
                        .filmAramasi(filmIsmi: aranacakFilm.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? aranacakFilm )
                }.padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    .shadow(radius: 5)
                
                List(filmListeViewModel.filmler, id: \.imdbId) { film in
                    NavigationLink {
                        DetayView(imdbId: film.imdbId)
                    } label: {
                        HStack{
                            OzelImage(url: film.poster)
                                .frame(width: 90, height: 130)
                            
                            VStack(alignment: .leading) {
                                Text(film.title)
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                Text(film.year)
                                    .bold()
                                
                            }
                        }
                    }
                }.navigationTitle(Text("Film List"))
                    .navigationBarTitleDisplayMode(.large)
                    .background(
                        LinearGradient(colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                    )
            }
        }
    }
}

#Preview {
    FilmListView()
}
