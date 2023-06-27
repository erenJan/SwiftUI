//
//  ContentView.swift
//  MyApp
//
//  Created by Erencan Erel on 26.06.2023.
//

import SwiftUI



struct ContentView: View {
    @State private var isSideBarOpened = false
    @State private var activeList = "MovieListAll"
    @State public var popularMovieList : [PopularMoviestList]?
    
    @State public var movieSheet = false
    @State public var currentMovie : PopularMoviestList
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack(alignment: .center){
                    Button{
                        isSideBarOpened.toggle()
                    }label: {
                        Image(systemName: "line.3.horizontal").resizable().scaledToFit().frame(maxWidth: 30)
                    }
                }.padding(.leading,20).padding(.bottom,0)
                NavigationView{
                    switch activeList{
                    case "TodoList":
                        List{
                            
                        }.navigationTitle("TodoList")
                    case "ShoppingList":
                        List{
                            
                        }.navigationTitle("ShoppingList")
                    case "FinanceOverView":
                        List{
                            
                        }.navigationTitle("FinanceOverView")
                    case "FinanceStoks":
                        List{
                            
                        }.navigationTitle("FinanceStoks")
                    case "FinanceGold":
                        List{
                            
                        }.navigationTitle("FinanceGold")
                    case "FinanceCrypto":
                        List{
                            
                        }.navigationTitle("FinanceCrypto")
                    case "MovieListAll":
                        ScrollView(.vertical,showsIndicators: false){
                            VStack(){
                                NavigationView{
                                    VStack{
                                        ScrollView(.horizontal,showsIndicators: false){
                                            HStack{
                                                ForEach(popularMovieList!,id: \.id) { movie in
                                                    PosterView(movie: movie)
                                                }
                                            }
                                        }.frame(height: 150)
                                    }.padding(.top).navigationTitle("Up Coming")
                                }
                                    VStack(alignment: .leading,spacing: 16){
                                        Text("Recently Watched").font(.title).bold()
                                        ForEach(popularMovieList!,id: \.id) { movie in
                                            RecentlyWatched(movie:movie)
                                                .gesture(TapGesture().onEnded {
                                                    movieSheet = true
                                                    currentMovie = movie
                                                })
                                        }
                                    }
                            }
                        }.frame(maxHeight: .infinity)
                        .task {
                            if(popularMovieList!.count == 1){
                                popularMovieList = await getList()!
                            }
                        }.sheet(isPresented: $movieSheet) {
                            MovieSheet(movie:currentMovie)
                        }
                    
                            
                    case "MovieListWatched":
                        List{
                            
                        }.navigationTitle("MovieListWatched")
                    case "MovieListWhish":
                        List{
                            
                        }.navigationTitle("MovieListWhish")
                    case "BookListAll":
                        List{
                            
                        }.navigationTitle("BookListAll")
                    case "BookListOwned":
                        List{
                            
                        }.navigationTitle("BookListOwned")
                    case "BookListWhish":
                        List{
                            
                        }.navigationTitle("BookListWhish")
                    default :
                        AnyView(EmptyView())
                    }
                }
            }
            SideBar(isSidebarVisible: $isSideBarOpened,currentList : $activeList)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(popularMovieList: [PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023")],currentMovie: PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023"))
    }
}
struct RecentlyWatched : View {
    let movie : PopularMoviestList
    @State var initialImage = UIImage()
    var body : some View{
        VStack{
            HStack(alignment: .top){
                Image(uiImage: self.initialImage)
                    .resizable()
                    .cornerRadius(8)
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight: 100, alignment: .center)
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
                VStack(alignment: .leading){
                    Text(movie.title).font(.title2).bold()
                    HStack{
                        ForEach(movie.genre_ids,id: \.self){movieId in
                            Button(action: {}){
                                HStack{
                                    Text(findGenre(id: movieId)).font(.system(size: 8)).monospaced()                                    .cornerRadius(8)
                                }
                            }.buttonStyle(.bordered)
                        }
                    }
                    Spacer()
                    HStack{
                        Button(action: {}){
                            HStack{
                                Text(movie.release_date).font(.system(size: 10)).monospaced()
                                    .cornerRadius(8)
                            }
                        }.buttonStyle(.borderedProminent)
                        let stars = HStack(spacing: 0) {
                            ForEach(0..<5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                            }
                        }
                        
                        stars.overlay(
                            GeometryReader { g in
                                let width = (movie.vote_average/2) / CGFloat(5) * g.size.width
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: width)
                                        .foregroundColor(.blue)
                                }
                            }
                                .mask(stars)
                        )
                        .foregroundColor(.gray)
                    }
                }
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}
struct PosterView: View {
    let movie: PopularMoviestList
    @State var initialImage = UIImage()
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Image(uiImage: self.initialImage)
                .resizable()
                .cornerRadius(16)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 160, maxWidth: 160, minHeight: 200, maxHeight: 200, alignment: .center)
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
            VStack{
                Button(action: {}){
                    HStack{
                        Text(String(movie.vote_average)).font(.system(size: 12)).bold()
                            .cornerRadius(8).padding(0)
                    }
                }.buttonStyle(.borderedProminent).tint(.blue).padding(0)
                
            }.frame(width: 100, height: 200, alignment: .topTrailing).padding(.top,10).padding(.trailing,20)
                
            
        }
    }
}
