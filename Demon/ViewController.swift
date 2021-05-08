//
//  ViewController.swift
//  Demon
//
//  Created by immortal on 2021/4/29
//  Copyright (c) 2021 immortal. All rights reserved.
//

import UIKit
import IMITextView

class ViewController: UIViewController {

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.tintColor = .white
        toolbar.barTintColor = .clear
        toolbar.backgroundColor = .clear
        toolbar.isTranslucent = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    private let alignBtn: UIButton = {
       let button = UIButton(type: .custom)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Alignment: Center", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
       return button
    }()

    private let lineBgdTypeBtn: UIButton = {
       let button = UIButton(type: .custom)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Style: Fill", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
       return button
    }()
    
    private let strokeBtn: UIButton = {
       let button = UIButton(type: .custom)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Stroke", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
       return button
    }()

    private let textView: IMITextView = {
        let textView = IMITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.configuration.lineBackgroundOptions = .fill
        textView.configuration.textAlignment = .center
        textView.configuration.strokeColor = .red
        textView.text = "Test Test Test Test Test\nTest Test\nTest Test Test Test"
        textView.tintColor = .red
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loadSubviews()

        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 30
        toolbar.setItems([
            UIBarButtonItem(customView: alignBtn),
            fixedSpace,
            UIBarButtonItem(customView: lineBgdTypeBtn),
            fixedSpace,
            UIBarButtonItem(customView: strokeBtn)
        ], animated: false)
        alignBtn.addTarget(self, action: #selector(didChangeAlign(_:)), for: .touchUpInside)
        lineBgdTypeBtn.addTarget(self, action: #selector(didChangeLineBgd(_:)), for: .touchUpInside)
        strokeBtn.addTarget(self, action: #selector(didChangeStroke(_:)), for: .touchUpInside)

        textView.becomeFirstResponder()
    }

    private func loadSubviews() {
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor),
            textView.heightAnchor.constraint(equalToConstant: 250.0)
        ])

        view.layoutIfNeeded()
    }

    @objc private func didChangeAlign(_ sender: UIButton) {
        textView.configuration.textAlignment = .init(rawValue: textView.configuration.textAlignment.rawValue + 1) ?? .left
        sender.setTitle("Alignment: \(String(describing: textView.configuration.textAlignment).capitalized)", for: .normal)
    }

    @objc private func didChangeLineBgd(_ sender: UIButton) {
        textView.configuration.lineBackgroundOptions = textView.configuration.lineBackgroundOptions == .fill ? .boder : .fill
        textView.configuration.textColor = textView.configuration.lineBackgroundOptions == .fill ? .black : .white
        sender.setTitle("Style: \(textView.configuration.lineBackgroundOptions == .boder ? "Boder" : "Fill")", for: .normal)
    }

    @objc private func didChangeStroke(_ sender: UIButton) {
        textView.configuration.strokeWidth = textView.configuration.strokeWidth == 0 ? 10.0 : 0.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
