//
//  GestureWebView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI

struct GestureWebView: View {
    let url: String
    let webView: WebView

    init(url: String) {
        self.url = url
        self.webView = WebView(url: URL(string: url)!)
    }

    var body: some View {
        webView
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .local)
                    .onEnded({ value in
                        guard abs(value.translation.height) < 20 else { return }
                        if value.translation.width > 0 {
                            webView.wkWebView.goBack()
                        } else {
                            webView.wkWebView.goForward()
                        }
                    })
            )
    }
}

struct GestureWebView_Previews: PreviewProvider {
    static var previews: some View {
        GestureWebView(url: "https://www.google.com/")
    }
}
