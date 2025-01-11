//
//  RoomController.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import RoomPlan
import SwiftUI

class RoomController: RoomCaptureViewDelegate {
    
    func encode(with coder: NSCoder) { // need this 1/2 to conform to NSCoding
        fatalError("Not Needed")
    }
    
    required init?(coder: NSCoder) { // need this 2/2 to conform to NSCoding
        fatalError("Not Needed")
    }
    
    static var shared = RoomController()
    var captureView: RoomCaptureView
    var sessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    var finalResult: CapturedRoom? // Results of the room scanning and analysis process carried out by RoomPlan
    
    var onExportSuccess: ((URL) -> Void)?
    var onExportError: ((Error) -> Void)?
    
    init() { // ensure that captureView and its delegates are set correctly from the start
        captureView = RoomCaptureView(frame: .zero)
        captureView.delegate = self
    }
    
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: (Error)?) -> Bool {
        return true
    }
    
    
    func captureView(didPresent processedResult: CapturedRoom, error: (Error)?) {
        finalResult = processedResult
    }
    
    // to start scanning
    func startSession() {
        captureView.captureSession.run(configuration: sessionConfig)
    }
    
    // to stop session
    func stopSession() {
        captureView.captureSession.stop()
    }
    
    enum ExportError: Error {
        case noDataAvailable
        case exportFailed
        case fileCreationFailed
        
        var description: String {
            switch self {
            case .noDataAvailable:
                return "No room scan data available to export"
            case .exportFailed:
                return "Failed to export room data"
            case .fileCreationFailed:
                return "Failed to create export file"
            }
        }
    }
    
    func exportToUSDZ() async throws -> URL {
        guard let capturedRoom = finalResult else {
            throw ExportError.noDataAvailable
        }
        
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let exportURL = temporaryDirectoryURL.appendingPathComponent("RoomScan_\(timestamp).usdz")
        
        do {
            try capturedRoom.export(to: exportURL)
            return exportURL
        } catch {
            throw ExportError.exportFailed
        }
    }
    
    func exportToUSDZ(completion: @escaping (Result<URL, Error>) -> Void) {
        Task {
            do {
                let url = try await exportToUSDZ()
                DispatchQueue.main.async {
                    completion(.success(url))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func presentShareSheet(from viewController: UIViewController, for url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                                  y: viewController.view.bounds.midY,
                                                  width: 0,
                                                  height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        viewController.present(activityViewController, animated: true)
    }
}

struct RoomCaptureViewRepresentable: UIViewRepresentable { //allowing us to use RoomCaptureView (which comes from UIKit) inside SwiftUI.
    
    func makeUIView(context: Context) -> RoomCaptureView{
        RoomController.shared.captureView
    }
    
    func updateUIView(_ uiView: RoomCaptureView, context: Context) {
        
    }
}
