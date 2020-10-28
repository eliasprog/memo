//
//  AddWordViewController.swift
//  memo
//
//  Created by Elias Ferreira on 18/08/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class AddWordViewController: UIViewController {
    
    // MARK: - Properties.
    let addWordView = AddWordView()// VIEW
    
    let repository = CollectionRepository()
    var collections = [Collection]() {
        didSet {
            self.addWordView.tableView.reloadData()
        }
    }
    weak var addWordDelegate: SaveWordDelegate?
    var wordToSave: String?
    
    // MARK: - Lifecycle.
    
    override func loadView() {
        super.loadView()
        self.view = self.addWordView
        self.addWordView.addAction = self.addButtonTapped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBar()
        //self.title = "Salvar \(self.wordToSave!)"
        
        // TextField Style
//        nameTextField.layer.cornerRadius = 10
//        nameTextField.layer.borderWidth = 1
//        nameTextField.layer.borderColor = UIColor(red: 181/255, green: 182/255, blue: 190/255, alpha: 1.0).cgColor
//        nameTextField.attributedPlaceholder = NSAttributedString(string: "Nome da Coleção", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.30)])
//        // Button Style
//        self.addButton.layer.cornerRadius = 10
//
        
        addWordView.tableView.dataSource = self
        addWordView.tableView.delegate = self
//
        addWordView.tableView.register(UINib.init(nibName: "AddWordTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionNameCell")
        self.collections = repository.fetchAll()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions.
    
    @IBAction func calcelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addButtonTapped() {
        print("Adding...")
//        if nameTextField.text != "" {
//            addWordDelegate?.save(collection: nil, collectionName: nameTextField.text!, word: self.wordToSave!)
//            self.navigationController?.popToRootViewController(animated: true)
//        }
    }
    
    // MARK: - FUNCTIONS
    
    private func configNavBar() {
        self.title = "Adicionar palavra"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - Extensions

extension AddWordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionNameCell", for: indexPath) as! AddWordTableViewCell
        cell.selectionStyle = .none
        cell.configure(name: self.collections[indexPath.row].name!)
        
        return cell
    }
    
    // When a cell is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addWordDelegate?.save(
            collection: self.collections[indexPath.row],
            collectionName: self.collections[indexPath.row].name!,
            word: self.wordToSave!
        )
        self.navigationController?.popToRootViewController(animated: true)
    }
}
