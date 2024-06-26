//
//  EarthquakeListView.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI

struct EarthquakeListView: View {
    @StateObject private var viewModel = EarthquakeListViewModel()
    @State private var path: [Earthquake] = []
    
    var body: some View {
        ZStack {
            earthquakeList
            if viewModel.isFetchingData {
                progressView
            }
        }
        .alert("Oops",
               isPresented: $viewModel.shouldDisplayAlert,
               presenting: viewModel.apiError) { _ in
        } message: { error in
            Text(error.localizedDescription)
        }
        .onAppear(perform: {
            Task {
                await viewModel.fetchData()
            }
        })
    }
    
    private var progressView: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            ProgressView("Fetching data...")
                .progressViewStyle(
                    CircularProgressViewStyle(tint: .orange)
                )
        }
    }
    
    @ViewBuilder
    private var earthquakeList: some View {
        if !viewModel.isFetchingData && viewModel.earthquakes.isEmpty {
            Text("No earthquake data")
                .font(.title)
        } else {
            NavigationStack {
                List() {
                    ForEach(viewModel.earthquakes, id: \.self) { earthquake in
                        NavigationLink(value: earthquake) {
                            let cellViewModel = EarthquakeCellViewModel(earthquake: earthquake)
                            EarthquakeCell(viewModel: cellViewModel)
                        }
                    }
                }
                .listStyle(.plain)
                .clipped()
                .edgesIgnoringSafeArea(.bottom)
                .navigationTitle("Earthquake List")
                .navigationDestination(for: Earthquake.self) { earthquake in
                    let mapViewModel = EarthquakeMapViewModel(coordinates: earthquake.coordinates)
                    EarthquakeMapDetail(viewModel: mapViewModel)
                }
            }
        }
    }
}

#Preview {
    EarthquakeListView()
}
