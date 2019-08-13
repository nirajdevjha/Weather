//
//  Double+Extensions.swift
//  Weather
//
//  Created by Niraj Jha on 10/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree : String {
        return String(format: "%.0f°", self)
    }
}
