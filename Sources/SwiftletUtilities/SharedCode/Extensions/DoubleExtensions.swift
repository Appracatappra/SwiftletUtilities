//
//  DoubleExtensions.swift
//  ActionUtilities
//
//  Created by Kevin Mullins on 2/27/19.
//

import Foundation

/// Adds several useful features to Doubles.
public extension Double {
    
    /**
     Returns the Double as a string formatted with the given pattern.
     
     - Parameter formatString: The pattern to format the Double into. The default pattern is `#,##0.##`.
     - Returns: The Double as a string in the given format.
     */
    func formatted(as formatString:String = "#,##0.##") -> String {
        let formatter = NumberFormatter()
        formatter.positiveFormat = formatString
        formatter.negativeFormat = formatString
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
