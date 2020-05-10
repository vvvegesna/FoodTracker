//
//  RatingsControl.swift
//  FoodTracker
//
//  Created by Vegesna, Vijay V EX1 on 5/6/20.
//  Copyright © 2020 Vegesna, Vijay V EX1. All rights reserved.
//

import UIKit

@IBDesignable class RatingsControl: UIStackView {

    //MARK: properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedIndex = index + 1
        if selectedIndex == rating {
            rating = 0
        } else {
            rating = selectedIndex
        }
    }
    
    //MARK: Private methods
    
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            addArrangedSubview(button)
            button.addTarget(self, action: #selector(RatingsControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            var hintString: String?
            if rating == (index + 1) {
                hintString = "Reset rating to zero"
            } else {
                hintString = nil
            }
            
            var valueString: String
            switch rating {
            case 0:
                valueString = "No rating is set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityValue = valueString
            button.accessibilityHint = hintString
        }
    }

}
