//
//  CurrenciesTableViewCell.swift
//  Crypto
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import Kingfisher
import UIKit

final class CurrenciesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var innerContainerView: UIView!
    @IBOutlet private weak var coinImageContainerView: UIView!
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet private weak var currentPriceLabel: UILabel!
    @IBOutlet private weak var highestPriceLabel: UILabel!
    @IBOutlet private weak var lowestPriceLabel: UILabel!

    private var coinIconDownloadTask: DownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinIconDownloadTask?.cancel()
    }
    
    func configure(with coin: Coin) {
        coinNameLabel.text = coin.name
        coinSymbolLabel.text = coin.symbol
        currentPriceLabel.text = coin.currentPriceFormatted
        highestPriceLabel.text = coin.highestPriceFormatted
        lowestPriceLabel.text = coin.lowestPriceFormatted
        fetchCoinIcon(with: coin.pngUrl)
    }
    
    private func setup() {
        containerView.addShadow
        innerContainerView.addRoundCorners
        coinImageContainerView.addShadow
        coinImageView.addRoundCorners
    }
    
    private func fetchCoinIcon(with url: URL?) {
        guard let url = url else { return }
        let resource = ImageResource(downloadURL: url)
        coinIconDownloadTask = coinImageView.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil) { _ in }
    }
    
}
