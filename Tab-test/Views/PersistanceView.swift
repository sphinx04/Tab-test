//
//  PersistanceView.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI

struct PersistanceView: View {
    @StateObject var viewModel = PersistanceViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.items) { item in
                        Text(item.value ?? "empty")
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    DispatchQueue.main.async {
                                        viewModel.removeItem(id: item.id!)
                                    }
                                }
                            }
                    } // FOREACH
                } //LIST
                .listStyle(.plain)
                
                HStack {
                    TextField("Enter value", text: $viewModel.valueText)
                        .focused($isFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isFocused = false
                                }
                            }
                        }
                    Button("Save") {
                        viewModel.addItem()
                        viewModel.valueText = ""
                    }
                    .buttonStyle(.borderedProminent)
                } //HSTACK
                .padding()
            } //VSTACK
        } //NAVIGATIONSTACK
    }
}

struct PersistanceView_Preview: PreviewProvider {
    static var previews: some View {
        PersistanceView()
    }
}
