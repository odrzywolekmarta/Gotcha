//
//  ResizableTableView.swift
//  Gotcha
//
//  Created by Majka on 05/05/2023.
//

import Foundation
import UIKit

class ResizableTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

}
