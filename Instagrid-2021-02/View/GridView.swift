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
    
    //  XXXXXXXXXXXXXXXXXXXX  PROPERTIES  XXXXXXXXXXXXXXXXXXXX
    
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
    
    
    //  XXXXXXXXXXXXXXXXXXXX METHODS  XXXXXXXXXXXXXXXXXXXX
    
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
        // choice of location
        selectedLocation = location
        
        // picture change
        location?.setImage(image, for: .normal)
    }
    
    // to choose an image when a button is pressed
    @IBAction func didTapChooseImage(_ sender: UIButton!) {
        selectedLocation = sender
        delegate?.didSelectButton(sender)
    }
}


//  X-X-X-X-X-X-X-X-X-X  EXTENSIONS  X-X-X-X-X-X-X-X-X-X

// to create an image from gridView
extension GridView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
