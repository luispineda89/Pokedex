//
//  SearchView.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI

public struct SearchBarView: View {
    
    @Binding var query: String
    var cancel: () -> ()
    
    public var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Pokemon",
                          text: $query)
                    .accessibilityIdentifier("searchTextField")
                Button(action: {
                    self.query = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.gray)
                }
            }.padding(8)
            .background(RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color.pBackgroundTF))
            Button(action: {
                self.cancel()
            }) {
                Text("Cancel")
            }
        }.padding(.vertical, 8)
        .padding(.horizontal, 15)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(query: .constant("")) {
            
        }
    }
}
