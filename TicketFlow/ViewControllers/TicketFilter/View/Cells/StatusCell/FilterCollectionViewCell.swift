//
//  FilterCollectionViewCell.swift
//  TicketFlow
//
//  Created by Own on 24/09/2026.
//

import UIKit
import RxSwift
import RxCocoa

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundView: StyledView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "FilterCollectionViewCell"
    
    private let disposed = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearance()
    }
    
    var title : String = ""
    
    override
    var isSelected : Bool {
        didSet{
            updateAppearance()
        }
    }
    
    func configure(_ title : String){
        self.title = title
        updateAppearance()
    }
    
    func updateAppearance(){
        titleLabel.text = isSelected ? title : "+ \(title)"
        backGroundView.backgroundColor = isSelected ? .primary : .unSelcted
        titleLabel.textColor = isSelected ? .white : .gray
    }
    
 
}
