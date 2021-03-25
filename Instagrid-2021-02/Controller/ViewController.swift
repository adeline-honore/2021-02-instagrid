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
        //gridView.refresh()
        
        // at the launch of the application the starting grid is of the style .squaresOnly
        selectedButton = squaresOnlyButton
        selectedGrid(currentButton: selectedButton)
        
        //
        gridView.delegate = self
        
        // constant to swipe gridView
        
        //let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dragGridView(_:)))
        //gridView.addGestureRecognizer(swipeGestureRecognizer)
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareGrid))

       
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
        
        deviceOrientation()
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
    
    @IBAction func dragGridView(_ sender: UISwipeGestureRecognizer) {
        print("on en essaie de déplacer la grid")
        
        swipeGridViewWith(gesture: sender)
        print(sender.direction)
        print(sender.description)
        print(sender.location(in: gridView))
        //print(sender.location(ofTouch: <#T##Int#>, in: gridView))
        print((sender.state))
        
        
        //sender.state = .changed
        /*switch sender.state {
        case .began, .changed:
            print("ça bouge")
            swipeGridViewWith(gesture: sender)
        case .ended:
            swipeGridViewWith(gesture: sender)
            print("c'est fini")
        default:
        break
        }*/
    }
    
    
    
    private func swipeGridViewWith(gesture: UISwipeGestureRecognizer) {
        
        
        let translation = gesture.location(in: gridView)
        
        //gesture.direction = .up
        
        
        gridView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        print("y: \(translation.y) et x: \(translation.x)")
        
        
        shareGrid()
        
        //gridView.center = CGPoint(x: 60, y: 30)
        
        //gridView.transform = CGAffineTransform.translatedBy(translation.x)
        
       
    }
    
    
    @objc private func shareGrid() {
        
        //
        //let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: [])
        
        //activityViewController.activityItemsConfiguration.
        
        //activityViewController.delegate = self
        
        //self.present(activityViewController, animated: true)
        
        
        
        // creation de l'image à partager
        guard let imageToShare = gridView.asImage().jpegData(compressionQuality: 1) else {
            print("No image found")
            return
        }
        
    
        

        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true)
    }
        
    
    func deviceOrientation() {
        
        if UIDevice.current.orientation.isLandscape {
            print("appareil en mode paysage")
        } else {
            print("appareil en mode portrait")
        }
    }
    
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
