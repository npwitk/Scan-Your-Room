//
//  ExportButton.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import SwiftUI

struct ExportButton: View {
    @State private var isExporting = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        Button(action: {
            isExporting = true
            RoomController.shared.exportToUSDZ { result in
                isExporting = false
                switch result {
                case .success(let url):
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        RoomController.shared.presentShareSheet(from: rootViewController, for: url)
                    }
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    showingError = true
                }
            }
        }) {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("Export")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .disabled(isExporting)
        .alert("Export Error", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
