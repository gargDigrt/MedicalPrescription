//
//  WaitingLoader.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import UIKit

/// Singleton class for Spinning loader
class WaitingLoader {
    
    // Shared instance
    static let shared = WaitingLoader()
    // Variable
    private var hud = ProgressHUD()
    
    // Public methods
    func show(title: String = "Loading",onView view: UIView) {
        let hud = ProgressHUD(title: title)
        hud.show(view: view)
    }
    
    func hide(fromView view: UIView) {
        ProgressHUD.hide(from: view)
    }
}


/// Custom View
/// To display spinning loader
private class ProgressHUD: UIView {
    //    static let shared = ProgressHUD()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String = "Loading") {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let loaderFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let loaderView = UIView(frame: loaderFrame)
        loaderView.center = center
        loaderView.backgroundColor = UIColor(red: 235, green: 235, blue: 235, alpha: 1.0)
        loaderView.layer.cornerRadius = 5
        addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        loaderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loaderView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .darkGray
        loaderView.addSubview(spinner)
        spinner.startAnimating()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor, constant: -10).isActive = true
        
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = title
        loaderView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLbl.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 5).isActive = true
    }
    
    override func didMoveToSuperview() {
        guard let sprVW = self.superview else { return }
        leftAnchor.constraint(equalTo: sprVW.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: sprVW.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: sprVW.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: sprVW.topAnchor).isActive = true
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(view: UIView) {
        DispatchQueue.main.async {
            view.addSubview(self)
        }
    }
    
    class func hide(from view: UIView) {
        DispatchQueue.main.async {
            for subView in view.subviews {
                if subView.isKind(of: ProgressHUD.self) {
                    subView.removeFromSuperview()
                }
            }
        }
    }
}
