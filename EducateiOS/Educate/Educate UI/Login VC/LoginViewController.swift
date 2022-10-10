//
//  ViewController.swift
//  Educate UI
//
//  Created by amalan-pt5585 on 20/09/22.
//

import UIKit

class LoginViewController: UIViewController,  LoginViewControllerDelegate {
    
    var compactConstraints: [NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
    
    var loginVCHelper: LoginVCHelperProtocol = LoginVCHelper()
    
    lazy var educateLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "educateLogo.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        //        textLabel.largeContentTitle = "Welcome"
        textLabel.font = .preferredFont(forTextStyle: .largeTitle)
        textLabel.text = "Welcome"
        return textLabel
    }()
    
    lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .natural
        textField.placeholder = "User Id"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.autocapitalizationType = .none
        
        textField.layer.borderColor = UIColor.systemPurple.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 25
        
        //        textField.layer.shadowOpacity = 0.5
        //        textField.layer.shadowRadius = 3.0
        //        textField.layer.shadowOffset = CGSize.zero
        //        textField.layer.shadowColor = UIColor.label.cgColor
        
        textField.delegate = self
        
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .natural
        textField.placeholder = "Password"
        textField.font = .preferredFont(forTextStyle: .body)
        textField.font = .systemFont(ofSize: 20)
        textField.isSecureTextEntry =  true
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.autocapitalizationType = .none
        
        //        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.systemPurple.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 25
        
        //        textField.layer.shadowOpacity = 0.5
        //        textField.layer.shadowRadius = 3.0
        //        textField.layer.shadowOffset = CGSize.zero
        //        textField.layer.shadowColor = UIColor.label.cgColor
        
        textField.delegate = self
        
        let paddingViewLeft : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: textField.frame.height))
        let paddingViewRight : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: textField.frame.height))
        textField.leftView = paddingViewLeft
        textField.rightView = paddingViewRight
        textField.rightViewMode = UITextField.ViewMode.always
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .secondaryLabel
        button.addTarget( self, action: #selector(eyeButtonTap), for: .touchUpInside)
        button.isOpaque = false
        button.alpha = 0.5
        return button
    }()
    
    lazy var userIconView: UIImageView = {
        let iconview =  UIImageView()
        iconview.translatesAutoresizingMaskIntoConstraints = false
        iconview.image = UIImage(systemName: "person.circle")
        iconview.contentMode = .scaleAspectFit
        iconview.tintColor = .secondaryLabel
        return iconview
    }()
    
    lazy var lockIconView: UIImageView = {
        let iconview =  UIImageView()
        iconview.translatesAutoresizingMaskIntoConstraints = false
        iconview.image = UIImage(systemName: "key.fill")
        iconview.contentMode = .scaleAspectFit
        iconview.tintColor = .secondaryLabel
        return iconview
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.backgroundColor = .clear
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        button.titleLabel?.attributedText = underlineAttributedString
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.text = "Don't have account?"
        return textLabel
    }()
    
    lazy var passwordFieldWarning: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .red
        textLabel.text = "Missing necessary text field's"
        textLabel.textAlignment = .center
        textLabel.adjustsFontForContentSizeCategory = true
        textLabel.isHidden = true
        return textLabel
    }()
    
    lazy var userFieldWarning: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .red
        textLabel.text = "Missing necessary text field's"
        textLabel.textAlignment = .center
        textLabel.adjustsFontForContentSizeCategory = true
        textLabel.isHidden = true
        return textLabel
    }()
    
    lazy var signInStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing =  20
        return stackView
    }()
    
    lazy var signUpStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setDelegate()
        signinStackLayout() //shared constraints
        loadConstraints()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        //        print("Key board will show")
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let traitcollection = UIScreen.main.traitCollection
            self.view.frame.origin.y = -keyboardSize.height / 2
            
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
        //        print("Key board will hide")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
    
    func setDelegate() {
        loginVCHelper.loginVCDelegate =  self
    }
    
    func loadConstraints() {
        compactConstraints = [
            signInStack.widthAnchor.constraint(equalToConstant: 280),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            eyeButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, constant: -30),
        ]
        
        regularConstraints = [
            signInStack.widthAnchor.constraint(equalToConstant: 320),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            eyeButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, constant: -30),
        ]
    }
    
    func signinStackLayout() {
        view.addSubview(signInStack)
        view.addSubview(eyeButton)
        view.addSubview(loginButton)
        view.addSubview(educateLogoView)
        view.addSubview(passwordFieldWarning)
        view.addSubview(userFieldWarning)
        view.addSubview(signUpStack)
        
        signInStack.addArrangedSubview(userTextField)
        signInStack.addArrangedSubview(passwordTextField)
        
        signUpStack.addArrangedSubview(signUpLabel)
        signUpStack.addArrangedSubview(signUpButton)
        
        let constraints = [
            signInStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            
            loginButton.topAnchor.constraint(equalTo: signInStack.bottomAnchor, constant:  30),
            loginButton.leadingAnchor.constraint(equalTo: signInStack.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: signInStack.trailingAnchor),
            
            educateLogoView.bottomAnchor.constraint(equalTo: signInStack.topAnchor, constant: -15),
            educateLogoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            educateLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userFieldWarning.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 1),
            userFieldWarning.leadingAnchor.constraint(equalTo: signInStack.leadingAnchor),
            userFieldWarning.trailingAnchor.constraint(equalTo: signInStack.trailingAnchor),
            
            passwordFieldWarning.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1),
            passwordFieldWarning.leadingAnchor.constraint(equalTo: signInStack.leadingAnchor),
            passwordFieldWarning.trailingAnchor.constraint(equalTo: signInStack.trailingAnchor),
            
            signUpStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            signUpLabel.font = .systemFont(ofSize: 18)
            signUpButton.titleLabel?.font = .systemFont(ofSize: 18)
            print("CC - Active")
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            signUpLabel.font = .systemFont(ofSize: 18)
            signUpButton.titleLabel?.font = .systemFont(ofSize: 18)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    @objc private func eyeButtonTap() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        var image = "eye"
        if passwordTextField.isSecureTextEntry {
            image = "eye.slash"
        }
        eyeButton.setBackgroundImage(UIImage(systemName: image), for: .normal)
    }
    
    func loginFailPopUp() {
        let alert = UIAlertController(title: "Login Failed", message: "Your user id or password is incorrect.\n Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] action in
            self?.userTextField.text = nil
            self?.passwordTextField.text = nil
            self?.passwordFieldWarning.isHidden = true
            self?.userFieldWarning.isHidden = true
        }))
        present(alert, animated: true)
    }
    
    @objc private func loginTapped() {
        let loginStatus = loginVCHelper.userInputValidator()
        if loginStatus {
            UserDefaults.standard.set(true, forKey: "AlreadyLoggedIn")
            UserDefaults.standard.set(userTextField.text, forKey: "UserId")
            let rootView = MainTabBarController()
            navigationController?.pushViewController( rootView, animated: true)
        } 
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int = 0
        if textField == userTextField {
            maxLength = 30
        }
        if textField == passwordTextField {
            maxLength = 50
        }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        if newString.count >= maxLength {
            if textField == userTextField {
                userFieldWarning.text = "User Id reached maximum range"
                userFieldWarning.isHidden = false
            }
            if textField == passwordTextField {
                passwordFieldWarning.text = "Password reached maximum range"
                passwordFieldWarning.isHidden = false
            }
        } else {

            if textField == userTextField {
                userTextField.layer.borderColor = UIColor.systemPurple.cgColor
                userFieldWarning.isHidden =  true
            }
            if textField == passwordTextField {
                passwordTextField.layer.borderColor = UIColor.systemPurple.cgColor
                passwordFieldWarning.isHidden = true
            }
            
        }
        return newString.count <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

