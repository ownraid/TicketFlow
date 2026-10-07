//
//  TicketFilterViewModel.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import Foundation
import RxSwift
import RxCocoa
/*
class TicketFilterViewModel {
    static let options: [TicketStatus?] = [nil] + TicketStatus.allCases

    let selectedStatuses: BehaviorRelay<Set<TicketStatus>>

    init(initialStatuses: Set<TicketStatus> = []) {
        selectedStatuses = BehaviorRelay<Set<TicketStatus>>(value: initialStatuses)
    }
}
*/

final class TicketFilterViewModel {

    // MARK: - Filter Options

    private enum FilterOption {
        case all
        case status(TicketStatus)

        var title: String {
            switch self {
            case .all:
                return "All"
            case .status(let status):
                return status.displayTitle
            }
        }

        func isSelected(in statuses: Set<TicketStatus>) -> Bool {
            switch self {
            case .all:
                return statuses.isEmpty
            case .status(let status):
                return statuses.contains(status)
            }
        }
    }

    private let options: [FilterOption] = [.all] + TicketStatus.allCases.map(FilterOption.status)

    // MARK: - state

    private let selectedStatusesRelay: BehaviorRelay<Set<TicketStatus>>

    // MARK: - read only data for the View

    var optionTitles: [String] {
        options.map { $0.title }
    }

    var selectedIndexes: Observable<[Int]> {
        let options = self.options
        return selectedStatusesRelay
            .distinctUntilChanged()
            .map { statuses in
                options.indices.filter { options[$0].isSelected(in: statuses) }
            }
    }

    var currentSelection: Set<TicketStatus> {
        selectedStatusesRelay.value
    }

    // MARK: - init

    init(initialStatuses: Set<TicketStatus> = []) {
        selectedStatusesRelay = BehaviorRelay(value: initialStatuses)
    }

    // MARK: - actions

    func selectOption(at index: Int) {
        switch options[index] {
        case .all:
            selectedStatusesRelay.accept([])
        case .status(let status):
            var current = selectedStatusesRelay.value
            current.insert(status)
            selectedStatusesRelay.accept(current)
        }
    }

    func deselectOption(at index: Int) {
        guard case .status(let status) = options[index] else { return }
        var current = selectedStatusesRelay.value
        current.remove(status)
        selectedStatusesRelay.accept(current)
    }

    func clearSelection() {
        selectedStatusesRelay.accept([])
    }
}
