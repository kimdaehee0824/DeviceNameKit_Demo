//
//  HandlerView.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import SwiftUI
import DeviceNameKit
import Combine

struct HandlerView: View {
    @State private var modelName: String = "Loading..."
    private let fetcher = DeviceNameFetcher()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                SampleCodeView(model: SampleCodeType.handler.model())

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
                        fetcher.getDeviceName { result in
                            switch result {
                            case .success(let modelName):
                                self.modelName = modelName
                            case .failure(let error):
                                self.modelName = "Error: \(error)"
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    HandlerView()
}
