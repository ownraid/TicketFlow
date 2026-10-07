//
//  TicketStore.swift
//  TicketFlow
//
//  Created by Own on 23/09/2026.
//

import Foundation
import RxSwift
import RxCocoa

final class TicketsStore {
    static let shared = TicketsStore()
    private init() {}

    let tickets = BehaviorRelay<[Ticket]>(value: [])

    func add(_ ticket: Ticket) {
        var numberdTicket =  ticket
        numberdTicket.number = tickets.value.count + 1
        tickets.accept(tickets.value + [numberdTicket])
    }
    
    func updateStatus(number: Int, to newStatus: TicketStatus) {
        var updated = tickets.value
        /*
        var position: Int? = nil
        for (i, ticket) in updated.enumerated() {
            if ticket.number == number {
                position = i
                break
            }
        }
         */
        guard let position = updated.firstIndex(where: { $0.number == number }) else { return }
        updated[position].status = newStatus
        tickets.accept(updated)
    }
}
