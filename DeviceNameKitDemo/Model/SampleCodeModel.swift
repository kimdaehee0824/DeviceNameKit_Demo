//
//  SampleCodeModel.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import Foundation

enum SampleCodeType {
    case async
    case asyncThrows
    case handler
    case combine

    func model() -> SampleCodeModel {
        switch self {
        case .async:
            return .init(
                code: """
                let fetcher = DeviceNameFetcher(cachePolicy: .oneDay)

                Task {
                    let modelName = try await fetcher.getDeviceName()
                    print("Device Model Name: \\(modelName)") // Example: iPhone 15 Pro
                }
                """,
                title: "Async / Await",
                decription: "Basic Device Model Name Conversion"
            )

        case .asyncThrows:
            return .init(
                code: """
                let fetcher = DeviceNameFetcher(cachePolicy: .oneDay)
                
                Task {
                    do {
                        let modelName = try await fetcher.getDeviceName()
                        print("Device Model:", modelName)
                    } catch {
                        print("Failed to fetch device model:", error)
                    }
                }
                """,
                title: "Async / Await",
                decription: "Basic Device Model Name Conversion"
            )

        case .handler:
            return .init(
                code: """
                fetcher.getDeviceName { result in
                    switch result {
                    case .success(let modelName):
                        print("Device Model Name: \\(modelName)")
                    case .failure(let error):
                        print("Error: \\(error.localizedDescription)")
                    }
                }
                """,
                title: "Using Completion Handler",
                decription: ""
            )

        case .combine:
            return .init(
                code: """
                cancellable = fetcher.getDeviceNamePublisher()
                    .sink(receiveCompletion: { completionState in
                        if case .failure(let error) = completionState {
                            DispatchQueue.main.async { completion("Error: \\(error.localizedDescription)") }
                        }
                    }, receiveValue: { name in
                        DispatchQueue.main.async { completion(name) }
                    })
                """,
                title: "Using Combine",
                decription: "Retrieves the device model name using Combine API"
            )
        }
    }
}


struct SampleCodeModel {
    let code: String
    let title: String
    let decription: String
}
