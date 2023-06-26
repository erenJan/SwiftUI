//
//  MyAppApp.swift
//  MyApp
//
//  Created by Erencan Erel on 26.06.2023.
//

import SwiftUI

@main
struct MyAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(popularMovieList: [PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023")])
        }
    }
}
