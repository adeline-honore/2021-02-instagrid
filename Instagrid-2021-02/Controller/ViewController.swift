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
    var selectedButton: UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // resetting images
        gridView.refresh()
        
        // at the launch of the application the starting grid is of the style .squaresOnly
        selectedButton = squaresOnlyButton
        selectedGrid(currentButton: selectedButton)
        
        //
        gridView.delegate = self
        
        // constant to share gridView
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGridView(_:)))
        gridView.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    // to share
    
    
    
    @IBAction func dragGridView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended:
            shareGridView(gesture: sender)
        //case .cancelled:
            // on reprend le dernier aspect du collage
        default:
            break
        }
    }
    
    
    private func shareGridView(gesture: UIPanGestureRecognizer) {
        
    }
    
    
    
    // func to choose the type of the grid
    @IBAction func didSelectTypeOfGrid(_ sender: UIButton!) {
        selectTypeOfGrid(sender)
    }
    
    private func selectTypeOfGrid(_ sender: UIButton!) {
        
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
        selectedGrid(currentButton: sender)
    }
    
    // display of the image "selected" on the buttons
    private func selectedGrid(currentButton: UIButton?) {
        
        // reset of state of button ***************
        selectedButton?.isSelected = false
        
        // state .isSelected for one button *******************
        currentButton?.isSelected = true
        selectedButton = currentButton
    }
    
    // to share
    
    
    
    
}


extension ViewController: GridViewDelegate {
    func didSelectButton(_ sender: UIButton!) {
        
        // Open ImagePicker etc.
        
        // creation d'une constante qui instancie UIImagePickerController
        let imagePickerController = UIImagePickerController()
        
        // choix du type de source pour l'image
        imagePickerController.sourceType = .photoLibrary
        
        // ViewController delegate to himself
        imagePickerController.delegate = self
        
        // Present the UIImagePickerViewController
        present(imagePickerController, animated: true, completion: nil)
            
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // extract image and display
        guard let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        gridView.setTheImage(location: gridView.selectedLocation, image: choosenImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



