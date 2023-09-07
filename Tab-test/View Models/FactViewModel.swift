//
//  FactViewModel.swift
//  Tab-test
//
//  Created by Sphinx04 on 07.09.23.
//

import SwiftUI
import Combine

final class FactViewModel: ObservableObject {
    @Published var facts = [String]()
    @Published var message = "Loading..."
    private var cancellables = Set<AnyCancellable>()
    private var attemtsCount = 0
    
    func getFact(count: Int) {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/facts?limit=\(count)") else { return }
        var request = URLRequest(url: url)
        request.setValue(Constants.factsAPIKey, forHTTPHeaderField: "X-Api-Key")
        print("Request set")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { [weak self] (data, response) -> Data in
                if let self = self {
                    guard
                        let response = response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                        print("Data not recieved")
                        if self.attemtsCount < 10 {
                            self.getFact(count: count)
                            self.attemtsCount += 1
                            print(attemtsCount, "attmpt")
                        }
                        withAnimation {
                            self.message = "Bad server response. Attempt: \(self.attemtsCount+1)"
                        }
                        throw URLError(.badServerResponse)
                    }
                }
                return data
            }
            .decode(type: [[String: String]].self, decoder: JSONDecoder())
            .sink { completion in
                print("Completed")
            } receiveValue: { [weak self] dictionary in
                withAnimation {
                    self?.facts = dictionary.flatMap({ $0.values })
                }
            }
            .store(in: &cancellables)
    }

    func clear() {
        facts = []
        attemtsCount = 0
        message = "Loading..."
    }
}
