//
//  ViewController.swift
//  Instagrid-2021-02
//
//  Created by adeline pc on 17/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -PROPERTIES
    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var rectSquareSquareButton: UIButton!
    @IBOutlet weak var squareSquareRectButton: UIButton!
    @IBOutlet weak var squaresOnlyButton: UIButton!
    
    var selectedButton: UIButton?
    
    var phoneOrientation: UIDeviceOrientation {
        get {
            return UIDevice.current.orientation
        }
    }
    
    @IBOutlet weak var textToSwipe: UILabel!
    
    
    // MARK: -METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedButton = squaresOnlyButton
        selectedGrid(currentButton: selectedButton)
        
        //
        gridView.delegate = self
        
        // constant to swipe gridView
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(shareGridView(_:)))
            swipeUp.direction = .up
        gridView.addGestureRecognizer(swipeUp)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(shareGridView(_:)))
            swipeLeft.direction = .left
        gridView.addGestureRecognizer(swipeLeft)
    }
    
    // -----------  override VIEWWILLLAYOUTSUBVIEWS
    override func viewWillLayoutSubviews() {
        
        if phoneOrientation.isPortrait {
            textToSwipe.text = "Swipe up to share"
        }
        else if phoneOrientation.isLandscape {
            textToSwipe.text = "Swipe left to share"
        }
    }
    
    // ----------  METHODS : CHOICE OF A GRID TYPE
    
    // to choose the type of the grid
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
        
        // reset of state of button previously selected
        selectedButton?.isSelected = false
        
        // state .isSelected so that button is .selected
        currentButton?.isSelected = true
        selectedButton = currentButton
    }
    
    
    // ---------- MEHODS : SHARING THE GRID
    
    // to share gridView
    @IBAction func shareGridView(_ sender: UISwipeGestureRecognizer) {
        
        if gridView.isGridComplete() == false {
            print("la grid n'est pas complete")
            return
        }
        else {
            swipeGridView(sender)
        }
    }
    
    // to swipe gridView
    private func swipeGridView(_ sender: UISwipeGestureRecognizer) {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        var translationTransform = CGAffineTransform()
        
        if phoneOrientation.isPortrait {
            if sender.direction == .up {
                
                translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
                UIView.animate(withDuration: 0.8, animations: {
                    self.gridView.transform = translationTransform
                }) { (succes) in
                    if succes {
                        self.swipeBackGridView()
                    }
                }
            }
        }
        else if phoneOrientation.isLandscape{
            if sender.direction == .left {
                translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
                UIView.animate(withDuration: 0.8, animations: {
                    self.gridView.transform = translationTransform
                }) { (succes) in
                    if succes {
                        self.swipeBackGridView()
                    }
                }
            }
        }
    }
    
    
    // to share gridView
    private func shareGrid() {
        
        let imageToShare = gridView.asImage()
        
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        
        present(activityViewController, animated: true)
        
    }
    
    // return to initial position
    private func swipeBackGridView() {
        
        UIView.animate(withDuration: 0.8, animations: {
            self.gridView.transform = .identity
        }) { (succes) in
            if succes {
                self.shareGrid()
            }
        }
    }
}


//  MARK: -EXTENSIONS


extension ViewController: GridViewDelegate {
    func didSelectButton(_ sender: UIButton!) {
                
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        
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
