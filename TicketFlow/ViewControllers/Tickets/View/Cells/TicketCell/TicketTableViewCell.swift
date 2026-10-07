//
//  TicketTableViewCell.swift
//  TicketFlow
//
//  Created by Own on 21/09/2026.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var statusBadgeView: StatusBadgeView!
    @IBOutlet weak var ticketIdLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "TicketTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Date
    
    private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d, M, yyyy"
            return formatter
        }()
    
    
    // MARK: - Configure
    
    func configure(with ticket: Ticket) {
        
            ticketCategoryLabel.text = ticket.category
            subCategoryLabel.text = ticket.subCategory
            ticketIdLabel.text = "ID - \(ticket.number)"
            dateLabel.text = Self.dateFormatter.string(from: ticket.date)

            switch ticket.status {
            case .progress: statusBadgeView.progress()
            case .closed: statusBadgeView.closed()
            case .resolved: statusBadgeView.resolved()
            }
        
        }
    
}
