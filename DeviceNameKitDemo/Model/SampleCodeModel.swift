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
                description: "// Fetches the device model name asynchronously using Swift Concurrency (async/await). This method ensures non-blocking execution."
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
                title: "Async / Await with Error Handling",
                description: "// Uses async/await with a do-catch block to handle potential errors while fetching the device model name."
            )

        case .handler:
            return .init(
                code: """
                let fetcher = DeviceNameFetcher(cachePolicy: .oneDay)
                
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
                description: "// Fetches the device model name using a completion handler. This approach is useful for compatibility with older Swift versions."
            )

        case .combine:
            return .init(
                code: """
                let fetcher = DeviceNameFetcher(cachePolicy: .oneDay)

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
                description: "// Fetches the device model name using Apple's Combine framework for reactive programming. Provides a publisher that emits the result asynchronously."
            )
        }
    }
}

struct SampleCodeModel {
    let code: String
    let title: String
    let description: String
}
