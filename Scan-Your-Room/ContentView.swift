//
//  ContentView.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                Image(systemName: "square.split.bottomrightquarter")
                    .font(.system(size: 80))
                    .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(.top, 60)
                    .padding(.bottom, 30)
                
                Text("Scan Your Room")
                    .font(.system(size: 36, weight: .bold))
                    .padding(.bottom, 8)
                
                Text("Create 3D models of your space")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 20) {
                    FeatureRow(icon: "camera.fill", title: "LiDAR Scanner", description: "Uses advanced LiDAR technology for precise measurements")
                    
                    FeatureRow(icon: "hare.fill", title: "Quick Scanning", description: "Capture your room in minutes")
                    
                    FeatureRow(icon: "square.3.layers.3d.down.right", title: "3D Results", description: "Get detailed 3D models of your space")
                }
                .padding(25)
                
                Spacer()
                
                NavigationLink(destination: RoomPlanView()) {
                    HStack {
                        Text("Start Scanning")
                            .font(.headline)
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                Text("Requires an iOS device with LiDAR Scanner")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
