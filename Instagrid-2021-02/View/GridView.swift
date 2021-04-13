//
//  GridView.swift
//  Instagrid-2021-02
//
//  Created by HONORE Adeline on 11/03/2021.
//

import UIKit

protocol GridViewDelegate {
    func didSelectButton(_ sender: UIButton!)
}

class GridView: UIView {
    
    // enumeration for types of grid
    enum GridType {
        case rectSquareSquare
        case squareSquareRect
        case squaresOnly
    }
    
    //  MARK: -PROPERTIES
    
    @IBOutlet private var topLeftButton: UIButton!
    @IBOutlet private var topRightButton: UIButton!
    @IBOutlet private var bottomLeftButton: UIButton!
    @IBOutlet private var bottomRightButton: UIButton!
   
    var delegate: GridViewDelegate?
    
    var selectedLocation: UIButton!
    
    var gridType: GridType = .squaresOnly {
        didSet {
            setGridType(gridType)
        }
    }
    
    private var gridArray = [UIButton]()
    
    
    // MARK: _METHODS
    
    func knowGridArray() {
        switch gridType {
        case .squaresOnly:
            gridArray = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
        case .rectSquareSquare:
            gridArray = [topLeftButton, bottomLeftButton, bottomRightButton]
        case .squareSquareRect:
            gridArray = [topLeftButton, topRightButton, bottomLeftButton]
        }
    }
    
    
    func isGridComplete() -> Bool{
        var result = true
        knowGridArray()
        gridArray.forEach { buttonInGrid in
            var resultUnit = false
            if buttonInGrid.currentBackgroundImage == nil {
                resultUnit = false
            }
            else {
                resultUnit = true
            }
            result = result && resultUnit
        }
        return result
    }
    
    
    // to custom gridView
    private func setGridType(_ gridType: GridType) {
        switch gridType {
        case .rectSquareSquare:
            topRightButton.isHidden = true
            bottomRightButton.isHidden = false
        case .squareSquareRect:
            topRightButton.isHidden = false
            bottomRightButton.isHidden = true
        case .squaresOnly:
            topRightButton.isHidden = false
            bottomRightButton.isHidden = false
        }
        
    }
    
    // to select location for choosenImage
    func setTheImage(location: UIButton?, image: UIImage) {
        
        selectedLocation = location
        
        // background change
        location?.setBackgroundImage(image, for: .normal)
        location?.layoutIfNeeded()
        location?.subviews.first?.contentMode = .scaleAspectFill
       
        hideDefaultImage(location: selectedLocation)
    }
    
    func hideDefaultImage(location: UIButton?) {
        location?.setImage(nil, for: .normal)
        
    }
    
    // to choose an image when a button is pressed
    @IBAction func didTapChooseImage(_ sender: UIButton!) {
        selectedLocation = sender
        delegate?.didSelectButton(sender)
    }
}

// MARK: -EXTENSIONS

// to create an image from gridView
extension GridView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
