//
//  UICollectionView + ViewAnimator.swift
//  ViewAnimator
//
//  Created by Marcos Griselli on 15/04/2018.
//

import Foundation
import UIKit

class CollectionAnimations : UICollectionView {


//    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
//    let zoomAnimation = AnimationType.zoom(scale: 0.2)
//    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    public let animations = [AnimationType.vector((CGVector(dx: 0, dy: ControlX(80)))),AnimationType.from(direction: .top, offset: ControlX(100))]
    
    /// VisibleCells in the order they are displayed on screen.
    var orderedVisibleCells: [UICollectionViewCell] {
        return indexPathsForVisibleItems.sorted().compactMap { cellForItem(at: $0) }
    }

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UICollectionViewCells in the argument section.

    
    func SetAnimations(_ selector: @escaping () -> Void = {}) {
        self.reloadData()
        self.performBatchUpdates({
        UIView.animate(views: self.orderedVisibleCells,
        animations: animations,duration: 0.5, options: [.curveEaseInOut],
                       completion: {
        selector()
        })
        }, completion: nil)
    }
    
    func RemoveAnimations(_ selector: @escaping () -> Void = {}) {
    UIView.animate(views: self.orderedVisibleCells,
                        animations: self.animations, reversed: true,
                        initialAlpha: 1.0,
                        finalAlpha: 0.0,
                        options: [.curveEaseIn],
                        completion: {
        selector()
    })
    }

}
