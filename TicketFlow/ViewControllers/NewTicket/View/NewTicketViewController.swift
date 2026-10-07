//
//  NewTicketViewController.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import UIKit
import RxSwift
import RxCocoa

class NewTicketViewController: UIViewController {

    @IBOutlet weak var ticketCategoryButton: CustomButton!
    @IBOutlet weak var validationTicketCategoryLabel: UILabel!
    @IBOutlet weak var subCategoryButton: CustomButton!
    @IBOutlet weak var validationSubCategoryLabel: UILabel!
    @IBOutlet weak var priorityCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var validationDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: CustomPostionTextField!
    @IBOutlet weak var submitButton: CustomButton!
    @IBOutlet weak var resolvedButton: CustomButton!
    @IBOutlet weak var closedButton: CustomButton!
    
    
    private let viewModel = NewTicketViewModel()
    private let disposed = DisposeBag()
    
    
    enum ScreenMode {
        case create
        case info(Ticket)
    }

    var screenMode: ScreenMode = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindPriorities()
        switch screenMode {
            case .create:
                title = "New Ticket"
                submitButton.isHidden = false
                resolvedButton.isHidden = true
                closedButton.isHidden = true
                configureMenus()
                bindValidation()

            case .info(let ticket):
                title = "Ticket info"
                displayTicket(ticket)
                showStatusButtons(ticket.status)
                bindStatusButtons(ticket)
        }
    }
    
    private func displayTicket(_ ticket: Ticket) {
        
        viewModel.selectedCategory.accept(ticket.category)
        viewModel.selectedSubCategory.accept(ticket.subCategory)
        viewModel.selectedPriority.accept(ticket.priority)

        displayReadOnlyValue(ticket.category, on: ticketCategoryButton)
        displayReadOnlyValue(ticket.subCategory, on: subCategoryButton)

        descriptionTextField.text = ticket.description

        descriptionTextField.isEnabled = false
        submitButton.isHidden = true
        priorityCollectionView.isUserInteractionEnabled = false
    }

    private func displayReadOnlyValue(_ value: String,on button: UIButton) {
        
        button.changesSelectionAsPrimaryAction = false
        button.showsMenuAsPrimaryAction = false
        button.menu = nil

        if var configuration = button.configuration {
            configuration.attributedTitle = nil
            configuration.title = value
            button.configuration = configuration
        } else {
            button.setTitle(value, for: .normal)
        }

        button.isEnabled = false
    }
    
    func configureUI(){
        
        submitButton.primary()
        resolvedButton.backgroundColor = .resolved
        closedButton.backgroundColor = .closed
        
        priorityCollectionViewSetup()
        validationTicketCategoryLabel.isHidden = true
        validationSubCategoryLabel.isHidden = true
        validationDescriptionLabel.isHidden = true
    }
    
    private func configureMenus() {

        let categoryActions = TicketCategory.allCases.map { category in
                UIAction(title: category.rawValue) { [weak self] action in
                    self?.ticketCategoryButton.setTitle(action.title, for: .normal)
                    self?.viewModel.selectedCategory.accept(action.title)
                }
            }
            ticketCategoryButton.menu = UIMenu(title: "  Select the category", children: categoryActions)
            ticketCategoryButton.setTitle("  Select the category", for: .normal)

            viewModel.selectedCategory
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] categoryTitle in
                    self?.updateSubCategoryMenu(for: categoryTitle)
                })
                .disposed(by: disposed)
        }

        private func updateSubCategoryMenu(for categoryTitle: String) {
            guard let category = TicketCategory(rawValue: categoryTitle) else { return }

            let subCategoryActions = category.subCategories.map { name in
                UIAction(title: name) { [weak self] action in
                    self?.subCategoryButton.setTitle(action.title, for: .normal)
                    self?.viewModel.selectedSubCategory.accept(action.title)
                }
            }

            subCategoryButton.menu = UIMenu(title: "  Select the category", children: subCategoryActions)
            subCategoryButton.setTitle("  Select the category", for: .normal)
            viewModel.selectedSubCategory.accept(nil)
    }
    
    
    func priorityCollectionViewSetup(){
        
        priorityCollectionView.register(
            UINib(nibName: PriorityCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriorityCollectionViewCell.identifier)
        
        priorityCollectionView.allowsSelection = true
    }
    
    private func bindPriorities() {

        Observable.just(viewModel.priorities)
            .bind(to: priorityCollectionView.rx.items(cellIdentifier: PriorityCollectionViewCell.identifier,
                    cellType: PriorityCollectionViewCell.self
                )) { _, priority, cell in
                    cell.configure(with: priority)
                }
                .disposed(by: disposed)

        viewModel.selectedPriority
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] priority in
                    guard let self = self,
                          let index = self.viewModel.priorities.firstIndex(
                              of: priority
                          ) else {
                        return
                    }

                    self.priorityCollectionView.selectItem(
                        at: IndexPath(item: index, section: 0),
                        animated: false,
                        scrollPosition: []
                    )
                })
                .disposed(by: disposed)

            priorityCollectionView.rx.modelSelected(TicketPriority.self)
                .bind(to: viewModel.selectedPriority)
                .disposed(by: disposed)
    }
    
    private func bindValidation() {

        let isCategoryValid = viewModel.selectedCategory.map { $0 != nil }
        let isSubCategoryValid = viewModel.selectedSubCategory.map { $0 != nil }
        let isDescriptionValid = descriptionTextField.rx.text.orEmpty
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

        let validation = Observable.combineLatest(isDescriptionValid, isCategoryValid, isSubCategoryValid)

        submitButton.rx.tap
            .withLatestFrom(validation)
            .subscribe(onNext: { [weak self] (isDescriptionValid, isCategoryValid, isSubCategoryValid) in
                guard let self = self else { return }

                self.validationTicketCategoryLabel.isHidden = isCategoryValid
                self.validationSubCategoryLabel.isHidden = isSubCategoryValid
                self.validationDescriptionLabel.isHidden = isDescriptionValid
                
                guard case .create = screenMode else { return }
                guard isDescriptionValid, isCategoryValid, isSubCategoryValid else { return }
                self.submitTicket()
            })
            .disposed(by: disposed)
    }

    private func submitTicket() {
        let ticket = Ticket(
            category: viewModel.selectedCategory.value ?? "",
            subCategory: viewModel.selectedSubCategory.value ?? "",
            priority: viewModel.selectedPriority.value,
            description: descriptionTextField.text ?? ""
        )

        TicketsStore.shared.add(ticket)
        navigationController?.popViewController(animated: true)
    }
    
    private func bindStatusButtons(_ ticket: Ticket) {
        resolvedButton.rx.tap
            .subscribe(onNext: { [weak self] in
                TicketsStore.shared.updateStatus(number: ticket.number, to: .resolved)
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposed)

        closedButton.rx.tap
            .subscribe(onNext: { [weak self] in
                TicketsStore.shared.updateStatus(number: ticket.number, to: .closed)
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposed)
    }
    
    private func showStatusButtons(_ status: TicketStatus) {
        resolvedButton.isHidden = (status != .progress)
        closedButton.isHidden = (status == .closed)
    }
    
    
}
