//
//  AnimationView.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/14/24.
//

import UIKit
import Lottie

public enum AnimationContext {
    case local(fileName: String, bundle: Bundle)
    case remote(url: URL)
    case file(path: String)
}

extension AnimationContext: CustomStringConvertible {
    public var description: String {
        switch self {
        case .local(let fileName, let bundle):
            return "fileName: \(fileName), bundle: \(bundle.bundlePath)"
        case .remote(let url):
            return "remove url: \(url.absoluteString)"
        case .file(path: let path):
            return "file path: \(path)"
        }
    }
}

public enum AnimationMode {
    case loop
    case playOnce
}

public struct AnimationCofiguration {
    let context: AnimationContext
    let animationMode: AnimationMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode

    init(
        context: AnimationContext,
        animationMode: AnimationMode = .playOnce,
        animationSpeed: CGFloat = 1.0,
        contentMode: UIView.ContentMode = .scaleAspectFit
    ) {
        self.context = context
        self.animationMode = animationMode
        self.animationSpeed = animationSpeed
        self.contentMode = contentMode
    }
}

public protocol AnimationView: UIView {
    var isAnimationPlaying: Bool { get }
    func playAnimation(config: AnimationCofiguration, completion: ((Bool) -> Void)?)
    func stopAnimation()
    func resumeAnimation()
    func pauseAnimation()
    func destroyAnimation()
}

extension AnimationView {
    public func playAnimation(config: AnimationCofiguration,completion: ((Bool) -> Void)? = nil) {
        playAnimation(config: config, completion: completion)
    }
}
