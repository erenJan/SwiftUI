//
//  ContentView.swift
//  MyApp
//
//  Created by Erencan Erel on 26.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isSideBarOpened = false
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
                    List{
                        
                    }.navigationTitle("Home")
                }
            }
            
            SideBar(isSidebarVisible: $isSideBarOpened)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
