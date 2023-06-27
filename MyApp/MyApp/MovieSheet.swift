//
//  MovieSheet.swift
//  MyApp
//
//  Created by Erencan Erel on 27.06.2023.
//

import SwiftUI

struct MovieSheet: View {
    let movie : PopularMoviestList
    @State var initialImage = UIImage()
    var body: some View {
        VStack{
            Image(uiImage: self.initialImage)
                .resizable()
                .cornerRadius(8)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 300, maxHeight: 300, alignment: .center)
                .onAppear {
                    guard let url = URL(string: "https://image.tmdb.org/t/p/original" + self.movie.poster_path) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        guard let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.initialImage = image
                        }
                        
                    }.resume()
                }
            Text(movie.title).font(.title).bold().monospaced()
        }
    }
}

struct MovieSheet_Previews: PreviewProvider {
    static var previews: some View {
        MovieSheet(movie: PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023"))
    }
}
