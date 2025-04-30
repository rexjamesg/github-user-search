//
//  UIViewExtension.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import Foundation
import UIKit

extension UIView {
    func setCircle() {
        if frame.size.width == frame.size.height {
            layer.cornerRadius = frame.size.height/2
            clipsToBounds = true
        }
    }
}
