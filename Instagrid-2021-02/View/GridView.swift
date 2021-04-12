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
    
    private var gridArray = [UIButton]()
    
    
    //  XXXXXXXXXXXXXXXXXXXX METHODS  XXXXXXXXXXXXXXXXXXXX
    
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
        
        //topLeftButton.currentImage.contentMode = .scaleAspectFit
        //bottomLeftButton.imageView?.contentMode = .scaleAspectFill
        //bottomLeftButton.currentImage.contentMode = .scaleAspectFit
        
        //bottomLeftButton.currentBackgroundImage?.scale.native
        
        
        
    }
    
    // to select location for choosenImage
    func setTheImage(location: UIButton?, image: UIImage) {
        
        // choice of location
        selectedLocation = location
        
        // picture change
        location?.setBackgroundImage(image, for: .normal)
        
        hideDefaultImage(location: selectedLocation)
        
    }
    
    func hideDefaultImage(location: UIButton?) {
        location?.imageView?.alpha = 0
    }
    
    func verifHideImage() {
        print("-------------")
        knowGridArray()
        gridArray.forEach { buttonInGrid in
            if buttonInGrid.currentBackgroundImage != nil {
                hideDefaultImage(location: buttonInGrid)
                print(1)
            }
        }
        print("___________")
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
