//
//  ColumnFlowLayout.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    private let preferedSize: CGSize = .init(width: 140, height: 100)
    private let preferedSpacing: CGFloat = 4

    // MARK: Layout Overrides

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        minimumInteritemSpacing = preferedSpacing

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / preferedSize.width)
        let cellWidth = floor(availableWidth / CGFloat(maxNumColumns))

        itemSize = CGSize(width: cellWidth, height: preferedSize.height)
        sectionInset = UIEdgeInsets(top: preferedSpacing * 2,
                                    left: preferedSpacing,
                                    bottom: preferedSpacing,
                                    right: preferedSpacing)
        sectionInsetReference = .fromSafeArea

    }
}
