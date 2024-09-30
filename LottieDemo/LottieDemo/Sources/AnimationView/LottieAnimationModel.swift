//
//  LottieAnimationModel.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/25/24.
//

import Foundation
import UIKit

struct LottieAnimationModel {
    enum LottieUrl {
        case building
        var url: URL {
            switch self {
            case .building: return URL(string: "https://a0.muscache.com/pictures/96699af6-b73e-499f-b0f5-3c862ae7d126.json")!
            }
        }
    }
    
    enum LottieName: Equatable {
        case desktop
        case remote(LottieUrl)

        var rawValue: String {
            switch self {
            case .desktop: return "desktop"
            default:
                return ""
            }
        }

        var context: AnimationContext {
            switch self {
            case .desktop:
                return AnimationContext.local(fileName: rawValue, bundle: .main)
            case .remote(let lottie):
                return AnimationContext.remote(url: lottie.url)
            }
        }
    }

    let id = UUID().uuidString
    let name: LottieName
    let animationView: AnimationView
}

extension LottieAnimationModel: Hashable {
    static func == (lhs: LottieAnimationModel, rhs: LottieAnimationModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension LottieAnimationModel {
    func payAnimation(animationMode: AnimationMode, contentMode: UIView.ContentMode) {
        animationView.playAnimation(
            config: .init(
                context: name.context,
                animationMode: animationMode,
                contentMode: contentMode
            )
        )
    }
}
