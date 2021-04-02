//
//  UIKitViewController.swift
//  Mvvm
//
//  Created by Mad Brains on 02.04.2021.
//

import UIKit
import Combine

class UIKitViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!

    let viewModel: WorkingDayViewModel

    private var cancellable = Set<AnyCancellable>()

    init(viewModel: WorkingDayViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.text = viewModel.currentDayType.title
        bind()
    }

    private func bind() {
        textField.textPublisher
           .assign(to: \.inputDate, on: viewModel)
           .store(in: &cancellable)

        viewModel.$currentDayType
            .sink { [weak self] in
                self?.resultLabel.text = $0.title
            }
            .store(in: &cancellable)
    }

}
