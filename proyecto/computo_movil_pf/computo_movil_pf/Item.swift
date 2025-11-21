//
//  Item.swift
//  computo_movil_pf
//
//  Created by Angel on 18/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
