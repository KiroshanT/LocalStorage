//
//  DetailsViewController.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

import UIKit
import Kingfisher
import MapKit

class DetailViewController: UIViewController {
    
    var data: User! = nil {
        didSet {
            thumbnail.kf.setImage(with: URL(string: data.large_image))
            let info = "About\n\n\(data.title) \(data.first_name) \(data.last_name)\n\(data.email)\n\(data.gender)\n\(Common.getDateOfBirthFormat(dateAndTime: data.dob))\n\(data.city)\n\(data.phone)\n\nLocation"
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            textViewInfo.attributedText = NSAttributedString(string: info, attributes: [.paragraphStyle: style, .foregroundColor: UIColor.label, .font: UIFont.boldSystemFont(ofSize: 15)])
            
            let latitude = (data.latitude as NSString).doubleValue
            let longitude = (data.longitude as NSString).doubleValue
            print("\(latitude) \(longitude)")
            let myLocation = Capital(title: data.city, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), info: data.first_name)
            mapView.addAnnotations([myLocation])
            mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    var textViewInfo: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        return label
    }()
    var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = data.first_name
        setupView(view: view)
    }
    
    func updateMapForCoordinate(coordinate: CLLocationCoordinate2D) {
        var center = coordinate;
        center.latitude -= self.mapView.region.span.latitudeDelta / 3.0;
        mapView.setCenter(center, animated: true);
    }
    
    func setupView(view: UIView) {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        viewContainer.addSubview(thumbnail)
        viewContainer.addSubview(textViewInfo)
        viewContainer.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            viewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            viewContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            thumbnail.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            thumbnail.leftAnchor.constraint(equalTo: viewContainer.leftAnchor),
            thumbnail.rightAnchor.constraint(equalTo: viewContainer.rightAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 250),
            
            textViewInfo.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10),
            textViewInfo.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10),
            textViewInfo.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 10),
            
            mapView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor),
            mapView.topAnchor.constraint(equalTo:textViewInfo.bottomAnchor, constant: 10),
            mapView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
