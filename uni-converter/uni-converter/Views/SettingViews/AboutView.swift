//
//  AboutView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/10/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("This app is created by Maegan Wilson. She greatly appreciates the download and the use of the app.")
            Text("Privacy Policy")
                .font(.title)
            Text("The app does not require the input of any personal data nor does it go through your phone to sell personal data.")
            Spacer()
            }
        .padding()
        .navigationBarTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
