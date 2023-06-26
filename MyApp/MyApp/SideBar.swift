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
    var bgColor : Color = Color(.init(red:52/255,green: 70/255,blue: 182/255,alpha:1))
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
            ZStack(alignment: .top){
                bgColor
                menuList
            }
            .frame(width: sideBarWidth)
            .offset(x:isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
    }
    var menuList: some View{
        List(bagContents, children: \.content) {
            row in
            Image(systemName: row.icon)
            Text(row.name).font(.title3)
        }.padding(.top,30)
    }
    
}
struct SideBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SideBar(isSidebarVisible: .constant(true))
    }
}
