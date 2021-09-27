//
//  ListViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class ListViewController: UICollectionViewController, UISearchResultsUpdating {

    var pokemons: [Pokemon] = []
    var resultPokemons: [Pokemon] = []

    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
      searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        setupUI()
    }

    // MARK: Setup

    func setup() {
        title = "Pokédex"

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .blue.withAlphaComponent(0.6)
        navbar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.prefersLargeTitles = true

        refresh()
    }

    func setupUI() {

        // Set up the searchController parameters.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a pokemon"
        searchController.searchBar.showsCancelButton = true
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Set up the collection view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white

        // Set up the refresh control as part of the collection view when it's pulled to refresh.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
    }

    // MARK: - UISearchViewController

    func filterContentForSearchText(_ searchText: String) {
        // filter with a simple contains searched text
        resultPokemons = pokemons
            .filter {
                searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
            }
            .sorted {
                $0.id < $1.id
            }

        collectionView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultPokemons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell
        else { preconditionFailure("Failed to load collection view cell") }
        cell.pokemon = resultPokemons[indexPath.item]
        return cell
    }

    // MARK: - Segue Management

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            fatalError()
        }

        if segue.identifier == DetailViewController.segueIdentifier {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                detailViewController.pokemon = resultPokemons[indexPath.row]
            }
        }
    }

    // MARK: - UI Hooks

    @objc func refresh() {
        var pokemons: [Pokemon] = []

        // TODO: Wait for all requests to update the collection view

        let group = DispatchGroup()
        group.enter()
        PokeAPI.shared.get(url: "pokemon?limit=30", onCompletion: { dic, _ in
            guard let results = dic?["results"] as? [JSON] else { return }

            results.forEach { json in
                guard let url = json["url"] as? String else { return }

                group.enter()
                PokeAPI.shared.get(url: url, onCompletion: { dic, _ in
                    guard let pokemon = Pokemon.decode(json: dic) else { return }
                    pokemons.append(pokemon)
                    group.leave()
                })
            }
            group.leave()
        })

        group.notify(queue: .main) {
            self.pokemons = pokemons
            self.didRefresh()
        }
    }

    func didRefresh() {
        guard
            let collectionView = collectionView,
            let refreshControl = collectionView.refreshControl
        else { return }

        refreshControl.endRefreshing()

        updateSearchResults(for: searchController)
    }

}
