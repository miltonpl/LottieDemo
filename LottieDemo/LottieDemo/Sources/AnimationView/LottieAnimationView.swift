//
//  LottieAnimationView.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/14/24.
//

import UIKit
import Lottie
import os

class LottieAnimationView: UIView {
    private let animationView = Lottie.LottieAnimationView()
    private let logger = Logger()

    override init(frame: CGRect) {
          super.init(frame: frame)
        constructSubviews()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func constructSubviews() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleToFill
        addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor ),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension LottieAnimationView: AnimationView {
    var isAnimationPlaying: Bool {
        animationView.isAnimationPlaying
    }

    func playAnimation(config: AnimationCofiguration, completion: ((Bool) -> Void)?) {
        if animationView.animation != nil {
            logger.info("Stop playing animation \(config.context.description)")
            destroyAnimation()
        }
        logger.info("Playing animation")

        Task {
            guard let animation = await config.context.loadAnimation() else {
                completion?(false)
                return
            }
            await MainActor.run {
                animationView.contentMode = config.contentMode
                animationView.loopMode = config.animationMode.loopMode
                animationView.animationSpeed = config.animationSpeed
                animationView.animation = animation
                animationView.play { [weak self] completed in
                    completion?(completed)
                    self?.logger.info("Animation completed")
                }
            }
        }
    }

    func stopAnimation() {
        animationView.stop()
        logger.info("Stop animation")
    }

    func resumeAnimation() {
        animationView.stop()
        animationView.play()
        logger.info("Resume animation")
    }

    func pauseAnimation() {
        animationView.pause()
        logger.info("Pause animation")
    }

    func destroyAnimation() {
        animationView.stop()
        animationView.animation = nil
        logger.info("Destroy animation")
    }
}

extension AnimationContext {
    @MainActor
    fileprivate func loadAnimation() async -> Lottie.LottieAnimation? {
        switch self {
        case .local(let name, let bundle):
            return Lottie.LottieAnimation.named(name, bundle: bundle)
        case .remote(let url):
            return await Lottie.LottieAnimation.loadedFrom(url: url)
        case .file(let path):
            return Lottie.LottieAnimation.filepath(path)
        }
    }
}

extension AnimationMode {
    fileprivate var loopMode: Lottie.LottieLoopMode {
        switch self {
        case .loop:
            return .loop
        case .playOnce:
            return .playOnce
        }
    }
}
