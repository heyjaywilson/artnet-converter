//
//  WebView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/9/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }

    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {

        let request = URLRequest(url: URL(string: self.url)!)

        view.load(request)
    }
}
