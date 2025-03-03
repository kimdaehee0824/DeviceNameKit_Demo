//
//  AsyncView.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import SwiftUI
import DeviceNameKit

struct AsyncView: View {
    @State private var modelName: String = "Loading..."
    private let fetcher = DeviceNameFetcher(cachePolicy: .forever)

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    SampleCodeView(model: SampleCodeType.async.model())
                    SampleCodeView(model: SampleCodeType.asyncThrows.model())
                }

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
                    .task {
                        modelName = await fetcher.getDeviceNameOrDefault()
                    }

                Spacer()
            }
        }
    }
}

#Preview {
    AsyncView()
}
