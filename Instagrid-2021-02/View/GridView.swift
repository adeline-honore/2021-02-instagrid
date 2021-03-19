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

class GridView: UIView, GridViewDelegate {
    
    
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
    
    func setTheImage(image: UIImage) {
        
        if topLeftButton.isSelected {
            topLeftButton.setImage(image, for: .normal)
        }
        else if topRightButton.isSelected {
            topRightButton.setImage(image, for: .normal)
        }
        else if bottomLeftButton.isSelected {
            bottomLeftButton.setImage(image, for: .normal)
        }
        else if bottomRightButton.isSelected {
            bottomRightButton.setImage(image, for: .normal)
        }
        
        //topLeftButton.setImage(image, for: .normal)
    }
    
    //func to choose an image when a button is pressed
    @IBAction func didTapChooseImage(_ sender: UIButton!) {
        print("*************  ------  azertyuiop")
        delegate?.didSelectButton(sender)
    }
    
    // response to protocol requirements
    func didSelectButton(_ sender: UIButton!) {
        
        print("*_*_*_*_*_*_*_*__*_*_*_*_**   ok protocol")
      
    }
}
