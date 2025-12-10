//
//  CoinsListViewController.swift
//  MarketingCoins
//
//  Created by Gabriel Felix on 31/10/25.
//

import UIKit

protocol CoinsListDisplayLogic: AnyObject {
    func displayGlobalValues(viewModel: CoinsList.FetchGlobalValues.ViewModel)
    func displayListCoins(viewModel: CoinsList.FetchCoinsList.ViewModel)
    func displayError(error: String)
}

class CoinsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalViewModel?.globalValues.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("🧩 Carregando célula Global \(indexPath.row)")
        
        guard let viewModel = globalViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "GlobalValuesViewCell",
                for: indexPath
              ) as? GlobalValuesViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.globalValues[indexPath.row])
        return cell
    }
    
    // MARK: - Outlets
    @IBOutlet weak var globalCollectionView: UICollectionView! {
        didSet {
            globalCollectionView.delegate = self
            globalCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var coinListTableView: UITableView! {
        didSet {
            coinListTableView.delegate = self
            coinListTableView.dataSource = self
        }
    }
    
    // MARK: - Filter View (novo)
    private lazy var coinsFilterView: FiltersView = {
        let filterView = FiltersView()
        filterView.isHidden = true
        filterView.delegate = self
        return filterView
    }()
    
    // MARK: - Properties
    private var globalViewModel: CoinsList.FetchGlobalValues.ViewModel?
    private var coinsViewModel: CoinsList.FetchCoinsList.ViewModel?
    
    var interactor: CoinsListBusinessLogic?
    var router: (NSObjectProtocol & CoinsListRoutingLogic & CoinsListDataPassing)?
    
    // MARK: - Init / Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = CoinsListInteractor()
        let presenter = CoinsListPresenter()
        let router = CoinsListRouter()
        
        self.interactor = interactor
        self.router = router
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(coinsFilterView)
        
        let nib = UINib(nibName: CoinHeaderView.identifier, bundle: nil)
        coinListTableView.register(nib,
            forHeaderFooterViewReuseIdentifier: CoinHeaderView.identifier
        )
        
        doFetchGlobalValues()
        doFetchCoinsList()
        
        interactor?.doFetchGlobalValues(
            request: CoinsList.FetchGlobalValues.Request(baseCoin: "brl")
        )
    }
    
    // MARK: - Fetch Methods
    func doFetchGlobalValues() {
        print("🔵 ViewController: Chamando interactor doFetchGlobalValues()")
        let request = CoinsList.FetchGlobalValues.Request(baseCoin: "brl")
        interactor?.doFetchGlobalValues(request: request)
    }
    
    func doFetchCoinsList(pricePercentage: String = "1h") {
        print("🟢 ViewController: Chamando interactor doFetchListCoins(\(pricePercentage))")
        let request = CoinsList.FetchCoinsList.Request(
            baseCoin: "brl",
            orderBy: "market_cap_desc",
            top: 10,
            pricePercentage: pricePercentage
        )
        interactor?.doFetchListCoins(request: request)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coinsFilterView.isHidden = false
    }
}

// MARK: - Display Logic
extension CoinsListViewController: CoinsListDisplayLogic {
    
    func displayGlobalValues(viewModel: CoinsList.FetchGlobalValues.ViewModel) {
        print("📊 displayGlobalValues chamado com \(viewModel.globalValues.count) itens")
        globalViewModel = viewModel
        
        DispatchQueue.main.async {
            self.globalCollectionView.reloadData()
        }
    }
    
    func displayListCoins(viewModel: CoinsList.FetchCoinsList.ViewModel) {
        print("🖥 ViewController recebeu \(viewModel.coins.count) moedas")
        coinsViewModel = viewModel
        
        DispatchQueue.main.async {
            self.coinListTableView.reloadData()
        }
    }
    
    func displayError(error: String) {
        print("❌ Erro:", error)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CoinsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CoinHeaderView.identifier
        ) as? CoinHeaderView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return coinsViewModel?.coins.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let viewModel = coinsViewModel,
              let cell = tableView.dequeueReusableCell(
                withIdentifier: CoinViewCell.identifier,
                for: indexPath
              ) as? CoinViewCell else {
            return UITableViewCell()
        }
        
        let coin = viewModel.coins[indexPath.row]
        
        cell.rankLabel.text = coin.rank
        
        if let url = URL(string: coin.iconUrl) {
            cell.iconImageView.loadImage(from: url)
        }
        
        cell.symbolLabel.text = coin.symbol
        cell.priceLabel.text = coin.price
        cell.percentageLabel.text = coin.priceChangePercentage
        cell.marketCapitalizationLabel.text = coin.marketCapitalization
        
        return cell
    }
}

// MARK: - Filters Delegate
extension CoinsListViewController: ToolBarFilterViewDelegate {

    func didSelectFilter(_ value: String) {
        print("🔎 Filtro escolhido:", value)

        coinsFilterView.isHidden = true
        
        // Aqui você usa como quiser
        doFetchCoinsList(pricePercentage: value)
    }

    func cancelFilter(for filtersView: FiltersView) {
        filtersView.isHidden = true
    }
}
