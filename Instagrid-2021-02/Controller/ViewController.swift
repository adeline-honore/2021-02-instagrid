//
//  ViewController.swift
//  Instagrid-2021-02
//
//  Created by adeline pc on 17/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    //  XXXXXXXXXXXXXXXXXXXX  PROPERTIES  XXXXXXXXXXXXXXXXXXXX

        
    @IBOutlet weak var gridView: GridView!
    
    // StackView buttons
    @IBOutlet weak var rectSquareSquareButton: UIButton!
    @IBOutlet weak var squareSquareRectButton: UIButton!
    @IBOutlet weak var squaresOnlyButton: UIButton!
    
    // current button in StackView to choose a grid
    var selectedButton: UIButton?
    
    
    
    @IBOutlet weak var textToSwipe: UILabel!
    @IBOutlet weak var symboleToSwipe: UILabel!
    
    /*
    var deviceOrientation: UIDeviceOrientation = .portrait {
        didSet {
            knowDeviceOrientation()
        }
    }*/
    
    //  XXXXXXXXXXXXXXXXXXXX METHODS  XXXXXXXXXXXXXXXXXXXX
    
    // -----------  VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //knowDeviceOrientation()
        //landscapeText()
        
        // at the launch of the application the starting grid is of the style .squaresOnly
        selectedButton = squaresOnlyButton
        selectedGrid(currentButton: selectedButton)
        
        //
        gridView.delegate = self
        
        
        // constant to swipe gridView
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeUp.direction = .up
        gridView.addGestureRecognizer(swipeUp)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
        gridView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
        gridView.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
           swipeDown.direction = .down
        gridView.addGestureRecognizer(swipeDown)
    }
    
    
    // ----------  METHODS : CHOICE OF A GRID TYPE
    
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
    
    
    
    // ---------- MEHODS : SHARING THE GRID
    // to share
    
    @IBAction func dragGridView(_ sender: UISwipeGestureRecognizer) {
        
        handleGesture(gesture: sender)
       
    }
    
    
    
    private func swipeGridViewWith(gesture: UISwipeGestureRecognizer) {
        
        let translation = gesture.location(in: gridView)
        
        if UIDevice.current.orientation.isPortrait == true {
            gridView.transform = CGAffineTransform(translationX: 0, y: -translation.y)
        }
        else {
            gridView.transform = CGAffineTransform(translationX: -translation.x, y: 0)
        }
        print("x transformé: \(gridView.transform.c)  y transformé:  \(gridView.transform.d)")
    }
    
    
    
    private func shareGrid() {
        
        // we put the grid back in the center
        gridGoBackToCenter()
        
        
        // creation de l'image à partager
        guard let imageToShare = gridView.asImage().jpegData(compressionQuality: 1) else {
            print("No image found")
            return
        }
        
        

        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true)
    }
    
    private func gridGoBackToCenter() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        gridView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        
        /*
         var périmètre: Int {
             get {
                 return longueur * 4
             }
             set {
                 longueur = newValue / 4
             }
         }
         
         */
    }
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        
        //print("************    \(deviceOrientation) *******************")
        if (gesture.direction == .up && UIDevice.current.orientation.isPortrait == true) || (gesture.direction == .left && UIDevice.current.orientation.isLandscape == true){
            print(UIDevice.current.orientation.rawValue)
            print("Swipe up and current orientation.isPortrait")
            swipeGridViewWith(gesture: gesture)
            shareGrid()
        }
        else {
            print("pas le bon sens pour l'orientation du device")
       }
    }
    
    
    
    
    
    
    
    
    
    /*
    private func knowDeviceOrientation() {
        print("device en mode portrait ?  \(UIDevice.current.orientation.isPortrait)")
    }*/
    
    
    
    /*
    private func landscapeText() {
        if UIDevice.current.orientation.isLandscape == true {
            textToSwipe.text = "*********"
            symboleToSwipe.text = "$$$$$$$$$"
        }
    }*/
    
}






//  X-X-X-X-X-X-X-X-X-X  EXTENSIONS  X-X-X-X-X-X-X-X-X-X



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
