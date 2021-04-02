//
//  ViewController.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import Foundation
import UIKit
import Combine
import RxCocoa
import RxSwift
import SwiftUI

class TestViewController: UIViewController {

    private let openSwiftuiButton = configure(UIButton()) {
        $0.setTitle("SwiftUI", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .left
        $0.setTitleColor(.darkGray, for: .highlighted)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }

    private let openUiKitButton = configure(UIButton()) {
        $0.setTitle("UIKit", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .left
        $0.setTitleColor(.darkGray, for: .highlighted)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }

    private var cancellable = Set<AnyCancellable>()

    let viewModel = WorkingDayViewModel()

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addSubviews()
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }

    private func updateFrames() {
        openSwiftuiButton.frame = CGRect(x: view.center.x - 150, y: view.center.y - 100, width: 300, height: 50)
        openUiKitButton.frame = CGRect(x: view.center.x - 150, y: view.center.y, width: 300, height: 50)
    }

    private func addSubviews() {
        view.addSubview(openSwiftuiButton)
        view.addSubview(openUiKitButton)
    }

    private func bind() {
        // RxCocoa предоставляет нам приятные привязки к UIKit-объектам без лишних манипуляций
        //        openSwiftuiButton.rx.tap
        //            .subscribe(
        //                onNext: { _ in
        //
        //                }
        //            )
        //            .disposed(by: disposeBag)

        // Из коробки Combine не предоставляет никаких возможностей по привязке к UIKit-объектам.
        openSwiftuiButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self = self else {
                    return
                }

                let vc = UIHostingController(rootView: SUIView(model: self.viewModel))

                self.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellable)

        openUiKitButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self = self else {
                    return
                }

                let vc = UIHostingController(rootView: SUIView(model: self.viewModel))
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellable)
    }
    
}
