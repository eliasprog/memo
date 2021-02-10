//
//  CollectionsViewController.swift
//  memo
//
//  Created by Elias Ferreira on 17/08/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    // MARK: - Properties.

    let collectionsView = CollectionsView()
    let collectionRepository = CollectionRepository()
    
    var collections = [Collection]() {
        didSet {
            collectionsView.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()

        collectionsView.messageCard.isHidden = true
        collectionsView.tableView.dataSource = self
        collectionsView.tableView.delegate   = self
        collectionsView.collectionView.dataSource = self
        collectionsView.collectionView.delegate   = self

        collectionsView.collectionView.register(
            UINib.init(nibName: "StudyCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "StudyCell"
        )

        collectionsView.tableView.register(
            UINib.init(nibName: "FolderTableViewCell",bundle: nil),
            forCellReuseIdentifier: "FolderCell"
        )

    }
    
    override func viewWillAppear(_ animated: Bool) {
        collections = collectionRepository.fetchAll()
        collectionsView.tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: false
        )
        collectionsView.collectionView.scrollToItem(
            at: IndexPath(row: 0, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
    }
    
    override func loadView() {
        super.loadView()
        view = collectionsView
    }
    
    // MARK: - Funcs.
    
    func configureNavBar() {
        navigationItem.title = TabBarItems.collections.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .primaryColor

        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "SF Pro Text Bold", size: 32)!,
            NSAttributedString.Key.foregroundColor: UIColor.titleColor
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "SF Pro Text Semibold", size: 17)!,
            NSAttributedString.Key.foregroundColor: UIColor.titleColor
        ]

        let image = UIImage(systemName: "arrow.left")
        let backButton = UIBarButtonItem()
        backButton.title = ""

        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}

// MARK: - CollectionView

extension CollectionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyCell", for: indexPath) as! StudyCollectionViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicou na célula \(indexPath.row)!")
//        let reviewViewController = ReviewViewController()
//        reviewViewController.collection = self.collections[indexPath.row]
//        self.navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

// MARK: - TableView

extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sets the number of cells on tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }
    
    // Add the cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FolderCell",
            for: indexPath
        ) as! FolderTableViewCell
        
        cell.selectionStyle = .none
        cell.configure(collection: collections[indexPath.row])
        
        return cell
    }

    // When a cell is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wordListController = WordListViewController()
        wordListController.collection = collections[indexPath.row]
        navigationController?.pushViewController(wordListController, animated: true)
    }
    
}
