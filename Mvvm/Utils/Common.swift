//
//  Common.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation

func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
   var value = value
   try closure(&value)
   return value
}
