//
//  ViewController.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/14/24.
//

import Lottie
import SwiftUI
import UIKit

// https://swiftpackageindex.com/airbnb/lottie-ios/4.5.0/documentation/lottie/lottieview

class ViewController: UIViewController {
    let buildingAnimationModel: LottieAnimationModel

    init(buildingAnimationModel: LottieAnimationModel) {
        self.buildingAnimationModel = buildingAnimationModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        constructSubviews()
        configureAnimation()
    }

    func constructSubviews() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "SwiftUI Lottie",
            style: .plain,
            target: self,
            action: #selector(presentLottieAnimationView)
        )
        navigationItem.title = "Remote Animation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Pause",
            style: .plain,
            target: self,
            action: #selector(pauseAnimation)
        )
        
    }

    func configureAnimation() {
        view.addSubview(buildingAnimationModel.animationView)
        buildingAnimationModel.animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buildingAnimationModel.animationView.topAnchor.constraint(equalTo: view.topAnchor),
            buildingAnimationModel.animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buildingAnimationModel.animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buildingAnimationModel.animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        buildingAnimationModel
            .payAnimation(animationMode: .loop, contentMode: .scaleAspectFit)
    }

    @objc
    func pauseAnimation() {
        buildingAnimationModel
            .animationView.pauseAnimation()
    }

    
    func playAnimation() {
        buildingAnimationModel
            .animationView.resumeAnimation()
    }

    @objc
    func presentLottieAnimationView() {
        let hostingController = UIHostingController(rootView: LottieLayoutView())
        present(hostingController, animated: true)
    }
}

