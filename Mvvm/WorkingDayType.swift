//
//  WorkingDay.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation

enum WorkingDayType: Int, Codable {

    case working = 0
    case off = 1
    case error = 100
    case unselected = -1

    var title: String {
        switch self {

        case .working: return "Придется поработать! 🙉"
        case .off: return "Отдыхаем, хлопцы! 🐗"
        case .error: return "Ты что-то попутал, парень.. 🐔"
        case .unselected: return "Дата не выбрана."
        }
    }
}
