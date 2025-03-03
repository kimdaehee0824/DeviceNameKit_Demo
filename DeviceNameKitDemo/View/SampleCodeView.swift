//
//  AsyncView.swift
//  DeviceNameKitDemo
//
//  Created by 김대희 on 3/2/25.
//

import SwiftUI
import CodeEditorView
import LanguageSupport

struct SampleCodeView: View {
    private let title: String
    private let description: String

    @State private var code: String
    @State private var position: CodeEditor.Position = CodeEditor.Position()
    @State private var messages: Set<TextLocated<Message>> = Set()

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    init(model: SampleCodeModel) {
        self.code = model.code
        self.title = model.title
        self.description = model.decription
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
                .frame(height: 5)

            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
                .frame(height: 24)

            CodeEditor(
                text: $code,
                position: $position,
                messages: $messages,
                language: .swift()
            )
            .environment(
                \.codeEditorLayoutConfiguration,
                 CodeEditor.LayoutConfiguration(showMinimap: false, wrapText: true)
            )
            .environment(
                \.codeEditorTheme,
                 colorScheme == .dark ? Theme.defaultDark : Theme.defaultLight
            )
            .frame(height: 160)
            .clipShape(.rect(cornerRadius: 5))
        }
        .padding()
    }
}

#Preview {
    SampleCodeView(model: SampleCodeType.async.model())
}
