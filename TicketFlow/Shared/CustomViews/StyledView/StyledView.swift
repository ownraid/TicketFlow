//
//  StyledView.swift
//  TicketFlow
//
//  Created by Own on 21/09/2026.
//

import UIKit
@IBDesignable
class StyledView: UIView {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var shadowColor: UIColor = .clear {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var shadowOpacity: Float = 0 {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var shadowRadius: CGFloat = 0 {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var shadowWidth: CGFloat = 0 {
        didSet {updateAppearance()}
    }

    @IBInspectable
    var shadowHeight: CGFloat = 0 {
        didSet {updateAppearance()}
    }


    func updateAppearance() {

        if isCircular {
            layer.cornerRadius = bounds.height / 2
            layer.shadowRadius = bounds.height / 2
        } else if isPillShape {
            layer.cornerRadius = layer.bounds.height / 2
        }
        else{
            layer.shadowRadius = shadowRadius
            layer.cornerRadius = cornerRadius
        }
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight )
        layer.masksToBounds = false
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateAppearance()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearance()
    }
    
    private var isCircular = false

    private lazy var circleConstraint =
        heightAnchor.constraint(equalTo: widthAnchor)

    func isCircle(_ state: Bool = true) {
        isCircular = state
        circleConstraint.isActive = state
        setNeedsLayout()
    }
    
    private var isPillShape = false
    func pillShape(_ state: Bool = true){
        isPillShape = state
        cornerRadius = layer.bounds.height / 2
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateAppearance()
    }
    
}
