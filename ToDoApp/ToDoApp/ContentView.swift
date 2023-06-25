//
//  ContentView.swift
//  ToDoApp
//
//  Created by Erencan Erel on 25.06.2023.
//

import SwiftUI

struct CheckListItem : Hashable{
    var isChecked : Bool
    var title : String
    var description : String?
    var isRequired : Bool?
}

struct ContentView: View {
    @State private var searchText = ""
    var shoppingList : [CheckListItem] = [
        CheckListItem(isChecked: false, title: "Egg",description: "happy chicken egg otherwise do not buy!"),
        CheckListItem(isChecked: false, title: "Milk",description: "if there is no egg, do not buy!"),
        CheckListItem(isChecked: false, title: "Bread"),
        CheckListItem(isChecked: false, title: "Ice Tea"),
        CheckListItem(isChecked: false, title: "New Macbook",description: "ask your mac's price first!")
    ]
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(searchResults, id: \.self){
                    msg in
                    VStack(alignment: .leading){
                        Text(msg.title).font(.system(size: 22)).fontWeight(.bold)
                        msg.description {
                            Text(msg.description!).font(.system(size:14))
                        }
                    }
                }
            }.searchable(text: $searchText).navigationBarTitle("Shopping List")
        }
    }
    var searchResults: [CheckListItem] {
        if searchText.isEmpty{
            return shoppingList
        }else{
            return shoppingList.filter{
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
