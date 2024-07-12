//
//  SwiftUIView.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 12/07/2024.
//

import SwiftUI

@available(iOS 14.0, *)
struct ScratchOffView<Content: View, Overlay: View>: View {
    private var content: Content
    private var overlayView: Overlay
    
    @State private var startingPoint: CGPoint = .zero
    @State private var points: [CGPoint] = []
    
    @GestureState private var gestureLocation = CGPoint.zero
    
    
    init(@ViewBuilder content: () -> Content, @ViewBuilder image: () -> Overlay) {
        self.content = content()
        self.overlayView = image()
    }
    
    var body: some View {
        ZStack {
            overlayView
            
            content
                .mask(
                    ScratchMask(points: points, startingPoint: startingPoint)
                        .stroke(style: .init(lineWidth: 50, lineCap: .round, lineJoin: .round))
                )
                .gesture(
                    DragGesture()
                        .updating($gestureLocation) { value, out, _ in
                            out = value.location
                            print("Yoo")
                            DispatchQueue.main.async {
                                if startingPoint == .zero {
                                    startingPoint = value.location
                                }
                                points.append(value.location)
                                print(value.location)
                            }
                        }
                )
        }
    }
}

@available(iOS 14.0, *)
fileprivate struct ScratchMask: Shape {
    var points: [CGPoint]
    var startingPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: startingPoint)
            path.addLines(points)
        }
    }
}

@available(iOS 14.0, *)
#Preview {
    ScratchOffView {
        VStack {
            Text("Hello, World!")
            Image(systemName: "globe")
        }
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    } image: {
        Color.blue
    }
    .frame(width: 240, height: 200)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    
}
