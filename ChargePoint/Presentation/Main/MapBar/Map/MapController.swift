    //
    //  MapController.swift
    //  ChargePoint
    //
    //  Created by Javidan on 16.02.25.
    //

    import UIKit
    import MapKit
    import CoreLocation

    final class MapController: BaseController {
        
        let manager = CLLocationManager()
        private var lastUserLocation: CLLocationCoordinate2D?
        private let viewModel: MapViewModel
        
        init(viewModel: MapViewModel) {
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
        
        private lazy var stackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [locationIcon,zoomPlus, zoomMinus])
            s.alignment = .fill
            s.distribution = .fillEqually
            s.axis = .vertical
            s.spacing = 6
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
//            viewModel.getTouchPoints()
//            viewModel.getSocarPoints()
//            viewModel.getGofarPoints()
//            viewModel.getVoltPoints()
            viewModel.getEnrgPoints()
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
                    title: station.name,
                    subtitle: station.formattedAddress,
                    imageName: "touchAz"
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
                    title: station.name,
                    subtitle: station.address,
                    imageName: "voltPin"
                )
                mapView.addAnnotation(pin)
            }

            guard !coordinates.isEmpty else { return }
        }
        private func addSocarStationPins(stations: [SocarResult]) {
            print(#function)
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
                    title: station.name,
                    subtitle: station.address,
                    imageName: "socarPin"
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
                    print("Invalid coordinates for station: \(station.name)")
                    continue
                }
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                coordinates.append(coordinate)

                let pin = CustomPinAnnotation(
                    coordinate: coordinate,
                    title: station.name,
                    subtitle: station.address,
                    imageName: "gofarPin"
                )
                mapView.addAnnotation(pin)
            }
        }

        private func setInitialMapRegion() {
            guard let location = lastUserLocation else {
                print("User location not available yet")
                return
            }
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
                 region.span.latitudeDelta *= 2
                 region.span.longitudeDelta *= 2
                 mapView.setRegion(region, animated: true)
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
                        print("scsdasdasdasdu")

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
            stackView.anchorSize(CGSize(width: view.frame.width/8, height: view.frame.height/6))
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
    //        guard annotation is CustomPinAnnotation else { return }
            viewModel.goDetail()
        }

    }
