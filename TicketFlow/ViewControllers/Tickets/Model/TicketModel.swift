//
//  TicketModel.swift
//  TicketFlow
//
//  Created by Own on 23/09/2026.
//

import Foundation

struct Ticket {
    let category: String
    let subCategory: String
    let priority: TicketPriority
    let description: String
    let date: Date = Date()
    var status: TicketStatus = .progress
    var number: Int = 0

    /*
    init(category: String, subCategory: String, priority: TicketPriority,
         description: String, date: Date = Date(), status: TicketStatus = .progress) {
        self.category = category
        self.subCategory = subCategory
        self.priority = priority
        self.description = description
        self.date = date
        self.status = status
    }
     */
}
