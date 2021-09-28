//
//  ListViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class ListViewController: UICollectionViewController, UISearchResultsUpdating {

    private var pokemons: [Pokemon] = []
    private var resultPokemons: [Pokemon] = []

    private let searchController = UISearchController(searchResultsController: nil)

    private var isSearchBarEmpty: Bool {
      searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
      searchController.isActive && !isSearchBarEmpty
    }

    private var latestSearch: String? {
        UserDefaults.standard.string(forKey: .searchText)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        setupUI()
    }

    // MARK: Setup

    private func setup() {
        title = "Pokédex"

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .blue.withAlphaComponent(0.6)
        navbar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.prefersLargeTitles = true

        // Set up the searchController parameters.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a pokemon"
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.text = latestSearch
        navigationItem.searchController = searchController
        definesPresentationContext = true

        refresh()
    }

    private func setupUI() {

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

    private func filterContentForSearchText(_ searchText: String) {
        // store latest search
        UserDefaults.standard.set(searchText, forKey: .searchText)
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

        // TODO: Wait for all requests to finish before updating the collection view

        let group = DispatchGroup()
        group.enter()
        PokeAPI.shared.get(url: "pokemon?limit=30", onCompletion: { (list: PokemonList?, _) in
            guard let list = list else { return }
            list.results.forEach { result in
                group.enter()
                PokeAPI.shared.get(url: "/pokemon/\(result.id)/", onCompletion: { (pokemon: Pokemon?, _) in
                    guard let pokemon = pokemon else { return }
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

    private func didRefresh() {
        guard
            let collectionView = collectionView,
            let refreshControl = collectionView.refreshControl
        else { return }

        refreshControl.endRefreshing()

        updateSearchResults(for: searchController)
    }

}

extension UserDefaults {
    enum Keys: String {
        case searchText
    }
    func set(_ any: Any?, forKey key: UserDefaults.Keys) {
        self.set(any, forKey: key.rawValue)
    }
    func string(forKey key: UserDefaults.Keys) -> String? {
        self.string(forKey: key.rawValue)
    }
}
