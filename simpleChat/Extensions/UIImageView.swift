//
//  UIImageView.swift
//  simpleChat
//
//  Created by Ivan Pavic on 18.4.22..
//

import Foundation
import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
