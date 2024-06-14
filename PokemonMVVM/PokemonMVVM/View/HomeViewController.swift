//
//  HomeViewController.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 11/06/24.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var pokebolaLogo: UIImageView = {
        let pokebolaLogo = UIImageView(image: .pokebolaLogo)
        pokebolaLogo.translatesAutoresizingMaskIntoConstraints = false
        pokebolaLogo.contentMode = .scaleAspectFill
        pokebolaLogo.layer.cornerRadius = 40
        pokebolaLogo.layer.masksToBounds = true
        return pokebolaLogo
    }()

    private lazy var pokemonButton: UIButton = {
        let pokemonButton = UIButton()
        pokemonButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonButton.setTitle("Pokemon", for: .normal)
        pokemonButton.setTitleColor(.systemYellow, for: .normal)
        pokemonButton.backgroundColor = .black
        pokemonButton.layer.cornerRadius = 20
        pokemonButton.layer.masksToBounds = true
        pokemonButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return pokemonButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow 
        addSubviews()
        setupConstraints()
    }

   @objc private func buttonPressed() {
       navigationController?.pushViewController(PokemonViewController(), animated: true)
    }

    private func addSubviews() {
        view.addSubview(pokebolaLogo)
        view.addSubview(pokemonButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            pokebolaLogo.topAnchor.constraint(equalTo: view.topAnchor),
            pokebolaLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokebolaLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokebolaLogo.heightAnchor.constraint(equalToConstant: 400),

            pokemonButton.heightAnchor.constraint(equalToConstant: 64),
            pokemonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            pokemonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            pokemonButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)

        ])
    }

}

