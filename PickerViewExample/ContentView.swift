//
//  ContentView.swift
//  PickerViewExample
//
//  Created by Muhammed Nadeem M A on 18/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex = 0
    private let options = ["Apple", "Banana", "Papaya", "Orange"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Selected: \(options[selectedIndex])")
                .padding()

            CustomPickerView(
                selectedIndex: $selectedIndex,
                data: options,
                placeholder: "Select a fruit"
            )
            .padding(8)
            .frame(height: 50)
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
