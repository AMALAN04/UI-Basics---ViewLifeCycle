//
//  ViewController.swift
//  UI Basics - AboutDevice
//
//  Created by amalan-pt5585 on 24/08/22.
//

import UIKit

class ViewController: UIViewController {
    let textDisplay: UITextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemMint
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        var deviceName: String {UIDevice.current.name}
        var deviceModel: String {UIDevice.current.model}
        var identifierForVendor: UUID {UIDevice.current.identifierForVendor!}
        var batteryLevel: Float {UIDevice.current.batteryLevel}
        var localizedModel: String {UIDevice.current.localizedModel}
        var multitasking: Bool {UIDevice.current.isMultitaskingSupported}
        let about: String = "unknown = 0\n" +
                            "portrait = 1\n" +
                            "portraitUpsideDown = 2\n" +
                            "landscapeLeft = 3\n" +
                            "landscapeRight = 4\n" +
                            "faceUp = 5\n" +
                            "faceDown = 6\n"
//        var currentOrientation: Int {UIDevice.current.orientation}
        
//        let about = "Device Name   - \(deviceName)\n" +
//                     "Device Model - \(deviceModel)\n" +
//                     "id           - \(identifierForVendor)\n" +
//                     "batterLevel  - \(batteryLevel)\n" +
//                     "Multitasking - \(multitasking)\n" +
//                     "localized md - \(localizedModel)"
        textDisplay.translatesAutoresizingMaskIntoConstraints = false
        textDisplay.backgroundColor = .white
        textDisplay.textColor = .black
        textDisplay.text = about + "\nCurrentOrientation = \(UIDevice.current.orientation)"
    }
    
    func layout() {
        view.addSubview( textDisplay)
        
      //  textDisplay.frame = CGRect(x: 100, y: 100, width: 220, height: 300)
        let constraints = [
        textDisplay.widthAnchor.constraint(equalToConstant: 220),
        textDisplay.heightAnchor.constraint(equalToConstant: 220),
        textDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        textDisplay.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

