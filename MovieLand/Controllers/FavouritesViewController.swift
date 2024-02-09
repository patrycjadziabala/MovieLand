//
//  FavouritesViewController.swift
//  MovieLand
//
//  Created by Patka on 15/04/2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl
    private let tabRouter: TabRouterProtocol
    private let listController: ListViewController
    private let persistenceManager: PersistenceManagerProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleActivity(active: true)
        configureSegmentedControl()
        configureView()
        configureListView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.toggleActivity(active: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
        if let font = UIFont(name: Constants.showtime, size: 27) {
            self.navigationController?.setNavigationBarCustomTitle(title: Constants.favourites, font: font)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.clearNavigationBar()
    }
    
    init(tabRouter: TabRouterProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.segmentedControl = UISegmentedControl(frame: CGRect.zero)
        self.tabRouter = tabRouter
        self.listController = ListViewController(tabRouter: tabRouter, dataSource: [], navBarTitle: "")
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        segmentedControl.removeTarget(self, action: #selector(onSegmentedControlChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        view.backgroundColor = UIColor(named: Constants.customDarkBlue)
    }
    
    func configureSegmentedControl() {
        let safeArea = view.safeAreaLayoutGuide
        segmentedControl.addTarget(self, action: #selector(onSegmentedControlChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        segmentedControl.insertSegment(withTitle: Constants.people, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Constants.seen, at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: Constants.wantToSee, at: 2, animated: false)
        if let font = UIFont(name: Constants.boldfont, size: 15),
           let color = UIColor(named: Constants.customDarkPink) {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color ], for: .normal)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(white: 1, alpha: 0.05)
        segmentedControl.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
    }
    
    @objc func onSegmentedControlChanged() {
        refreshData()
    }
    
    func configureListView() {
        addChild(listController)
        view.addSubview(listController.view)
        listController.didMove(toParent: self)
        listController.view.translatesAutoresizingMaskIntoConstraints = false
        listController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        listController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func refreshData() {
        let allPersistedData = persistenceManager.persistedData
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let peopleData = allPersistedData
                .filter { model in
                    switch model {
                    case .person:
                        return true
                    default:
                        return false
                    }
                }
                .map { model in
                    return model.asListPresentable
                }
            listController.update(dataSource: peopleData)
        case 1:
            let seenData = allPersistedData
                .filter { model in
                    switch model {
                    case .seen:
                        return true
                    default:
                        return false
                    }
                }
                .map { model in
                    return model.asListPresentable
                }
            listController.update(dataSource: seenData)
        case 2:
            let wantData = allPersistedData
                .filter { model in
                    switch model {
                    case .want:
                        return true
                    default:
                        return false
                    }
                }
                .map { model in
                    return model.asListPresentable
                }
            listController.update(dataSource: wantData)
        default:
            break
        }
    }
}
