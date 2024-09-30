//
//  LottieLayoutView.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/29/24.
//
//https://github.com/airbnb/lottie-ios/blob/master/Example/Example/LottieViewLayoutDemoView.swift
import Lottie
import SwiftUI

struct LottieLayoutView: View {
    var body: some View {
        VStack {
            Text("Desktop Animation")
            VStack {
                LottieView(animation: .named("desktop"))
                    .configure(\.contentMode, to: .scaleAspectFit)
                    .looping()
                    .frame(maxWidth: 100)
            }
            VStack {
                LottieView(animation: .named("desktop"))
                    .looping()
            }
            VStack {
                LottieView(animation: .named("desktop"))
                    .resizable()
                    .playing(loopMode: .playOnce)
            }
        }
    }
}

#Preview {
    LottieLayoutView()
}
