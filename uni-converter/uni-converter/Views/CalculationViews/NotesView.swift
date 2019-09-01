//
//  NotesView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/31/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct NotesView: View {
    var notes: [String]
    var body: some View {
        ForEach(notes, id: \.self){ note in
            Text("\(note)")
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(notes: [])
    }
}
