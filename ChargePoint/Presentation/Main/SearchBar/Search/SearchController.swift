//
//  SearchController.swift
//  ChargePoint
//
//  Created by Javidan on 16.02.25.
//

import UIKit
import MapKit

final class SearchController: BaseController {

    let viewModel: SearchViewModel
    private var lastUserLocation: CLLocationCoordinate2D?

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        m.overrideUserInterfaceStyle = .dark
        return m
    }()
    private lazy var searchBar: UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Axtar"
        s.backgroundColor = .clear
        s.delegate = self
        return s
    }()
    private lazy var locationIcon: ReusableImage = {
        let i  = ReusableImage(imageName: "zoomin", contentMode: .scaleAspectFill, cornerRadius: 10)
        i.image = UIImage(systemName: "location.circle")
        i.tintColor = .evGreen
        i.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(zoomToUserLocation))
        i.addGestureRecognizer(tapGesture)
        return i
    }()
private lazy var reloadIcon: ReusableImage = {
    let i  = ReusableImage(imageName: "r", contentMode: .scaleAspectFill, cornerRadius: 10)
    i.image = UIImage(systemName: "arrow.clockwise.circle")
    i.tintColor = .evGreen
    i.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reloadPoints))
    i.addGestureRecognizer(tapGesture)
    return i
}()
    private lazy var zoomPlus: ReusableImage = {
        let i  = ReusableImage(imageName: "zoomin", contentMode: .scaleAspectFill, cornerRadius: 10)
        i.image = UIImage(systemName: "plus.circle")
        i.tintColor = .evGreen
        i.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(zoomInAction))
        i.addGestureRecognizer(tapGesture)
        return i
    }()
    private lazy var zoomMinus: ReusableImage = {
        let i  = ReusableImage(imageName: "zoomout", contentMode: .scaleAspectFill, cornerRadius: 10)
        i.image = UIImage(systemName: "minus.circle")
        i.tintColor = .evGreen
        i.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(zoomOutAction))
        i.addGestureRecognizer(tapGesture)
        return i
    }()
    
    private lazy var stackView: ReusableStackView = {
        let s = ReusableStackView(
            arrangedSubviews: [reloadIcon, locationIcon, zoomPlus, zoomMinus],
            alignment: .fill,
            distribution: .fillEqually,
            axis: .vertical,
            spacing: 6
        )
        return s
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc private func reloadPoints() {
        print(#function)
    }

        
    @objc private func zoomInAction() {
        var region = mapView.region
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
        mapView.setRegion(region, animated: true)    }
    
@objc private func zoomOutAction() {
    var region = mapView.region
    let maxLatitudeDelta: CLLocationDegrees = 180.0
    let maxLongitudeDelta: CLLocationDegrees = 180.0
    
    let newLatitudeDelta = region.span.latitudeDelta * 2
    let newLongitudeDelta = region.span.longitudeDelta * 2

    if newLatitudeDelta <= maxLatitudeDelta && newLongitudeDelta <= maxLongitudeDelta {
        region.span.latitudeDelta = newLatitudeDelta
        region.span.longitudeDelta = newLongitudeDelta
        mapView.setRegion(region, animated: true)
    }
}

    @objc private func zoomToUserLocation() {
        guard let location = lastUserLocation else {
            print("User location not available yet")
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    
    override func configureView() {
        super.configureView()
        view.addViews(
            view: [
                mapView,
                searchBar,
                stackView
            ]
        )
    }
    override func configureConstraints() {
        super.configureConstraints()
        searchBar.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 72, leading: 24, trailing: -24)
        )
        searchBar.anchorSize(CGSize(width: 0, height: 36))
        mapView.fillSuperview()
        stackView.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(bottom: -36, trailing: -16)
        )
        stackView.anchorSize(CGSize(width: view.frame.width/8, height: view.frame.height/4))

    }

}

extension SearchController: MKMapViewDelegate {
    
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Axtarış nəticələri yenilənir: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Klaviaturanı gizlətmək üçün
    }
}
