//
//  PokemonDetailViewController.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    let pokemon: Pokemon
    let imageData: Data

    private lazy var imagePokemon: UIImageView = {
        let imagePokemon = UIImageView(image: UIImage(data: imageData))
        imagePokemon.translatesAutoresizingMaskIntoConstraints = false
        imagePokemon.contentMode = .scaleAspectFit
        imagePokemon.backgroundColor = .black
        imagePokemon.layer.cornerRadius = 12
        imagePokemon.layer.masksToBounds = true
        return imagePokemon
    }()

    private lazy var namePokemon: UILabel = {
        let namePokemon = UILabel()
        namePokemon.translatesAutoresizingMaskIntoConstraints = false
        namePokemon.text = pokemon.name
        namePokemon.textAlignment = .center
        namePokemon.font = .boldSystemFont(ofSize: 25)
        namePokemon.backgroundColor = .black
        namePokemon.textColor = .accent
        namePokemon.layer.cornerRadius = 12
        namePokemon.layer.masksToBounds = true
        return namePokemon
    }()

    init(pokemon: Pokemon, imageData: Data) {
        self.pokemon = pokemon
        self.imageData = imageData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        addSubview()
        setupConstraints()
    }

    private func addSubview() {
        view.addSubview(imagePokemon)
        view.addSubview(namePokemon)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            imagePokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            imagePokemon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imagePokemon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            imagePokemon.heightAnchor.constraint(equalToConstant: 230),

            namePokemon.topAnchor.constraint(equalTo: imagePokemon.bottomAnchor, constant: 100),
            namePokemon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            namePokemon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            namePokemon.heightAnchor.constraint(equalToConstant: 80),


        ])
    }

}
