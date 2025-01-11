//
//  Scan_Your_RoomApp.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import RoomPlan
import SwiftUI

@main
struct Scan_Your_RoomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

@ViewBuilder
func checkDeviceView() -> some View {
    if RoomCaptureSession.isSupported {
        ContentView()
    } else {
        UnsupportedDeviceView()
    }
}
