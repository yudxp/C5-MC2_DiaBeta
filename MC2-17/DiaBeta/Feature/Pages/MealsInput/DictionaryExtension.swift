//
//  DictionaryExtension.swift
//  DiaBeta
//
//  Created by Muhammad Abdul Fattah on 23/06/22.
//

import Foundation

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

