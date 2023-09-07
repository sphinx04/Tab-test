//
//  FactView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI

struct FactView: View {
    @ObservedObject var viewModel = FactViewModel()
    @Binding var selection: Int

    var body: some View {
        ZStack {
            if viewModel.facts.isEmpty {
                ProgressView(viewModel.message)
            } else {
                VStack(alignment: .leading) {
                    Text("Facts:")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Divider()
                    ForEach(viewModel.facts, id: \.self) { fact in
                        Text(fact)
                            .font(.largeTitle)
                        Divider()
                    }
                } //VSTACK
                .padding()
            }
        } //ZSTACK
        .onChange(of: selection) {
            if selection == 1 {
                viewModel.clear()
                viewModel.getFact(count: 1)
            }
        }
    }
}

struct FactView_Previews: PreviewProvider {
    static var previews: some View {
        FactView(selection: .constant(1))
    }
}
