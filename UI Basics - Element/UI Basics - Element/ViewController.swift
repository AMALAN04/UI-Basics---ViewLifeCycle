//
//  ViewController.swift
//  UI Basics - Element
//
//  Created by amalan-pt5585 on 26/08/22.
//

import UIKit

class ViewController: UIViewController {
    let scrollView: UIScrollView = UIScrollView()
    let button: UIButton = UIButton()
    let buttonStack: UIStackView = UIStackView()
    var segment: UISegmentedControl = UISegmentedControl()
    let stepper: UIStepper = UIStepper()
    let customView: UIView = UIView()
    let imageview: UIImageView = UIImageView()
    let _switch: UISwitch = UISwitch()
    let slider: UISlider = UISlider()
    let sunImage: UIImageView = UIImageView()
    let passwordField: UITextField = UITextField()
    let eyeButton: UIButton = UIButton()
    
    let pickerField: UITextField = {
        let pickerField = UITextField()
        pickerField.translatesAutoresizingMaskIntoConstraints = false
        pickerField.placeholder = "Chose"
        pickerField.textAlignment = .center
        pickerField.backgroundColor = .white
        pickerField.layer.cornerRadius = 20
        return pickerField
    }()
    
    let Options: [String] = ["A", "B", "C"]
    
    let optionPicker: UIPickerView = {
        let optionPicker = UIPickerView()
//        optionPicker.dataSource = self
//        optionPicker.delegate = self
        return optionPicker
    }()
    
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        return toolBar
    }()
    
    let doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        return doneButton
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.addSubview(sunImage)
        navigationItem.title = "HOME"
        view.backgroundColor = .white
        scrollViewStyle()
        scrollViewLayout()
        buttonStyle()
        buttonLayout()
        
    }


}

extension ViewController {
    func scrollViewStyle(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height * 2)
        scrollView.backgroundColor = .systemMint
        
    }
    
    func scrollViewLayout() {
        view.addSubview(scrollView)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate( constraints)
    }
    
    func buttonStyle() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        buttonStack.alignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Move", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        let item = ["WHITE", "GREEN", "YELLOW"]
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment = UISegmentedControl(items: item)
        segment.backgroundColor = .white
        segment.selectedSegmentIndex = 0
        segment.selectedSegmentTintColor = .lightGray
        segment.addTarget(self, action: #selector(segmentMoved(sementControl:)), for: .valueChanged)
        
        customView.backgroundColor = .white
        customView.alpha = 0.2
        customView.layer.cornerRadius = 100
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.maximumValue = 1
        stepper.minimumValue = 0.2
        stepper.stepValue =  0.2
//        stepper.wraps = true
        stepper.addTarget(self, action: #selector(stepperActivated(stepperActive:)), for: .valueChanged)
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "image.jpg")
        imageview.layer.cornerRadius = 20
//        imageview.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
//        imageview.sizeThatFits(CGSize(width: 100, height: 200))
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 25
        
        _switch.translatesAutoresizingMaskIntoConstraints = false
        _switch.onTintColor = .black
        _switch.setOn(true, animated: true)
        _switch.addTarget(self, action: #selector(switchOperation), for: .valueChanged)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 100
        slider.minimumValue = 20
        slider.tintColor = .white
        slider.thumbTintColor = .black
        slider.minimumValueImage = UIImage(systemName:"tortoise" )
        slider.maximumValueImage = UIImage(systemName:"hare" )
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        
        sunImage.translatesAutoresizingMaskIntoConstraints = false
        sunImage.image = UIImage(systemName:"tortoise.fill")
        sunImage.tintColor = .yellow
        sunImage.contentMode = .scaleToFill
        sunImage.center = imageview.center
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.placeholder = "Password"
        passwordField.textAlignment = .center
        passwordField.backgroundColor = .white
        passwordField.layer.cornerRadius = 20
        passwordField.isSecureTextEntry = true
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget( self, action: #selector(eyeButtonTap), for: .touchUpInside)
        eyeButton.isOpaque = false
        eyeButton.alpha = 0.5
        
        toolBar.setItems([doneButton], animated: true)
        
        pickerField.inputView = optionPicker
        pickerField.inputAccessoryView = toolBar
        
        optionPicker.dataSource = self
        optionPicker.delegate = self
        
    }
    
    func buttonLayout() {
        scrollView.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(button)
        buttonStack.addArrangedSubview(segment)
        buttonStack.addArrangedSubview(customView)
        buttonStack.addArrangedSubview(stepper)
        buttonStack.addArrangedSubview(_switch)
        buttonStack.addArrangedSubview(imageview)
        buttonStack.addArrangedSubview(slider)
        buttonStack.addArrangedSubview(passwordField)
        buttonStack.addArrangedSubview(pickerField)
        
        scrollView.addSubview(eyeButton)
//        passwordField.addSubview(eyeButton)
//        passwordField.insertSubview(buttonStack, aboveSubview: passwordField)
        
        imageview.addSubview(sunImage)

        let constraints = [
            buttonStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            buttonStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            sunImage.centerXAnchor.constraint(equalTo: imageview.centerXAnchor),
            sunImage.centerYAnchor.constraint(equalTo: imageview.centerYAnchor),
//            sunImage.heightAnchor.constraint(equalToConstant: 20),
//            sunImage.widthAnchor.constraint(equalToConstant: 20),
            
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            customView.widthAnchor.constraint(equalToConstant: 100),
            customView.heightAnchor.constraint(equalToConstant: 100),
            
            segment.widthAnchor.constraint(equalToConstant: 300),
            segment.heightAnchor.constraint(equalToConstant: 40),
            
            imageview.widthAnchor.constraint(equalToConstant: 120),
            imageview.heightAnchor.constraint(equalToConstant: 200),
            
            slider.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            passwordField.widthAnchor.constraint(equalToConstant: 180),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordField.trailingAnchor.constraint(equalToSystemSpacingAfter: eyeButton.trailingAnchor, multiplier: 1),
            eyeButton.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            
            pickerField.widthAnchor.constraint(equalToConstant: 180),
            pickerField.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func buttonPressed() {
        let rootView = SecondViewController()
        rootView.displayLabel.text = "BUTTON"
        navigationController?.pushViewController(rootView, animated: true)
    }
    
    @objc func segmentMoved(sementControl: UISegmentedControl) {
        switch sementControl.selectedSegmentIndex {
        case 0: view.backgroundColor = .white
        case 1: view.backgroundColor = .systemGreen
        case 2: view.backgroundColor = .systemYellow
        default: break
        }
    }
    
    @objc func stepperActivated(stepperActive: UIStepper) {
       customView.alpha = stepperActive.value
        print(stepperActive.value)
    }
    
    @objc func switchOperation() {
        if !_switch.isOn {
            imageview.isHidden = true
            slider.isHidden = true
            return
        }
        imageview.isHidden = false
        slider.isHidden = false
    }
    
    @objc func sliderMoved() {
        print(slider.value)
        sunImage.translatesAutoresizingMaskIntoConstraints = true
  
        sunImage.bounds = CGRect(x: 0, y: 0, width: Int(slider.value), height: Int(slider.value))
    }
    
    @objc private func eyeButtonTap() {
        print("eye tapped")
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        var image = "eye"
        if passwordField.isSecureTextEntry {
         image = "eye.slash"
        }
        eyeButton.setBackgroundImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc private func donePressed() {
        pickerField.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerField.text = Options[row]
    }
    
}
