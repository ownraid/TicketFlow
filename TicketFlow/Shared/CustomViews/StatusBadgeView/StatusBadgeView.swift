//
//  StatusBadgeView.swift
//  TicketFlow
//
//  Created by Own on 21/09/2026.
//

import UIKit

class StatusBadgeView: UIView {

    @IBOutlet var backgroundView: StyledView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView.pillShape()
    }
    //---
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        Bundle.main.loadNibNamed(
            "StatusBadgeView",
            owner: self,
            options: nil
        )

        // Attach the XIB's root view to this StatusBadgeView.
        addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func progress() {
        titleLabel.text = "Progress"
        titleLabel.textColor = .systemYellow
        backgroundView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.12)
    }

    func closed() {
        titleLabel.text = "Closed"
        titleLabel.textColor = .primary
        backgroundView.backgroundColor = .closed
    }

    func resolved() {
        titleLabel.text = "Resolved"
        titleLabel.textColor = .systemGreen
        backgroundView.backgroundColor = .resolved
    }
}
