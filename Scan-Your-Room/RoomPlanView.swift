//
//  RoomPlanView.swift
//  Scan-Your-Room
//
//  Created by Nonprawich I. on 11/01/2025.
//

import SwiftUI

struct RoomPlanView: View {
    var roomController = RoomController.shared
    @State private var doneScanning: Bool = false
    @State private var showingInstructions: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Room capture view
            RoomCaptureViewRepresentable()
                .onAppear(perform: {
                    roomController.startSession()
                })
            
            VStack(spacing: 20) {
                if showingInstructions {
                    
                    VStack(spacing: 12) {
                        Text("Scan Your Room")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Move your device slowly around the room to capture its layout")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.8))
                            .shadow(radius: 10)
                    )
                    .padding(50)
                    .padding(.top, 20)
                }
                
                Spacer()
                
                if !doneScanning {
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            withAnimation {
                                roomController.stopSession()
                                doneScanning = true
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Complete Scan")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            withAnimation {
                                showingInstructions.toggle()
                            }
                        }) {
                            Image(systemName: showingInstructions ? "info.circle.fill" : "info.circle")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                
                if doneScanning {
                    ExportButton()
                        .padding(.bottom, 30)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    RoomPlanView()
}
