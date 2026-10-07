//
//  NewTicketViewModel.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import Foundation
import RxSwift
import RxCocoa

class NewTicketViewModel{
    
    let priorities = TicketPriority.allCases
    let selectedPriority = BehaviorRelay<TicketPriority>(value : .high)
    
    let selectedCategory = BehaviorRelay<String?>(value: nil)
    let selectedSubCategory = BehaviorRelay<String?>(value: nil)
    
    
    
}

