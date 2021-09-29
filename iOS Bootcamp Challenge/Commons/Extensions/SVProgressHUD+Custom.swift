//
//  SVProgressHUD+Custom.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {

    static func shouldShowLoader(_ shouldShow: Bool) {
        shouldShow ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }

}
