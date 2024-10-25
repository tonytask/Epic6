//
//  ContentView.swift
//  Monster Master
//
//  Created by Tony on 6/18/24.
//

import SwiftUI



struct ContentView: View {
    
    @State private var gameWorld = GameWorld()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.yellow, .white,.red,.white,.yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                        
                        Text("Epic Six")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: LoadingView(gameWorld: gameWorld)) {
                        Text("Play")
                            .font(.title)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: UpdateView()) {
                        Text("Updates")
                            .font(.title)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}

