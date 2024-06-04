//
//  EarhquakeCell.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI

struct EarthquakeCell: View {
    let data: Earthquake
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(data.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                
                HStack(spacing: 20) {
                    DataInfo(iconName: Icons.calendar, info: "\(data.time)")
                    DataInfo(iconName: Icons.depth, info: "\(data.coordinates.depth)")
                }
            }
            .frame(maxWidth: .infinity)
            
            Group {
                Image(systemName: Icons.waves)
                Text("\(data.magnitude)")
            }
            .font(.title)
            .foregroundStyle(data.magnitude > 7.5 ? .red : .black)
        }
        .padding()
    }
}

private extension EarthquakeCell {
    struct Icons {
        static let waves = "dot.radiowaves.left.and.right"
        static let calendar = "calendar"
        static let depth = "arrowshape.down.fill"
    }
}

#Preview {
    Group {
        EarthquakeCell(data: PreviewHelper.smallEarthquake)
        EarthquakeCell(data: PreviewHelper.bigEarthquake)
    }
}
