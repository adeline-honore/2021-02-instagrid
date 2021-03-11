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
        
        // resetting images
        gridView.refresh()
        
        // at the launch of the application the starting grid is of the style .squaresOnly
        didTapNewGrid(squaresOnlyButton)
        
    }
    
    
    @IBOutlet weak var gridView: GridView!
    
    // StackView buttons
    @IBOutlet weak var rectSquareSquareButton: UIButton!
    @IBOutlet weak var squareSquareRectButton: UIButton!
    @IBOutlet weak var squaresOnlyButton: UIButton!
    
    // to share
    
    
    // func to choose the type of the grid
    @IBAction func didTapNewGrid(_ sender: UIButton!) {
        startNewGrid(sender)
    }
    
    private func startNewGrid(_ sender: UIButton!) {
        
        gridView.refresh()
        
        switch sender {
        case rectSquareSquareButton:
            gridView.gridType = .rectSquareSquare
            rectSquareSquareButton.setImage(UIImage(named: "Selected"), for: [])
            squareSquareRectButton.setImage(UIImage(named: ""), for: [])
            squaresOnlyButton.setImage(UIImage(named: ""), for: [])
            
        case squareSquareRectButton:
            gridView.gridType = .squareSquareRect
            rectSquareSquareButton.setImage(UIImage(named: ""), for: [])
            squareSquareRectButton.setImage(UIImage(named: "Selected"), for: [])
            squaresOnlyButton.setImage(UIImage(named: ""), for: [])
            
        case squaresOnlyButton:
            gridView.gridType = .squaresOnly
            rectSquareSquareButton.setImage(UIImage(named: ""), for: [])
            squareSquareRectButton.setImage(UIImage(named: ""), for: [])
            squaresOnlyButton.setImage(UIImage(named: "Selected"), for: [])
            
        default:
            gridView.gridType = .squaresOnly
            rectSquareSquareButton.setImage(UIImage(named: ""), for: [])
            squareSquareRectButton.setImage(UIImage(named: ""), for: [])
            squaresOnlyButton.setImage(UIImage(named: "Selected"), for: [])
        }
    }
    
    
    //func to choose an image when a button is pressed
    @IBAction func didTapChooseImage(_ sender: UIButton!) {
        chooseImage(sender)
    }
    
    private func chooseImage(_ sender: UIButton!) {
        
    }
    
    
    
    
    
    
    /*
    extension ViewController: UIImagePickerControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // TODO : extract image and display
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // TODO : do something
        }
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable (.photoLibrary) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = .photoLibrary
        //currentVC.present (myPickerController, animé: true, complétion: nil)
        }
    }*/
}

