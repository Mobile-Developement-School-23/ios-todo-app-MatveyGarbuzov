//
//  SplashViewController.swift
//  ios-todo-app-MatveyGarbuzov
//
//  Created by Matvey Garbuzov on 17.06.2023.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
  
  private lazy var splashBGImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "SplashScreenBG")
    imageView.contentMode = .scaleToFill
    
    return imageView
  }()
  
  lazy var splashLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "logo")
    imageView.contentMode = .scaleToFill
    
    return imageView
  }()
  
  lazy var greetingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Greeting")
    imageView.contentMode = .scaleAspectFit
    imageView.alpha = 0
    
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
      self.present()
    })
  }
  
  private func present() {
    UIView.animate(withDuration: 0.9) { [self] in
      greetingImageView.transform = CGAffineTransform(translationX: 0, y: -20)
      splashLogoImageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
      greetingImageView.alpha = 1
    } completion: { _ in
      UIView.animate(withDuration: 1.4) { [self] in
        greetingImageView.alpha = 0
        splashLogoImageView.alpha = 0
        splashBGImageView.alpha = 0
        
      } completion: { done in
        if done {
          let viewController = UINavigationController(rootViewController: ViewController())
          viewController.modalTransitionStyle = .crossDissolve
          viewController.modalPresentationStyle = .fullScreen
          self.present(viewController, animated: true)
        }
      }
    }
  }
  
  private func setupConstraints() {
    view.addSubview(splashBGImageView)
    view.addSubview(splashLogoImageView)
    view.addSubview(greetingImageView)
    
    splashBGImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    splashLogoImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-50)
      make.width.height.equalTo(80)
    }
    
    greetingImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-30)
      make.width.equalToSuperview().multipliedBy(0.8)
      make.height.equalTo(100)
    }
  }
}
