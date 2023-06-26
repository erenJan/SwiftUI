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
    @State private var editMode = EditMode.inactive
    @State private var showingSheet = false
    @State private var title = ""
    @FocusState private var titleIsFocus: Bool
    @State private var description = "Description for to do "
    @FocusState private var descriptionIsFocus : Bool
    @State private var isImportant : Bool = false
    @State var shoppingList : [CheckListItem] = [
        CheckListItem(isChecked: false, title: "Egg",description: "happy chicken egg otherwise do not buy!"),
        CheckListItem(isChecked: false, title: "Milk",description: "if there is no egg, do not buy!"),
        CheckListItem(isChecked: false, title: "Bread"),
        CheckListItem(isChecked: false, title: "Ice Tea"),
        CheckListItem(isChecked: true, title: "New Macbook",description: "ask your mac's price first!")
    ]
    
    var descriptionPlaceHolder = "Description for to do "
    var body: some View {
        NavigationView{
            List(){
                ForEach(shoppingList, id: \.self){
                    msg in
                    VStack(alignment: .leading){
                        HStack{
                            if msg.isChecked {
                                ZStack{
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 8, height: 8)
                                }
                            } else {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: 20)
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            }
                            VStack(alignment: .leading){
                                Text(msg.title).font(.system(size: 22)).fontWeight(.bold)
                                if let desc = msg.description {
                                    Text(msg.description!).font(.system(size:14))
                                }
                            }
                        }
                    }.gesture(TapGesture().onEnded {
                        if let i = shoppingList.firstIndex(where: { $0.title == msg.title }) {
                            shoppingList[i].isChecked = !shoppingList[i].isChecked
                            }
                        }
                    )
                    
                }.onDelete(perform: onDelete)
                    .onMove(perform: onMove)
            }.navigationBarTitle("Shopping List").navigationBarItems(
//                leading: HStack {
//                Button("< Go Back") {
//                    print("Hours tapped!")
//                }
//            },
                trailing: addButton)
        }
    }
    private var addButton: some View {
        switch editMode {
            case .inactive:
                return AnyView(Button(action: {
                    showingSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingSheet,onDismiss: didDismiss) {
                    CustomSheet.padding(16)
                    Spacer()
                })
        default:
            return AnyView(EmptyView())
        }
    }
    private var CustomSheet : some View {
        return AnyView(
            VStack(){
                Rectangle().foregroundColor(Color.gray).frame(width: 100,height: 6).cornerRadius(90)
                HStack{
                    Spacer()
                    Text("Dismiss").foregroundColor(Color.red).onTapGesture {
                        showingSheet = false
                    }
                }
                TextField(
                        "example: 10 Eggs",
                        text: $title
                        
                ).font(.title.bold()).lineLimit(1)
                    .focused($titleIsFocus)
                    .disableAutocorrection(true)
                Divider()
                TextEditor(
                        text: $description
                        
                ).font(.title3).foregroundColor(description == descriptionPlaceHolder ? .gray : .primary).frame(height: 100)
                    
                    .focused($titleIsFocus).lineLimit(4)
                    .disableAutocorrection(true).onTapGesture {
                        if description == descriptionPlaceHolder {
                            description = ""
                        }
                    }
                Spacer()
                ZStack{
                    Rectangle().cornerRadius(16).foregroundColor(Color.gray).opacity(0.1).frame(height: 60)
                    Toggle("Required", isOn: $isImportant).padding(16)
                }
                ZStack{
                    Rectangle().cornerRadius(16).foregroundColor(Color.gray).opacity(0.1).frame(height: 60)
                    Toggle("Required", isOn: $isImportant).padding(16)
                }
                
                Spacer()
                Button(action: {onAdd(title:title,description:description)}){
                    Text("Save").font(.title).padding(.horizontal, 8)
                        .frame(width: 200,height: 44)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.buttonStyle(.borderedProminent)
            }
        )
    }
    private func onDelete(offsets: IndexSet) {
        shoppingList.remove(atOffsets: offsets)
    }
    private func onMove(source: IndexSet, destination: Int) {
        shoppingList.move(fromOffsets: source, toOffset: destination)
    }
    func onAdd(title:String,description:String?) {
        
    }
    func didDismiss() {
        // Handle the dismissing action.
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

