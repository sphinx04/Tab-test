//
//  WebView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL
    var wkWebView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        return wkWebView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://google.com")!)
    }
}
