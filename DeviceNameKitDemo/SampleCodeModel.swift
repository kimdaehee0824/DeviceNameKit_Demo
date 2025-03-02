//
//  SampleCodeModel.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import Foundation

enum SampleCodeType {
    case async
    case handler
    case combine

    func model() -> SampleCodeModel {
        switch self {
        case .async:
            return .init(
                code: "",
                title: "",
                decription: ""
            )

        case .handler:
            return .init(
                code: "",
                title: "",
                decription: ""
            )

        case .combine:
            return .init(
                code: "",
                title: "",
                decription: ""
            )
        }
    }
}


struct SampleCodeModel {
    let code: String
    let title: String
    let decription: String
}
