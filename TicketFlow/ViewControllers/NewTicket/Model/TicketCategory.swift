//
//  TicketCategory.swift
//  TicketFlow
//
//  Created by Own on 23/09/2026.
//

import Foundation

enum TicketCategory: String, CaseIterable {
    case technical = "Technical Issue"
    case billing = "Billing"
    case account = "Account"
    case featureRequest = "Feature Request"
    case other = "Other"

    var subCategories: [String] {
        switch self {
        case .technical:
            return ["App Crash", "Login Problem", "Sync Error", "Performance Issue"]
        case .billing:
            return ["Refund Request", "Invoice Question", "Payment Failed", "Subscription Change"]
        case .account:
            return ["Password Reset", "Email Change", "Account Deletion", "Two-Factor Setup"]
        case .featureRequest:
            return ["New Feature", "Improvement", "Integration Request"]
        case .other:
            return ["General Question", "Feedback"]
        }
    }
}
