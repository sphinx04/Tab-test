//
//  MainView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFinalView") var isFinalViewActive = false
    @State var selection = 0

    var body: some View {
        if isFinalViewActive {
            GestureWebView(url: "https://www.google.com/")
        } else {
            TabView(selection: $selection) {
                PersistanceView()
                    .tabItem {
                        Image(systemName: "tray.and.arrow.down")
                        Text("Persistance")
                    }
                    .tag(0)
                FactView(selection: $selection)
                    .tabItem {
                        Image(systemName: "doc.plaintext")
                        Text("Facts")
                    }
                    .tag(1)
                ButtonView(isFinalViewActive: $isFinalViewActive)
                    .tabItem {
                        Image(systemName: "arrow.forward.square")
                        Text("Next view")
                    }
                    .tag(1)
            } //TABVIEW
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
