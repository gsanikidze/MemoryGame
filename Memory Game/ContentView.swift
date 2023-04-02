//
//  ContentView.swift
//  Memory Game
//
//  Created by Guram Sanikidze on 01.04.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: MemoryGameVM
    private let columns = [GridItem(.adaptive(minimum: 60))]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(vm.cards) { item in
                    CardView(
                        content: item.content,
                        isFacedUp: item.isFacedUp,
                        matched: item.matched,
                        onTab: {
                            if !item.matched {
                                vm.choose(item)
                            }
                        }
                    )
                    .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .padding()
            Spacer()
            HStack {
                Text("Points: \(vm.point)")
                    .foregroundColor(.white)
                
                Spacer()
                
                if vm.gameOver {
                    Button(action: vm.restart) {
                        Text("Restart")
                            .foregroundColor(.white)
                    }
                }
            }.padding()
        }.background(Color("mg_blue"))
    }
}

struct CardView: View {
    var content: String
    var isFacedUp: Bool
    var matched: Bool
    var onTab: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("mg_cyan"))
            Text(content)
                .font(.system(.largeTitle))
            
            if !isFacedUp {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color("mg_silver"))
            }
            
            if matched {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color("mg_silver").opacity(0.5))
                    Text("❤️")
                        .font(.system(.largeTitle))
                }
            }
        }.onTapGesture {
            withAnimation {
                onTab()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MemoryGameVM()
        
        ContentView(vm: vm)
    }
}
