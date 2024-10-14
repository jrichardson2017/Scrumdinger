//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-11.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

//struct TrailingIconLabelStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        TrailingIconLabelStyle()
//    }
//}
