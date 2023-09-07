//
//  PersistanceVewModel.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI
import CoreData

final class PersistanceViewModel: ObservableObject {
    private let viewContext = DataController.shared.viewContext
    @Published var items: [Item] = []
    @Published var valueText = ""

    init() {
        fetchData()
    }

    func fetchData() {
            let request = NSFetchRequest<Item>(entityName: "Item")
//            let sort = NSSortDescriptor(key: #keyPath(Document.lastModified), ascending: false)
//            request.sortDescriptors = [sort]
            do {
                items = try viewContext.fetch(request)
            }catch {
                print("DEBUG: Some error occured while fetching")
            }
        }


    func addItem() {
        let newItem = Item(context: viewContext)
        newItem.id = UUID()
        newItem.value = valueText
        save()
    }

    func removeItem(id: UUID) {
        let index = items.firstIndex(where: { $0.id == id })
        if let index {
            viewContext.delete(items[index])
            items.remove(at: index)
            save()
        }
    }

    func save() {
        do {
            try viewContext.save()
            withAnimation {
                fetchData()
            }
        } catch {
            print("Error saving")
        }
    }

}
