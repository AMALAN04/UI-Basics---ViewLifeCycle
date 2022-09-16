//
//  ViewController.swift
//  SQlite basics in UI
//
//  Created by amalan-pt5585 on 16/09/22.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    lazy var textField1: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 20)
        return textField
    }()
    
    lazy var textField2: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 20)
        return textField
    }()
    
    lazy var textFieldStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    lazy var insertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(insertTapped), for: .touchUpInside)
    
        return button
    }()
    
    lazy var viewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(selectTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var textView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        textFieldStackLayout()
    }
    
    func textFieldStackLayout() {
        view.addSubview(textFieldStack)
        view.addSubview(insertButton)
        view.addSubview(textView)
        view.addSubview(viewButton)
        
        textFieldStack.addArrangedSubview(textField1)
        textFieldStack.addArrangedSubview(textField2)
        
        let constraints = [
            textFieldStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            insertButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 5),
            insertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            insertButton.widthAnchor.constraint(equalToConstant: 120),
            insertButton.heightAnchor.constraint(equalToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: insertButton.bottomAnchor, constant: 5),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.widthAnchor.constraint(equalToConstant: 220),
            textView.heightAnchor.constraint(equalToConstant: 220),
            
            viewButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5),
            viewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewButton.widthAnchor.constraint(equalToConstant: 120),
            viewButton.heightAnchor.constraint(equalToConstant: 50),

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func insertTapped() {
        print("I am at insertion work")
        let insertQuerry = "INSERT INTO TEMP (TEMPCOLUMN1, TEMPCOLUMN2) VALUES (?, ?)"
        var insertStatementQuerryPointer: OpaquePointer?
        if (sqlite3_prepare_v2( dbPointer, insertQuerry, -1, &insertStatementQuerryPointer, nil)) == SQLITE_OK {
            sqlite3_bind_text(insertStatementQuerryPointer, 1, textField1.text ?? "", -1, sqlite_transient)
            sqlite3_bind_text(insertStatementQuerryPointer, 2, textField2.text ?? "", -1, sqlite_transient)
        }
        if(sqlite3_step(insertStatementQuerryPointer)) == SQLITE_DONE {
            textField1.text = ""
            textField2.text = ""
            textField1.becomeFirstResponder()
            print("Inserted")
        } else {
            print("Error at inserting")
        }
        sqlite3_finalize(insertStatementQuerryPointer)
        
    }
    
    @objc func selectTapped() {
        print("I am at selection work")
        let selectQuerry = "SELECT TEMPCOLUMN1, TEMPCOLUMN2 FROM TEMP"
        var selectStatementQuerryPointer: OpaquePointer?
        var resultString: String = ""
        if (sqlite3_prepare_v2( dbPointer, selectQuerry, -1, &selectStatementQuerryPointer, nil)) == SQLITE_OK {
          
         while(sqlite3_step(selectStatementQuerryPointer)) == SQLITE_ROW {
             resultString += String(cString: sqlite3_column_text( selectStatementQuerryPointer, 0)) + "\t" + String(cString: sqlite3_column_text( selectStatementQuerryPointer, 1)) + "\n"
        }
            sqlite3_finalize(selectStatementQuerryPointer)
        }
        textView.text = resultString
    }

}

