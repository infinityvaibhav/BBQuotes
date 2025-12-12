//
//  StringExtension.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 09/12/25.
//

extension String {
    
    var removeSpaces: Self {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    var removeCaseAndSpace: Self {
        self.removeSpaces.lowercased()
    }
}
