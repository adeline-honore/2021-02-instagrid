//
//  ViewController.swift
//  Instagrid-2021-02
//
//  Created by adeline pc on 17/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //var isPortrait: Bool

        
    @IBOutlet weak var gridView: GridView!
    
    // StackView buttons
    @IBOutlet weak var rectSquareSquareButton: UIButton!
    @IBOutlet weak var squareSquareRectButton: UIButton!
    @IBOutlet weak var squaresOnlyButton: UIButton!
    
    // current button in StackView to choose a grid
    var currentButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // resetting images
        gridView.refresh()
        
        // at the launch of the application the starting grid is of the style .squaresOnly
        currentButton = squaresOnlyButton
        selectedGrid(currentButton: currentButton)
        
        //
        gridView.delegate = self
    }
    
    
    // to share
    
    
    
    
    // func to choose the type of the grid
    @IBAction func didSelectTypeOfGrid(_ sender: UIButton!) {
        selectTypeOfGrid(sender)
    }
    
    private func selectTypeOfGrid(_ sender: UIButton!) {
        
        switch sender {
        case rectSquareSquareButton:
            gridView.gridType = .rectSquareSquare
            selectedGrid(currentButton: rectSquareSquareButton)
        case squareSquareRectButton:
            gridView.gridType = .squareSquareRect
            selectedGrid(currentButton: squareSquareRectButton)
        case squaresOnlyButton:
            gridView.gridType = .squaresOnly
            selectedGrid(currentButton: squaresOnlyButton)
        default:
            gridView.gridType = .squaresOnly
            selectedGrid(currentButton: squaresOnlyButton)
        }
    }
    
    // display of the image "selected" on the buttons
    private func selectedGrid(currentButton: UIButton) {
        // reset of states of buttons
        rectSquareSquareButton.isSelected = false
        squareSquareRectButton.isSelected = false
        squaresOnlyButton.isSelected = false
        
        // state .isSelected for one button
        currentButton.isSelected = true
        currentButton.setImage(UIImage(named: "Selected"), for: .selected)
    }
    
    // to share
    
    
}


extension ViewController: GridViewDelegate {
    func didSelectButton(_ sender: UIButton!) {
        
        // Open ImagePicker etc.
        print("ok on ouvre le PickerController")
        
        // creation d'une constante qui instancie UIImagePickerController
        let imagePickerController = UIImagePickerController()
        
        // choix du type de source pour l'image
        imagePickerController.sourceType = .photoLibrary
        
        // ViewController delegate to himself
        imagePickerController.delegate = self
        
        // Present the UIImagePickerViewController
        present(imagePickerController, animated: true, completion: nil)
        print("present(imagePickerController ***********ok")
            
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // extract image and display
        guard let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        print("l'image est : \(choosenImage)")
        
        gridView.setTheImage(image: choosenImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



