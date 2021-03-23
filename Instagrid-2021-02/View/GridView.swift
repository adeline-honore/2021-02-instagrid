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
    
    
    enum GridType {
        case rectSquareSquare
        case squareSquareRect
        case squaresOnly
    }
    
    
    
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
    
    func refresh() {
        // pour chaque bouton, image = "+"
        //TODO effacer toutes les images précedemment insérées , image = "+"
        
    }
    
    func setTheImage(location: UIButton?, image: UIImage) {
        
        // choice of location
        selectedLocation = location
        
        // picture change
        location?.setImage(image, for: .normal)
 
    }
    
    //func to choose an image when a button is pressed
    @IBAction func didTapChooseImage(_ sender: UIButton!) {
        selectedLocation = sender
        delegate?.didSelectButton(sender)
    }
}
