//
//  GridView.swift
//  Instagrid-2021-02
//
//  Created by HONORE Adeline on 11/03/2021.
//

import UIKit

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
   
   
    
    //TODO pour chacun des boutons quand je clique sur le bouton je peux choisir mon image
    
    
    var picture = "" {
        didSet {
            //topRightButton.setImage(#imageLiteral(resourceName: "Plus"), for: UIControl.State)
        }
    }
    
    
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

}
