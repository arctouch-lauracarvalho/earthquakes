//
//  EarthquakeListView.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI

struct EarthquakeListView: View {
    @StateObject private var viewModel = EarthquakeListViewModel(earthquakeClient: EarthquakesClient(host: URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7")!,
                                                                                                     networkSession: URLSession.shared))
    
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
            List() {
                ForEach(viewModel.earthquakes, id: \.self) { earthquake in
                    let cellViewModel = EarthquakeCellViewModel(earthquake: earthquake)
                    EarthquakeCell(viewModel: cellViewModel)
                }
            }
            .listStyle(.plain)
            .clipped()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    EarthquakeListView()
}
