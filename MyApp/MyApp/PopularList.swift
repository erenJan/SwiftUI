//
//  PopularList.swift
//  MyApp
//
//  Created by Erencan Erel on 26.06.2023.
//

import Foundation

//MARK: TMDB API KEYS
let headers = [
  "accept": "application/json",
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkY2E5NjBmZTAyZDdkZjRiY2JkYmI3MGVlZGM0NWM4MyIsInN1YiI6IjY0OTk4NWQ5NjJmMzM1MDBlOTEzNzc3NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.69TozLy4VBKZ6yyPjbLUQvhJ-Z515snq4VgnQdWBtBE"
]

//MARK: GENRES
let genres =  [
    28: "Action",
    12:"Adventure",
    16:"Animation",
    35 : "Comedy",
    80: "Crime",
    99 : "Documentary",
    18: "Drame",
    10751 : "Family",
    14 : "Fantasy",
    36:"History",
    27:"Horror",
    10402 : "Music",
    9648 : "Mystery",
    10749 : "Romance",
    878 : "Sci-fi",
    10770 : "TV",
    53 : "Thriller",
    10752 : "War",
    37: "Western"
    ]


struct PopularMoviestResponse: Codable {
    var results: [PopularMoviestList]
}
struct PopularMoviestList : Codable,Identifiable{
    let id : Int
    let adult : Bool
    let backdrop_path : String
    let genre_ids : [Int]
    let title : String
    let vote_average : Double
    let poster_path : String
    let release_date : String
}
func getList() async -> [PopularMoviestList]?{
    let decoder = JSONDecoder()
    var result : PopularMoviestResponse
    //MARK tmdb popular movies request
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    let session = URLSession.shared
    
    do{
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        let decodedResponse =  try JSONDecoder().decode(PopularMoviestResponse.self, from: data)
        print(decodedResponse.results)
        return decodedResponse.results
    }catch{
        return [PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023")]
    }
}
func findGenre(id:Int) -> String{
    return genres[id] ?? "unknown"
}










