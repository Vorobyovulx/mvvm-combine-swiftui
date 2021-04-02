//
//  API.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation
import Combine

class API {
    static let shared = API()

    private let baseURL = "https://isdayoff.ru"

    func fetchDayType(for city: String) -> AnyPublisher<WorkingDayType, Never> {
        let fullUrl = URL(string: "\(baseURL)/\(city)")

        guard let url = fullUrl else {
            return Just(.error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: WorkingDayType.self, decoder: JSONDecoder())
            .catch {
                error in Just(WorkingDayType.error)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
