//
//  ImageCell.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    // MARK: - Visual Components
    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configureCell(index: Int, presenter: GalleryImagesPresenter) {
        presenter.getImageData(index: index) { [weak self] data in
            DispatchQueue.main.async {
                self?.showCaseImageView.image = nil
                self?.showCaseImageView.image = UIImage(data: data)
            }
        }
    }
    
    // MARK: - Private Methods
    private func addViews() {
        addSubview(showCaseImageView)
        
        showCaseImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        showCaseImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        showCaseImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        showCaseImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
