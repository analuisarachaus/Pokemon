//
//  PokemonViewController.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import UIKit

class PokemonViewController: UIViewController {

    let viewModel = PokemonViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupNavigationBar()
        addSubviews()
        setupConstraints()
        Task {
            try await viewModel.fetch {
                Task { @MainActor in
                    tableView.reloadData()
                }
            }
        }
    }

    private func setupNavigationBar() {
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        navigationItem.setHidesBackButton(true, animated: true)
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }

}

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell {
            cell.selectionStyle = .none
            cell.viewModel = viewModel.buildViewModel(for: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as? PokemonTableViewCell
        if let imageData = cell?.viewModel?.imageData {
            let pokemonDetail = PokemonDetailViewController(pokemon: viewModel.pokemons[indexPath.row], imageData: imageData)
            navigationController?.pushViewController(pokemonDetail, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
