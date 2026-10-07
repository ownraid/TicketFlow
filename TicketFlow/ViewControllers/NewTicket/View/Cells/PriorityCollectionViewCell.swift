//
//  PriorityCollectionViewCell.swift
//  TicketFlow
//
//  Created by Own on 22/09/2026.
//

import UIKit

class PriorityCollectionViewCell: UICollectionViewCell {

    static let identifier = "PriorityCollectionViewCell"

    @IBOutlet weak var backgroundCardView: StyledView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makePillShape()
    }
    
    override var isSelected: Bool {
            didSet {
                updateAppearance()
            }
    }
    
    private func updateAppearance() {
        
        guard let backgroundCardView = backgroundCardView,
              let titleLabel = titleLabel else {
            return
        }

        if isSelected {
            selectedStyle()
            titleLabel.textColor = .white
        }
        else {
            unselectedStyle()
            titleLabel.textColor = .primary
        }
    }
    
    func configure(with priority: TicketPriority) {
            titleLabel.text = priority.rawValue
            updateAppearance()
        }
    
    func selectedStyle() {
        backgroundCardView.backgroundColor = .primary
        backgroundCardView.borderColor = .primary
        backgroundCardView.borderWidth = 1
    }

    func unselectedStyle() {
        backgroundCardView.backgroundColor = .clear
        backgroundCardView.borderColor = .primary
        backgroundCardView.borderWidth = 1
    }

    func makePillShape() {
        backgroundCardView.cornerRadius = min(bounds.width, bounds.height) / 2
    }
    

}
