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
	var presenter: CollectionsPresenter
	
    // MARK: - Lifecycle.

	init(with presenter: CollectionsPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        collectionsView.messageCard.isHidden = true

        presenter.delegate = self
        collectionsView.tableView.dataSource = self
        collectionsView.tableView.delegate   = self
        collectionsView.collectionView.dataSource = self
        collectionsView.collectionView.delegate   = self

        collectionsView.collectionView.register(
            UINib.init(nibName: "StudyCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "StudyCell"
        )

        collectionsView.tableView.register(
            UINib.init(nibName: "FolderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "FolderCell"
        )

    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateData()
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

// MARK: - Presenter protocol.

extension CollectionsViewController: CollectionPresenterDelegate {
    func reloadData(value: Bool) {
        collectionsView.tableView.reloadData()
        collectionsView.collectionView.reloadData()

        collectionsView.collectionView.isHidden = !value
        collectionsView.messageCard.isHidden = value
    }
}

// MARK: - CollectionView

extension CollectionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionsToStudy.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyCell", for: indexPath) as! StudyCollectionViewCell

        cell.configure(collection: presenter.collectionsToStudy[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reviewViewController = ReviewViewController()
        reviewViewController.collection = presenter.collectionsToStudy[indexPath.row]
        self.navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

// MARK: - TableView

extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sets the number of cells on tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.collections.count
    }
    
    // Add the cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FolderCell",
            for: indexPath
        ) as! FolderTableViewCell
        
        cell.selectionStyle = .none
        cell.configure(collection: presenter.collections[indexPath.row])
        
        return cell
    }

    // When a cell is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wordListController = WordListViewController()
        wordListController.collection = presenter.collections[indexPath.row]
        navigationController?.pushViewController(wordListController, animated: true)
    }
    
}