//
//  DataInfo.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI

struct DataInfo: View {
    let iconName: String
    let info: String
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: iconName)
            Text(info)
        }
        .font(.subheadline)
    }
}

#Preview {
    DataInfo(iconName: "pencil", info: "Hello")
}
