//
//  ButtonView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI

struct ButtonView: View {
    @Binding var isFinalViewActive: Bool
    var body: some View {
        Button {
        isFinalViewActive = true
    } label: {
        Text("Go to final view")
    }
    .buttonStyle(.borderedProminent)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isFinalViewActive: .constant(true))
    }
}
