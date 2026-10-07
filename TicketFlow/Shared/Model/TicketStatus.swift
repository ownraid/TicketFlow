//
//  TicketStatus.swift
//  TicketFlow
//
//  Created by Own on 23/09/2026.
//

import Foundation

enum TicketStatus : CaseIterable {
    case progress
    case closed
    case resolved
    
    var displayTitle: String {
        switch self {
        case .progress: return "Progress"
        case .closed: return "Closed"
        case .resolved: return "Resolved"
        }
    }
}
