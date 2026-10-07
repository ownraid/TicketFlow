//
//  TicketSummaryView.swift
//  TicketFlow
//
//  Created by Own on 21/09/2026.
//

import UIKit

class TicketSummaryView: StyledView {

    @IBOutlet var backgroundView: StyledView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var statusBadgeView: StatusBadgeView! 
        
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required
    init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        Bundle.main.loadNibNamed(
            "TicketSummaryView",
            owner: self,
            options: nil
        )

        addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}
