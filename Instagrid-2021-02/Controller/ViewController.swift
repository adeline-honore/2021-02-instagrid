//
//  ViewController.swift
//  Instagrid-2021-02
//
//  Created by adeline pc on 17/02/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // gridView.refresh()
        
        let chooseGridType = UITapGestureRecognizer(target: self, action: #selector (didTapNewGrid(_:)))
        gridView.addGestureRecognizer(chooseGridType)
    }
/*
    // ContainerView buttons
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    */
    // StackView buttons
    @IBOutlet weak var rectSquareSquareButton: UIButton!
    @IBOutlet weak var squareSquareRectButton: UIButton!
    @IBOutlet weak var squaresOnlyButton: UIButton!
    
    // to share
    
    // instance of GridView()
    var gridView = GridView()
    
    @IBAction func didTapNewGrid(_ sender: UIButton) {
        switch sender {
        case rectSquareSquareButton:
            gridView.gridType = .rectSquareSquare
            
        case squareSquareRectButton:
            gridView.gridType = .squareSquareRect
        case squaresOnlyButton:
            gridView.gridType = .squaresOnly
        default:
            gridView.gridType = .squaresOnly
        }
    }
    
    /*
    private func refresh() {
        // pour chaque bouton, image = "+"
     gridView.gridType = .squaresOnly
    }*/
    
    //TODO : faire un isHidden pour le selected des boutons de la stack de choix de grid
    
    // TODO startNewGrid 1 on efface les images, 2 on affiche la bonne grid 3 on met le selected au bon endroit
}

