//
//  UnsupportedDeviceView.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import SwiftUI

struct UnsupportedDeviceView: View {
    var body: some View {
        ContentUnavailableView(
            "LiDAR Scanner Required",
            systemImage: "camera.fill",
            description: Text("This app requires a device with LiDAR technology, such as iPhone Pro or iPad Pro models.")
        )
    }
}

#Preview {
    UnsupportedDeviceView()
}
