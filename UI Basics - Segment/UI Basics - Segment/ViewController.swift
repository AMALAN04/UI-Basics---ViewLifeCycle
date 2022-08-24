//
//  ViewController.swift
//  UI Basics - Segment
//
//  Created by amalan-pt5585 on 24/08/22.
//

import UIKit
//
class ViewController: UIViewController {
    var segmentbutton = UISegmentedControl()
    var stepper: UIStepper = UIStepper()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }


}

extension ViewController {
    func style() {
        let item = ["RED", "PURPLE", "MINT"]
        segmentbutton = UISegmentedControl(items: item)
        segmentbutton.backgroundColor = .systemCyan
        segmentbutton.translatesAutoresizingMaskIntoConstraints = false
        segmentbutton.selectedSegmentIndex = 0
        view.backgroundColor = .red
        segmentbutton.addTarget(self, action: #selector(valueChanged(valeCaught:)), for: .valueChanged)

        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.maximumValue = 1
        stepper.minimumValue = 0.25
        stepper.stepValue = 0.25
        stepper.layer.isOpaque = true
//        stepper.backgroundColor = UIColor.systemCyan
        stepper.addTarget(self, action: #selector(stepperPressed(stepper:)), for: .valueChanged)
        //stepper = .white


    }

    @objc func stepperPressed(stepper: UIStepper) {
        print(stepper.value)
        view.alpha =  stepper.value

    }
    @objc func valueChanged(valeCaught: UISegmentedControl) {
        switch valeCaught.selectedSegmentIndex {
        case 0: view.backgroundColor = .red
        case 1: view.backgroundColor = .purple
        case 2: view.backgroundColor = .systemMint
        default: break
        }
    }

    func layout() {
        view.addSubview(segmentbutton)
        view.addSubview(stepper)

        let constraints = [
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: segmentbutton.bottomAnchor, multiplier: 1),
            segmentbutton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentbutton.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor ),

            stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stepper.widthAnchor.constraint(equalToConstant: 40),
            stepper.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


//class ViewController : UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let myUIStepper = UIStepper()
//
//
//        // Resume UIStepper value from the beginning
//        myUIStepper.wraps = false
//
//        // Position UIStepper in the center of the view
//        myUIStepper.center = self.view.center
//
//        // If tap and hold the button, UIStepper value will continuously increment
//        myUIStepper.autorepeat = true
//
//        // Set UIStepper max value to 10
//        myUIStepper.maximumValue = 10
//
//        // Add a function handler to be called when UIStepper value changes
//        myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
//
//        view.addSubview(myUIStepper)
//        self.view = view
//    }
//
//    @objc func stepperValueChanged(_ sender:UIStepper!)
//    {
//        print("UIStepper is now \(Int(sender.value))")
//    }
//}
