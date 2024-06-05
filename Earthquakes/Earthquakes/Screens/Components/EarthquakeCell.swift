//
//  EarhquakeCell.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI

struct EarthquakeCell: View {
    let viewModel: EarthquakeCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
            
            HStack {
                VStack(alignment: .leading) {
                    DataInfo(iconName: Icons.calendar, info: viewModel.formatedDate)
                    DataInfo(iconName: Icons.depth, info: viewModel.depth)
                }
                
                Spacer()
                
                Group {
                    Image(systemName: Icons.waves)
                    Text(viewModel.magnitude)
                }
                .font(.title)
                .foregroundStyle(viewModel.shouldBeDistinguish ? .red : .black)
            }
        }
        .frame(maxWidth: .infinity)
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
    let viewModel1 = EarthquakeCellViewModel(earthquake: PreviewHelper.smallEarthquake)
    let viewModel2 = EarthquakeCellViewModel(earthquake: PreviewHelper.bigEarthquake)
    
    return Group {
        EarthquakeCell(viewModel: viewModel1)
        EarthquakeCell(viewModel: viewModel2)
    }
}
