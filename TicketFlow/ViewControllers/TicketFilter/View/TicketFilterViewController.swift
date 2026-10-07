//
//  TicketFilterViewController.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class TicketFilterViewController: UIViewController {
    
    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instractionLabel: UILabel!
    @IBOutlet weak var xMarkBackground: StyledView!
    @IBOutlet weak var xMarkButton: UIButton!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var applyButton: CustomButton!
    @IBOutlet weak var clearButton: CustomButton!
    
    var initialStatuses: Set<TicketStatus> = []
    var onApply: ((Set<TicketStatus>) -> Void)?
    
    private lazy var viewModel = TicketFilterViewModel(initialStatuses: initialStatuses)
    private let disposed = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionViewSetup()
        bindCollectionView()
        bindActions()
    }
    
    func configureUI(){
        xMarkBackground.isCircle()
        applyButton.primary()
        clearButton.flat()
        
    }
    func collectionViewSetup(){
        statusCollectionView.register(
            UINib(nibName: FilterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        
        statusCollectionView.allowsSelection = true
        statusCollectionView.allowsMultipleSelection = true
    }
    
    private func bindCollectionView() {
        
        fillCellsWithOptions()
        keepCellsInSyncWithSelection()
        listenForTaps()
        listenForUntaps()
        
    }

    private func fillCellsWithOptions() {
        
        Observable.just(viewModel.optionTitles)
            .bind(to: statusCollectionView.rx.items(
                cellIdentifier: FilterCollectionViewCell.identifier,
                cellType: FilterCollectionViewCell.self
            )) { _, title, cell in
                cell.configure(title)
            }
            .disposed(by: disposed)
        
    }

    private func keepCellsInSyncWithSelection() {
        
        viewModel.selectedIndexes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexes in
                self?.highlightCells(at: indexes)
            })
            .disposed(by: disposed)
        
    }

    private func highlightCells(at indexes: [Int]) {
        
        statusCollectionView.indexPathsForSelectedItems?.forEach {
            statusCollectionView.deselectItem(at: $0, animated: false)
        }

        for index in indexes {
            let path = IndexPath(item: index, section: 0)
            statusCollectionView.selectItem(at: path, animated: false, scrollPosition: [])
        }
    }

    private func listenForTaps() {
        statusCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.selectOption(at: indexPath.item)
            })
            .disposed(by: disposed)
    }

    private func listenForUntaps() {
        statusCollectionView.rx.itemDeselected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.deselectOption(at: indexPath.item)
            })
            .disposed(by: disposed)
    }

    private func bindActions() {
        xMarkButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposed)

        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.clearSelection()
            })
            .disposed(by: disposed)

        applyButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.onApply?(self.viewModel.currentSelection)
                self.dismiss(animated: true)
            })
            .disposed(by: disposed)
    }
    
}
