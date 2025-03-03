//
//  CombineView.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import SwiftUI
import DeviceNameKit
import Combine

struct CombineView: View {
    @State private var modelName: String = "Loading..."
    @StateObject private var viewModel = CombineViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                SampleCodeView(model: SampleCodeType.combine.model())

                Text("Model Name : \(modelName)")
                    .padding()
                    #if os(iOS) || os(visionOS)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.quaternaryLabel), lineWidth: 2)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(.systemGroupedBackground))
                            )
                    )
                    #elseif os(macOS)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.quaternaryLabelColor), lineWidth: 2)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(.controlBackgroundColor))
                            )
                    )
                    #endif
                    .onAppear {
                        viewModel.fetchDeviceName() { name in
                            modelName = name
                        }
                    }
            }
        }
    }
}

final class CombineViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    private let fetcher = DeviceNameFetcher()

    func fetchDeviceName(completion: @escaping (String) -> Void) {
        cancellable = fetcher.getDeviceNamePublisher()
            .sink(receiveCompletion: { completionState in
                if case .failure(let error) = completionState {
                    DispatchQueue.main.async { completion("Error: \(error.localizedDescription)") }
                }
            }, receiveValue: { name in
                DispatchQueue.main.async { completion(name) }
            })
    }
}

#Preview {
    CombineView()
}
