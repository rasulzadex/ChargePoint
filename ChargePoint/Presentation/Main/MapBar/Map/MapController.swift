    //
    //  MapController.swift
    //  ChargePoint
    //
    //  Created by Javidan on 16.02.25.
    //

    import UIKit
    import MapKit

final class MapController: BaseController {
    
    //MARK: - UI Elements
    
    //MARK: - Properties
        let manager = CLLocationManager()
        private var lastUserLocation: CLLocationCoordinate2D?
        private let viewModel: MapViewModel
      
    //MARK: - init
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
       
        
        private lazy var mapView: MKMapView = {
            let m = MKMapView()
            m.delegate = self
            m.overrideUserInterfaceStyle = .dark
            return m
        }()
        
        private lazy var loadingView = UIActivityIndicatorView().withUsing {
            $0.style = .large
            $0.color = .evTurquoise
        }
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
            managerAccess()
            configureViewModel()
            getPoints()
          
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            setInitialMapRegion()
        }

        private func getPoints() {
            viewModel.getTouchPoints()
            viewModel.getSocarPoints()
            viewModel.getGofarPoints()
            viewModel.getVoltPoints()
            viewModel.getEnrgPoints()
            viewModel.getChargePoints()
            viewModel.getTokPoints()
        }
    
        private func addTouchStationPins(stations: [TouchData]) {
            var coordinates: [CLLocationCoordinate2D] = []
            for station in stations {
                guard let lat = Double(station.latitude), let lon = Double(station.longitude) else {
                    print("Invalid coordinates for station: \(station.name)")
                    continue
                }
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                coordinates.append(coordinate)

                let pin = CustomPinAnnotation(
                    coordinate: coordinate,
                    title: "Touch EDM",
                    subtitle: station.name,
                    imageName: "newTouchPin",
                    dataSource: station
                )
                mapView.addAnnotation(pin)
            }

            guard !coordinates.isEmpty else { return }
        }
        private func addVoltStationPins(stations: [VoltResult]) {
            var coordinates: [CLLocationCoordinate2D] = []
            for station in stations {
                guard let lat = station.latitude, let lon = station.longitude else {
                    print("Invalid coordinates for station: \(station.name)")
                    continue
                }
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                coordinates.append(coordinate)

                let pin = CustomPinAnnotation(
                    coordinate: coordinate,
                    title: "Volt EDM",
                    subtitle: station.name,
                    imageName: "newVoltPin",
                    dataSource: station
                )
                mapView.addAnnotation(pin)
            }

            guard !coordinates.isEmpty else { return }
        }
        private func addChargeStationPins(stations: [ChargeResult]) {
        var coordinates: [CLLocationCoordinate2D] = []
        for station in stations {
            guard let lat = station.latitude, let lon = station.longitude else {
                print("Invalid coordinates for station: \(station.name)")
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            coordinates.append(coordinate)

            let pin = CustomPinAnnotation(
                coordinate: coordinate,
                title: "Charge EDM",
                subtitle: station.name,
                imageName: "newChargePin",
                dataSource: station
            )
            mapView.addAnnotation(pin)
        }
        guard !coordinates.isEmpty else { return }
    }
    private func addTokStationPins(stations: [TokResult]) {
        var coordinates: [CLLocationCoordinate2D] = []
        for station in stations {
            guard let lat = station.latitude, let lon = station.longitude else {
                print("Invalid coordinates for station: \(station.name)")
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            coordinates.append(coordinate)
            
            let pin = CustomPinAnnotation(
                coordinate: coordinate,
                title: "Tok EDM",
                subtitle: station.name,
                imageName: "newTokPin",
                dataSource: station
            )
            mapView.addAnnotation(pin)
        }
        guard !coordinates.isEmpty else { return }
    }
        private func addSocarStationPins(stations: [SocarResult]) {
            var coordinates: [CLLocationCoordinate2D] = []
            for station in stations {
                guard let lat = station.latitude, let lon = station.longitude else {
                    print("Invalid coordinates for station: \(station.name ?? "Unknown")")
                    continue
                }
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                coordinates.append(coordinate)

                let pin = CustomPinAnnotation(
                    coordinate: coordinate,
                    title: "Socar YDM",
                    subtitle: station.name,
                    imageName: "newSocarPin",
                    dataSource: station
                )
                mapView.addAnnotation(pin)
            }

            guard !coordinates.isEmpty else { return }
        }
    private func addEnrgStationPins(stations: [EnrgDTO]) {
        var coordinates: [CLLocationCoordinate2D] = []
        for station in stations {
            guard let lat = station.location.latitude, let lon = station.location.longitude else {
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            coordinates.append(coordinate)

            let pin = CustomPinAnnotation(
                coordinate: coordinate,
                title: "ENRG EDM",
                subtitle: station.address,
                imageName: "newEnrgPin",
                dataSource: station
            )
            mapView.addAnnotation(pin)
        }

        guard !coordinates.isEmpty else { return }
    }


        private func addGofarStationPins(stations: [GofarLocation]) {
            var coordinates: [CLLocationCoordinate2D] = []
            for station in stations {
                let locationComponents = station.location.split(separator: ",")
                
                guard locationComponents.count == 2,
                      let lat = Double(locationComponents[0]),
                      let lon = Double(locationComponents[1]) else {
                    continue
                }
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                coordinates.append(coordinate)

                let pin = CustomPinAnnotation(
                    coordinate: coordinate,
                    title: "Gofar EDM",
                    subtitle: station.name,
                    imageName: "newGofarPin",
                    dataSource: station
                )
                mapView.addAnnotation(pin)
            }
        }

        private func setInitialMapRegion() {
            guard let location = lastUserLocation else {return}
            let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: false)
        }

        
        private func managerAccess() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
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

       
        @objc private func reloadPoints() {
         getPoints()
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
        private func configureViewModel() {
            viewModel.callback = { [weak self] state in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    case .success:
                        print("success")
                    case .error(let errorTitle, let errorMessage):
                        self.showAlert(title: errorTitle, message: errorMessage)
                    case .successSocar:
                        self.addSocarStationPins(stations: self.viewModel.socarStations)
                    case .successTouch:
                        self.addTouchStationPins(stations: self.viewModel.touchStations)
                    case .successGofar:
                        self.addGofarStationPins(stations: self.viewModel.gofarStations)
                    case .successVolt:
                        self.addVoltStationPins(stations: self.viewModel.voltStations)
                    case .successEnrg:
                        self.addEnrgStationPins(stations: self.viewModel.enrgStations)
                    case .successCharge:
                        self.addChargeStationPins(stations: self.viewModel.chargeStations)
                    case .successTok:
                        self.addTokStationPins(stations: self.viewModel.tokStations)
                    }
                }
            }
        }



        override func configureView() {
            super.configureView()
            view.addViews(view: [mapView, stackView, loadingView])
        }
        override func configureConstraints() {
            super.configureConstraints()
            mapView.fillSuperview()
            loadingView.fillSuperview()
            stackView.anchor(
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                trailing: view.trailingAnchor,
                padding: .init(bottom: -36, trailing: -16)
            )
            stackView.anchorSize(CGSize(width: view.frame.width/8, height: view.frame.height/4))
        }
    }




    extension MapController: MKMapViewDelegate, CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }
            let myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            lastUserLocation = myLocation
            if mapView.userLocation.location == nil {
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: myLocation, span: span)
                self.mapView.setRegion(region, animated: true)
            }

            self.mapView.showsUserLocation = true
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let identifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }

            if let customAnnotation = annotation as? CustomPinAnnotation {
                annotationView?.image = UIImage(named: customAnnotation.imageName)?.resize(to: CGSize(width: view.frame.height/12, height: view.frame.height/12))
            }
            return annotationView
        }


            func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
                guard let customAnnotation = annotation as? CustomPinAnnotation else { return }
                print("Selected annotation of type: \(type(of: customAnnotation.dataSource))")

                switch customAnnotation.dataSource {
                case let socarStation as SocarResult:
                    viewModel.goToDetail(with: socarStation.switchDTOtoModel())

                case let touchStation as TouchData:
                    viewModel.goToDetail(with: touchStation.switchDTOtoModel())

                case let voltStation as VoltResult:
                    viewModel.goToDetail(with: voltStation.switchDTOtoDetail())

                case let gofarStation as GofarLocation:
                    guard let detailModel = gofarStation.switchDTOtoModel() else {return}
                    viewModel.goToDetail(with: detailModel)

                case let enrgStation as EnrgDTO:
                    viewModel.goToDetail(with: enrgStation.switchDTOtoModel())

                case let chargeStation as ChargeResult:
                    viewModel.goToDetail(with: chargeStation.switchDTOtoDetail())

                case let tokStation as TokResult:
                    viewModel.goToDetail(with: tokStation.switchDTOtoDetail())
                default:
                    print("Unknown station type selected.")
                }
            }
        

    }
