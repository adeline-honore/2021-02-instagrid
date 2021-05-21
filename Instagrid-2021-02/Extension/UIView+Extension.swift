//
//  UIView+Extension.swift
//  Instagrid-2021-02
//
//  Created by HONORE Adeline on 20/04/2021.
//

import UIKit

// MARK: -EXTENSIONS

// to create an image from UIView
extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
