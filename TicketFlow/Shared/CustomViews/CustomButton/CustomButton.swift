//
//  CustomButton.swift
//  TicketFlow
//
//  Created by Own on 20/09/2026.
//

import UIKit
@IBDesignable
class CustomButton: UIButton {

    @IBInspectable
    var fillColorOverride: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var buttonColor: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var textColor: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var borderColor: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet { updateAppearance() }
    }
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet { updateAppearance() }
    }
    
    //________________Highlighted____________________
    override
    var isHighlighted: Bool {
        didSet { updateAppearance() }
    }
    @IBInspectable
    var pressedTextColor: UIColor? {
        didSet { updateAppearance() }
    }
    @IBInspectable
    var pressedFill: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var pressedBorderColor: UIColor? {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var pressedBorderWidth: CGFloat = 0 {
        didSet { updateAppearance() }
    }

    @IBInspectable
    var pressedAlpha: CGFloat = 1 {
        didSet { updateAppearance() }
    }
    
    
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateAppearance()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearance()
    }
    
    private func updateAppearance() {
        
        if isHighlighted {
            backgroundColor = pressedFill ?? buttonColor
            layer.borderColor = (pressedBorderColor ?? borderColor)?.cgColor
            layer.borderWidth = pressedBorderWidth
            configuration?.baseForegroundColor = pressedTextColor
            alpha = pressedAlpha
        }
        else {
            layer.cornerRadius = cornerRadius
            backgroundColor = buttonColor
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = borderWidth
            configuration?.baseForegroundColor = textColor

            alpha = 1
        }
        
        
    }
    
    
    //___________________PrimaryStyle_______________________
    func primary(_ state : Bool = true){
        if state {
            updateAppearance() 
            buttonColor = .primary
            textColor = .white
            //borderColor = .clear
            //borderWidth = 0
            cornerRadius = 24
            
            pressedFill = UIColor(red: 0.75, green: 0.10, blue: 0.08, alpha: 1)
            pressedTextColor = .white
            pressedBorderColor = .clear
            pressedBorderWidth = 0
            pressedAlpha = 1
        }
        else {
            resetStyle()
        }
    }
    
    //___________________SecondaryStyle_______________________
    func secondary(_ state : Bool = true) {
        if state {
            buttonColor = .clear
            textColor = .primary
            borderColor = .primary
            borderWidth = 1
            cornerRadius = 24
            
            pressedFill = UIColor.systemRed.withAlphaComponent(0.12)
            pressedTextColor = .primary
            pressedBorderColor = .primary
            pressedBorderWidth = 1
            pressedAlpha = 1
        }
        else {
            resetStyle()
        }
    }
    
    //___________________FlatStyle_______________________
    func flat(_ state : Bool = true) {
        if state {
            buttonColor = .clear
            textColor = .primary
            borderColor = .clear
            borderWidth = 0
            cornerRadius = 24
            
            pressedFill = .systemGray6
            pressedTextColor = .label
            pressedBorderColor = .clear
            pressedBorderWidth = 0
            pressedAlpha = 0.7
        }
        else {
            resetStyle()
        }
    }
    
    //___________________NeutralStyle_______________________
    func neutral(_ state : Bool = true) {
        
        if state {
            buttonColor = .systemGray6
            textColor = .secondaryLabel
            borderColor = .clear
            borderWidth = 0
            cornerRadius = 24
            
            pressedFill = .systemGray4
            pressedTextColor = .label
            pressedBorderColor = .systemGray3
            pressedBorderWidth = 1
            pressedAlpha = 0.9
        }
        else {
            resetStyle()
        }
    }
    
    //___________________ResetStyle_______________________
    func resetStyle() {
        buttonColor = .clear
        textColor = .label
        borderColor = .clear
        borderWidth = 0
        cornerRadius = 0
        
        pressedFill = nil
        pressedTextColor = nil
        pressedBorderColor = nil
        pressedBorderWidth = 0
        pressedAlpha = 1
    }

}
