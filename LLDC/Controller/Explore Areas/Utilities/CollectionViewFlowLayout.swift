//
//  CollectionViewFlowLayout.swift
//  LLDC
//
//  Created by Emojiios on 25/04/2022.
//

//import UIKit

//        let flowLayout = CollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        flowLayout.itemSize = CGSize(width: 100, height: 100)
//        flowLayout.minimumLineSpacing = 1.0
//        flowLayout.minimumInteritemSpacing = 1.0

//class CollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let layoutAttributes = super.layoutAttributesForElements(in: rect)
//
//        layoutAttributes?.forEach { attribute in
//            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
//                guard let collectionView = collectionView else { return }
//                let contentOffsetY = collectionView.contentOffset.y
//
//                if contentOffsetY < 0 {
//                    let width = collectionView.frame.width
//                    let height = attribute.frame.height - contentOffsetY
//                    attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
//                }
//            }
//        }
//
//        return layoutAttributes
//    }
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//}
