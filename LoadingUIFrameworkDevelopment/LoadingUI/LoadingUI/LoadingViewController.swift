//
//  LoadingViewController.swift
//  LoadingUI
//
//  Created by Shawn Gee on 4/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

public class LoadingViewController: UIViewController {

    public enum Size: CGFloat {
        case small = 0.2
        case medium = 0.4
        case large = 0.6
    }
    
    // MARK: - Public Properties
    
    public var ringColor: UIColor = .systemBlue { didSet { loadingView?.strokeColor = ringColor }}
    public var ringSize: Size = .small { didSet { setWidthConstraint() }}
    
    // MARK: - Private Properties
    
    private var loadingView: IndeterminateLoadingView?
    private var widthConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoadingView()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingView?.startAnimating()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingView?.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func setUpLoadingView() {
        loadingView = IndeterminateLoadingView(frame: .zero)
        
        guard let loadingView = loadingView else { return }
        loadingView.strokeColor = ringColor
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingView)
        
        setWidthConstraint()
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loadingView.heightAnchor.constraint(equalTo: loadingView.widthAnchor),
        ])
    }
    
    private func setWidthConstraint() {
        guard let loadingView = loadingView else { return }
        let newWidthConstraint = loadingView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: ringSize.rawValue)
        widthConstraint?.isActive = false
        newWidthConstraint.isActive = true
        widthConstraint = newWidthConstraint
    }
}
