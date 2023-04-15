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
        
        configureSegmentedControl()
        configureView()
        configureListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData()
    }
    
    init(tabRouter: TabRouterProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.segmentedControl = UISegmentedControl(frame: CGRect.zero)
        self.tabRouter = tabRouter
        self.listController = ListViewController(tabRouter: tabRouter, dataSource: [])
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
        view.backgroundColor = .white
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
        segmentedControl.insertSegment(withTitle: "People", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Seen", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Want", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
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
        
        let intArray = [1, 2, 3, 4, 5]
        let stringArray = intArray.map { element in
            "This is number \(element)"
        }
        
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
