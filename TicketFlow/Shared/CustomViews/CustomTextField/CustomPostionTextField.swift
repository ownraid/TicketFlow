//
//  CustomPostionTextField.swift
//  TicketFlow
//
//  Created by Own on 29/09/2026.
//

import UIKit

@IBDesignable
class CustomPostionTextField: UITextField {
    
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += 10
        rect.origin.y += 10

        return rect
    }


}
