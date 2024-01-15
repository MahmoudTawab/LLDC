//
//  ExtensionScrollView.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit

extension UIScrollView {
    func updateContentViewSize(_ spasing:CGFloat) {
        DispatchQueue.main.async {
        var newHeight: CGFloat = 0
            for view in self.subviews {
            let ref = view.frame.origin.y + view.frame.height
            if ref > newHeight {
                newHeight = ref
            }
        }
        let oldSize = self.contentSize
        let newSize = CGSize(width: oldSize.width, height: newHeight + spasing)
        self.contentSize = newSize
        }
    }
}
