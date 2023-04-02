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
                        onTab: {
                            vm.choose(item)
                        }
                    )
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .padding()
            Spacer()
        }.background(Color("mg_blue"))
    }
}

struct CardView: View {
    var content: String
    var isFacedUp: Bool
    var onTab: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(
                    Color("mg_cyan")
                )
            Text(content)
                .font(.system(.largeTitle))
            
            if !isFacedUp {
                RoundedRectangle(cornerRadius: 7)
                    .fill(
                        Color("mg_silver")
                    )
            }
        }.onTapGesture {
            onTab()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MemoryGameVM()
        
        ContentView(vm: vm)
    }
}
