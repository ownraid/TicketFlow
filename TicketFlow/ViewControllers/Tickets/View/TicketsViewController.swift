//
//  TicketsViewController.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import UIKit
import RxSwift
import RxCocoa

class TicketsViewController: UIViewController {

    @IBOutlet weak var progressTicketSummaryView: TicketSummaryView!
    @IBOutlet weak var closedTicketSummaryView: TicketSummaryView!
    @IBOutlet weak var resolvedTicketSummaryView: TicketSummaryView!
    @IBOutlet weak var searchBarTextField: CustomTextField!
    @IBOutlet weak var filterButtonBackground: StyledView!
    @IBOutlet weak var fillterButton: CustomButton!
    @IBOutlet weak var addNewTicketButton: CustomButton!
    @IBOutlet weak var ticketsTableView: UITableView!
    
    let disposed = DisposeBag()
    let viewModel = TicketsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tickets"
        
        configureUI()
        
        setUptableView()
        bindTableView()
        bindTicketSelection()
        
        handelFiltterButtonTap()
        handelAddNewTicketButtonTap()
        
        bindSearch()
        
    }
    
    func configureUI(){
        
        //ticketsTableView.backgroundColor = .clear
        
        searchBarTextField.isSearchBar()
        addNewTicketButton.primary()
        
        progressTicketSummaryView.countLabel.text = "10"
        progressTicketSummaryView.statusBadgeView.progress()
        
        closedTicketSummaryView.countLabel.text = "20"
        closedTicketSummaryView.statusBadgeView.closed()
        
        resolvedTicketSummaryView.countLabel.text = "30"
        resolvedTicketSummaryView.statusBadgeView.resolved()
    }
    
    func setUptableView(){
        ticketsTableView.register(
            UINib(nibName: TicketTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TicketTableViewCell.identifier)
    
    }
    
    private func bindTableView() {
        viewModel.tickets
            .bind(to: ticketsTableView.rx.items(
                cellIdentifier: TicketTableViewCell.identifier,
                cellType: TicketTableViewCell.self
            )) { index, ticket, cell in
                cell.configure(with: ticket)
            }
            .disposed(by: disposed)
    }
    
    private func bindTicketSelection() {
                
        ticketsTableView.rx.modelSelected(Ticket.self)
            .subscribe(onNext: { [weak self] ticket in
                guard let self = self else { return }

                if let indexPath = self.ticketsTableView.indexPathForSelectedRow {
                    self.ticketsTableView.deselectRow(at: indexPath, animated: true)
                }
            

                let ticketInfo = NewTicketViewController()
                ticketInfo.screenMode = .info(ticket)

                self.navigationController?.pushViewController(ticketInfo,animated: true)
            })
            .disposed(by: disposed)
    }
    
    func handelAddNewTicketButtonTap(){
        addNewTicketButton.rx.tap
            .subscribe(onNext:{[weak self] in
                self?.navigateToNewTicket()
            })
            .disposed(by: disposed)
        
    }
    
    func handelFiltterButtonTap() {
        fillterButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let filterVC = TicketFilterViewController()
                filterVC.initialStatuses = self.viewModel.statusFilter.value
                filterVC.onApply = { [weak self] selectedStatuses in
                    self?.viewModel.statusFilter.accept(selectedStatuses)
                }

                //filterVC.modalPresentationStyle = .pageSheet

                /*if let sheet = filterVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true

                }*/
                
                self.present(filterVC, animated: true)
            })
            .disposed(by: disposed)
    }
    
    func bindSearch() {
        searchBarTextField.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposed)
    }
    
    private func navigateToNewTicket() {
        let addTicket = NewTicketViewController()
        addTicket.screenMode = .create
        navigationController?.pushViewController(addTicket, animated: true)
    }

}
