//
//  CustomTextField.swift
//  TicketFlow
//
//  Created by Own on 21/09/2026.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {updateAppearance()}
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        didSet{updateAppearance()}
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet{updateAppearance()}
    }
    
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateAppearance()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearance()
    }
    
    private func updateAppearance(){
    
        borderStyle = .none
        layer.borderWidth = borderWidth 
        layer.borderColor = borderColor?.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func isSearchBar(_ state : Bool = true){
       /*
        if state {
            let searchButton = UIButton(type: .system)
            searchButton.setImage(UIImage(systemName: "magnifyingglass"),for: .normal)
            searchButton.tintColor = borderColor
            rightView = searchButton
            rightViewMode = .always
        }
        else{
            rightView = nil
            rightViewMode = .never
        }
        */
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect { var rect = super.rightViewRect(forBounds: bounds); rect.origin.x -= 10; return rect }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += 10
        return rect
    }
    
    


}
