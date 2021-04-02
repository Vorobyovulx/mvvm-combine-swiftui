//
//  UIKitViewModel.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation
import Combine

final class WorkingDayViewModel: ObservableObject {

    @Published private(set) var state = ViewsState.ready

    // Input
    @Published var inputDate: String = ""

    // Output
    @Published var currentDayType: WorkingDayType = .unselected

    private var cancellable: Set<AnyCancellable> = []

    init() {
        $inputDate
            .dropFirst()
            .debounce(for: 2, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [weak self] (date: String) -> AnyPublisher <WorkingDayType, Never> in
                self?.state = .loading
                return API.shared.fetchDayType(for: date)
            }
            .sink(
                receiveValue: { [weak self] value in
                    sleep(3)
                    self?.state = .ready
                    self?.currentDayType = value
                }
            )
            .store(in: &self.cancellable)
    }
}
