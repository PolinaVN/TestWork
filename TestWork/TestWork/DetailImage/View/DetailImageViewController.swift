//
//  DetailImageViewController.swift
//  TestWork
//
//  Created by on 09.03.2022.
//

import UIKit

final class DetailImageViewController: UIViewController {
    
    // MARK: - Visual Components
    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public Properties
    var presenter: DetailImagePresenter?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addViews()
        setAnchors()
        showTitleDetailsImage()
    }
    
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(showCaseImageView)
        view.addSubview(titleLabel)
    }
    
    private func setAnchors() {
        var height = CGFloat(presenter?.height ?? 0)
        var width = CGFloat(presenter?.width ?? 0)
        if height >= view.bounds.height - 100 {
            height = height/1.2
            width = width/1.2
        }
        
        showCaseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showCaseImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        showCaseImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        showCaseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    private func showTitleDetailsImage() {
        titleLabel.text = presenter?.title
    }
}

// MARK: - DetailImageView
extension DetailImageViewController: DetailImageView {
    
    func reload(data: Data) {
        showCaseImageView.image = UIImage(data: data)
    }
}
