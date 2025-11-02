import SwiftUI

struct DetayView: View {
    let imdbId: String
    @ObservedObject var filmDetayViewModel = FilmDetayViewModel()
    
    var body: some View {
        ZStack {
            // Arka plan: film posteri üzerine blur efekti
            if let posterURL = filmDetayViewModel.filmDetayi?.poster, !posterURL.isEmpty {
                OzelImage(url: posterURL)
                    .blur(radius: 25)
                    .opacity(0.4)
                    .ignoresSafeArea()
            } else {
                Color(.systemBackground).ignoresSafeArea()
            }

            if let detay = filmDetayViewModel.filmDetayi {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // --- Poster ---
                        OzelImage(url: detay.poster)
                            .frame(width: UIScreen.main.bounds.width * 0.7,
                                   height: UIScreen.main.bounds.height * 0.35)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .padding(.top)
                        
                        // --- Film Bilgileri Kartı ---
                        VStack(alignment: .leading, spacing: 12) {
                            Text(detay.title)
                                .font(.title)
                                .bold()
                                .foregroundColor(.primary)
                            
                            HStack {
                                Label(detay.year, systemImage: "calendar")
                                Label(detay.director, systemImage: "person.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Label(detay.writer, systemImage: "pencil")
                                Label(detay.awards, systemImage: "trophy.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)))
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 3)
                        .padding(.horizontal)
                        
                        // --- Plot ---
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📖 Özet")
                                .font(.headline)
                                .padding(.bottom, 2)
                            Text(detay.plot)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                        .padding(.horizontal)
                        
                        Spacer(minLength: 30)
                    }
                }
                .navigationTitle(detay.title)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                // --- Yükleniyor Durumu ---
                ProgressView("Yükleniyor...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.2)
            }
        }
        .onAppear {
            filmDetayViewModel.filmDetaylariniAl(imdbId: imdbId)
        }
    }
}

#Preview {
    DetayView(imdbId: "test")
}
