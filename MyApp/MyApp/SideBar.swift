//
//  SideBar.swift
//  MyApp
//
//  Created by Erencan Erel on 26.06.2023.
//

import SwiftUI

struct MenuListItem : Identifiable{
    let id = UUID()
    let name : String
    let icon : String
    var content : [MenuListItem]?
}
//MARK MenuList Items
let BookLibrary = MenuListItem(name: "Book Library", icon: "books.vertical.fill", content: [MenuListItem(name: "All", icon: "books.vertical.fill"),MenuListItem(name: "Whishlist", icon: "book")])
let MovieLibrary = MenuListItem(name: "Movie Library", icon: "film.stack", content: [MenuListItem(name: "Watched", icon: "list.and.film"),MenuListItem(name: "Watch List", icon: "film")])
let Investing = MenuListItem(name : "Investing", icon: "banknote",content : [
    MenuListItem(name: "Stocks", icon: "dollarsign.circle"),MenuListItem(name: "Gold", icon: "case"),MenuListItem(name: "Crypto", icon: "lock")
])
let ShoppingList = MenuListItem(name: "Shopping List", icon: "cart")
let TodoList = MenuListItem(name: "To Do", icon: "list.bullet.clipboard")
var bagContents = [TodoList,ShoppingList,Investing,BookLibrary,MovieLibrary]


struct SideBar: View {
    @Binding var isSidebarVisible : Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    
    var body: some View {
        ZStack{
            GeometryReader{
                _ in EmptyView()
            }.background(.black.opacity(0.6))
                .opacity(isSidebarVisible ? 1 : 0)
                .animation(.easeOut.delay(0.2), value: isSidebarVisible)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
            content
        }.edgesIgnoringSafeArea(.all)
    }
    var content : some View {
        HStack(alignment: .top){
                VStack{
                    persona.padding(.top,40)
                    menuList
                    actionsPanel
                }.background(Color(UIColor.systemBackground))
            .frame(width: sideBarWidth)
            .offset(x:isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
    }
    var persona : some View{
        HStack(alignment: .top){
            Image("erencan_erel").resizable().cornerRadius(25).padding(10)
                    .scaledToFill().frame(width: 100, height: 100)
            VStack(alignment: .leading){
                Text("Erencan Erel").font(.title2.bold())
                Text("Computer Engineer").font(.system(size: 14))
            }.padding(.top,20)
            Spacer()
        }
    }
    var menuList: some View{
        List(bagContents, children: \.content) {
            row in
            Image(systemName: row.icon)
            Text(row.name).font(.title3)
        }
    }
    var actionsPanel : some View{
        HStack(alignment: .center){
            Button(action: {}){
                HStack{
                    Image(systemName: "gear")
                    Text("Settigns").font(.title3).padding(.horizontal, 8)
                        .cornerRadius(8)
                }
            }.buttonStyle(.borderedProminent)
            Button(action: {}){
                HStack{
                    Image(systemName: "log.off")
                    Text("Log Out").font(.title3).padding(.horizontal, 8)
                        .cornerRadius(8)
                }
            }.buttonStyle(.bordered)
        }.padding(.bottom,40).padding(.top,20)
    }
}
struct SideBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SideBar(isSidebarVisible: .constant(true))
    }
}
