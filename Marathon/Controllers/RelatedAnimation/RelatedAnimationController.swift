//
//  RelatedAnimationController.swift
//  Marathon
//
//  Created by Nikita Izosimov on 06.08.2023.
//

import UIKit

class RelatedAnimationController: UIViewController {
    
    // MARK: - Properties
    
    private static var topOffset: CGFloat = 40
    
    private var squareLeftConstraint: NSLayoutConstraint?
    private var squareWidthConstraint: NSLayoutConstraint?
    private var squareHeightConstraint: NSLayoutConstraint?
    
    private lazy var sliderConfiguration: SliderCalculation = {
        SliderCalculation(width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right)
    }()
    
    // MARK: - Views
    
    private lazy var squareView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        
        squareWidthConstraint = view.widthAnchor.constraint(equalToConstant: SliderCalculation.startSquareSize.width)
        squareWidthConstraint?.isActive = true
        
        squareHeightConstraint = view.heightAnchor.constraint(equalToConstant: SliderCalculation.startSquareSize.height)
        squareHeightConstraint?.isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var sliderView: UISlider = {
        let view = UISlider()
        
        view.minimumValue = 0
        view.maximumValue = 100
        
        view.addAction(
            UIAction(handler: { [weak self] _ in self?.sliderValueChanged() }),
            for: .valueChanged
        )
        
        view.addAction(
            UIAction(handler: { [weak self] _ in self?.sliderValueDidEnd() }),
            for: .touchUpInside
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        squareLeftConstraint = squareView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Self.topOffset),
            squareLeftConstraint,
        ].compactMap { $0 })
        
        view.addSubview(sliderView)
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Self.topOffset + SliderCalculation.endSquareSize.height + 20),
            sliderView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            sliderView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ])
    }
    
    // MARK: - Actions
    
    private func sliderValueChanged(with duration: TimeInterval = 0.1) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.beginFromCurrentState, .allowUserInteraction]) { [weak self] in
                guard let self else { return }
                
                squareLeftConstraint?.constant = sliderConfiguration.squareLeftConstaint(from: sliderView.value)
                
                let squareSize = sliderConfiguration.squareSize(from: sliderView.value)
                squareWidthConstraint?.constant = squareSize.width
                squareHeightConstraint?.constant = squareSize.height
                
                squareView.transform = CGAffineTransformMakeRotation(sliderConfiguration.squareRotationAngle(from: sliderView.value))
                
                view.layoutIfNeeded()
            }
    }
    
    private func sliderValueDidEnd() {
        guard sliderView.value != 0 else { return }
        
        sliderView.setValue(100, animated: true)
        sliderValueChanged(with: 0.3)
    }
}

extension RelatedAnimationController {
    
    struct SliderCalculation {
        
        static var startSquareSize = CGSize(width: 80, height: 80)
        static var endSquareSize = CGSize(width: 120, height: 120)
        
        static var startAngle: CGFloat = 0
        static var endAngle = CGFloat.pi / 2
        
        let width: CGFloat
        
        func squareLeftConstaint(from value: Float) -> CGFloat {
            let viewMaxConstaint = width - Self.endSquareSize.width
            
            return CGFloat(Float(viewMaxConstaint) / Float(100) * value)
        }
        
        func squareSize(from value: Float) -> CGSize {
            let rangeMinMax = Float(Self.endSquareSize.width - Self.startSquareSize.width)
            
            let width = (rangeMinMax / Float(100) * value) + Float(Self.startSquareSize.width)
            
            return .init(width: Int(width), height: Int(width))
        }
        
        func squareRotationAngle(from value: Float) -> Double {
            Double(Self.endAngle / CGFloat(100) * CGFloat(value))
        }
    }
}
