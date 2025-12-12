//
//  ProgressBarView.swift
//  BBQuotes
//
//  Created by वैभव उपाध्याय on 10/12/25.
//

// Source - https://stackoverflow.com/a
// Posted by Constantin Breahna, modified by community. See post 'Timeline' for change history
// Retrieved 2025-12-10, License - CC BY-SA 4.0
import Foundation
import SwiftUI

struct ProgressBarView: View {
    
    let value: CGFloat
    let total: CGFloat
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .leading, content: {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(Capsule())
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(maxHeight: .infinity)
                    .frame(width: calculateBarWidth(contentWidth: geometry.size.width))
                    .clipShape(Capsule())
            })
            .clipped()
        })
    }
    
    private func calculateBarWidth(contentWidth: CGFloat) -> CGFloat {
        return (value / total) * contentWidth
    }
}
