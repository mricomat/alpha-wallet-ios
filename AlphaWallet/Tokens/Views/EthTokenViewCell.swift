// Copyright © 2018 Stormbird PTE. LTD.

import Foundation
import UIKit
import Kingfisher

class EthTokenViewCell: UITableViewCell {
    static let identifier = "EthTokenViewCell"

    private let background = UIView()
    private let titleLabel = UILabel()
    private let blockchainLabel = UILabel()
    private let separator = UILabel()
    private let issuerLabel = UILabel()
    private let blockChainTagLabel = UILabel()
    private lazy var cellSeparators = UITableViewCell.createTokenCellSeparators(height: GroupedTable.Metric.cellSpacing, separatorHeight: GroupedTable.Metric.cellSeparatorHeight)
    private let middleBorder = UIView()
    private let valuePercentageChangeValueLabel = UILabel()
    private let valuePercentageChangePeriodLabel = UILabel()
    private let valueChangeLabel = UILabel()
    private let valueChangeNameLabel = UILabel()
    private let valueLabel = UILabel()
    private let valueNameLabel = UILabel()
    private var viewsWithContent: [UIView] {
        [titleLabel, blockchainLabel, separator, issuerLabel, blockChainTagLabel, valuePercentageChangeValueLabel, valuePercentageChangePeriodLabel, valueChangeLabel, valueChangeNameLabel, valueLabel, valueNameLabel]
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(cellSeparators.topBar)
        contentView.addSubview(cellSeparators.bottomLine)

        valuePercentageChangeValueLabel.textAlignment = .center
        valuePercentageChangePeriodLabel.textAlignment = .center
        valueChangeLabel.textAlignment = .center
        valueChangeNameLabel.textAlignment = .center
        valueLabel.textAlignment = .center
        valueNameLabel.textAlignment = .center

        let bottomRowStack = [blockchainLabel, separator, issuerLabel, UIView.spacerWidth(flexible: true)].asStackView(spacing: 15)
        let footerValuesStack = [valuePercentageChangeValueLabel, valueChangeLabel, valueLabel].asStackView(distribution: .fillEqually, spacing: 15)
        let footerNamesStack = [valuePercentageChangePeriodLabel, valueChangeNameLabel, valueNameLabel].asStackView(distribution: .fillEqually, spacing: 15)
        let footerStackView = [
            middleBorder,
            .spacer(height: 14),
            footerValuesStack,
            footerNamesStack,
        ].asStackView(axis: .vertical, perpendicularContentHuggingPriority: .defaultLow)
        blockChainTagLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        blockChainTagLabel.setContentHuggingPriority(.required, for: .horizontal)
        let titleRowStack = [titleLabel, blockChainTagLabel].asStackView(axis: .horizontal, spacing: 7, alignment: .center)
        let stackView = [
            titleRowStack,
            bottomRowStack,
            .spacer(height: 14),
            footerStackView
        ].asStackView(axis: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        background.addSubview(stackView)

        NSLayoutConstraint.activate([
            blockChainTagLabel.heightAnchor.constraint(equalToConstant: Screen.TokenCard.Metric.blockChainTagHeight),

            stackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -21),
            stackView.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: background.bottomAnchor, constant: -16),

            cellSeparators.topBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellSeparators.topBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellSeparators.topBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellSeparators.bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellSeparators.bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellSeparators.bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellSeparators.bottomLine.heightAnchor.constraint(equalToConstant: GroupedTable.Metric.cellSeparatorHeight),

            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.topAnchor.constraint(equalTo: cellSeparators.topBar.bottomAnchor),
            background.bottomAnchor.constraint(equalTo: cellSeparators.bottomLine.topAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: EthTokenViewCellViewModel) {
        selectionStyle = .none
        backgroundColor = viewModel.backgroundColor

        background.backgroundColor = viewModel.contentsBackgroundColor

        contentView.backgroundColor = GroupedTable.Color.background

        titleLabel.textColor = viewModel.titleColor
        titleLabel.font = viewModel.titleFont
        titleLabel.text = "\(viewModel.amount) \(viewModel.title)"
        titleLabel.baselineAdjustment = .alignCenters

        blockChainTagLabel.textAlignment = viewModel.blockChainNameTextAlignment
        blockChainTagLabel.cornerRadius = viewModel.blockChainNameCornerRadius
        blockChainTagLabel.backgroundColor = viewModel.blockChainNameBackgroundColor
        blockChainTagLabel.textColor = viewModel.blockChainNameColor
        blockChainTagLabel.font = viewModel.blockChainNameFont
        blockChainTagLabel.text = viewModel.blockChainTag

        blockchainLabel.textColor = viewModel.subtitleColor
        blockchainLabel.font = viewModel.subtitleFont
        blockchainLabel.text = viewModel.blockChainName

        issuerLabel.textColor = viewModel.subtitleColor
        issuerLabel.font = viewModel.subtitleFont
        issuerLabel.text = viewModel.issuer

        separator.textColor = viewModel.subtitleColor
        separator.font = viewModel.subtitleFont
        separator.text = ""

        middleBorder.backgroundColor = viewModel.borderColor

        valuePercentageChangePeriodLabel.textColor = viewModel.textColor
        valuePercentageChangePeriodLabel.font = viewModel.textLabelFont
        valuePercentageChangePeriodLabel.text = viewModel.valuePercentageChangePeriod
        valueChangeNameLabel.textColor = viewModel.textColor
        valueChangeNameLabel.font = viewModel.textLabelFont
        valueChangeNameLabel.text = viewModel.valueChangeName
        valueNameLabel.textColor = viewModel.textColor
        valueNameLabel.font = viewModel.textLabelFont
        valueNameLabel.text = viewModel.valueName

        valuePercentageChangeValueLabel.textColor = viewModel.valuePercentageChangeColor
        valuePercentageChangeValueLabel.font = viewModel.textValueFont
        valuePercentageChangeValueLabel.text = viewModel.valuePercentageChangeValue
        valueChangeLabel.textColor = viewModel.textColor
        valueChangeLabel.font = viewModel.textValueFont
        valueChangeLabel.text = viewModel.valueChange
        valueLabel.textColor = viewModel.textColor
        valueLabel.font = viewModel.textValueFont
        valueLabel.text = viewModel.value

        cellSeparators.topBar.backgroundColor = GroupedTable.Color.background
        cellSeparators.topLine.backgroundColor = GroupedTable.Color.cellSeparator
        cellSeparators.bottomLine.backgroundColor = GroupedTable.Color.cellSeparator

        viewsWithContent.forEach {
            $0.alpha = viewModel.alpha
        }
    }
}
