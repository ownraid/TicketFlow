//
//  TicketsViewModel.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import Foundation
import RxSwift
import RxCocoa

class TicketsViewModel {
    private let allTickets: BehaviorRelay<[Ticket]> = TicketsStore.shared.tickets
        let statusFilter = BehaviorRelay<Set<TicketStatus>>(value: [])
        let searchText = BehaviorRelay<String>(value: "")

        var ticketsFiltered: Observable<[Ticket]> {
            Observable.combineLatest(allTickets, statusFilter) { tickets, filter in
                filter.isEmpty ? tickets : tickets.filter { filter.contains($0.status) }
            }
        }

        var tickets: Observable<[Ticket]> {
            Observable.combineLatest(ticketsFiltered, searchText) { tickets, text in
                
                let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard !query.isEmpty else { return tickets }
                return tickets.filter { ticket in
                    ticket.category.localizedCaseInsensitiveContains(query)
                        || ticket.subCategory.localizedCaseInsensitiveContains(query)
                        || ticket.description.localizedCaseInsensitiveContains(query)
                }
        }
    }
}


/*
 
     private let allTickets: BehaviorRelay<[Ticket]> = TicketsStore.shared.tickets
     let statusFilter = BehaviorRelay<Set<TicketStatus>>(value: [])
     let searchText = BehaviorRelay<String>(value: "")

     var tickets: Observable<[Ticket]> {
         Observable.combineLatest(allTickets, statusFilter, searchText) { tickets, filter, text in
             let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

             return tickets.filter { ticket in
                 let matchesStatus = filter.isEmpty || filter.contains(ticket.status)
                 let matchesText = query.isEmpty
                     || ticket.category.localizedCaseInsensitiveContains(query)
                     || ticket.subCategory.localizedCaseInsensitiveContains(query)
                     || ticket.description.localizedCaseInsensitiveContains(query)
                 return matchesStatus && matchesText
             }
         }
     }
 
 */
