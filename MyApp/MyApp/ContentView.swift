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
    @State public var popularMovieList : [PopularMoviestList]
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
                        NavigationView{
                            VStack{
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(popularMovieList,id: \.id) { movie in
                                            PosterView(movie: movie)
                                        }
                                    }
                                }.frame(height: 150)
                                Spacer()
                            }.padding(.top,-40)
                        }
                            .navigationBarTitle("Up Coming", displayMode: .large).task {
                                popularMovieList = await getList()!
                              }
                            
//                        List{
//                            ForEach(popularMovieList){
//                                movie in
//                                Text(movie.title)
//                            }
//                        }.navigationTitle("MovieListAll").task {
//                            popularMovieList = await getList()!
//                            print(popularMovieList)
//                          }
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
        ContentView(popularMovieList: [PopularMoviestList(id: 123, adult: true,backdrop_path: "",genre_ids: [1,2,3],title: "deneme",vote_average: 5.5,poster_path: "dene",release_date: "2023")])
    }
}
struct PosterView: View {
    let movie: PopularMoviestList
    @State var initialImage = UIImage()
    var body: some View {
        
        ZStack(alignment: .top) {
            
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
                Text("789")
                
            }.frame(width: 100, height: 200, alignment: .topTrailing).padding(.top,10)
                
            
        }
    }
}
