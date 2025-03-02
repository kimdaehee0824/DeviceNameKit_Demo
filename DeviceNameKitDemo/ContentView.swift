//
//  ContentView.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("Async/Await", destination: AsyncView())
                NavigationLink("Handler", destination: HandlerView())
                NavigationLink("Combine", destination: CombineView())
            }
            .navigationTitle("Demo")
            .toolbar {
                Button {

                } label: {
                    Image(systemName: "questionmark.circle")
                }
            }
        } detail: {
            ContentUnavailableView(
                "Select an element from the sidebar",
                systemImage: "doc.text.image.fill"
            )
        }
    }
}

#Preview {
    ContentView()
}
