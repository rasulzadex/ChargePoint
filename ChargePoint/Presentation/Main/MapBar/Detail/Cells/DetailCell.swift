//
//  DetailCell.swift
//  ChargePoint
//
//  Created by Javidan on 28.02.25.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    private lazy var connectorType: ReusableImage = {
        let i = ReusableImage(imageName: "logo", contentMode: .scaleAspectFit)
        return i
    }()
    private lazy var titleLabel: ReusableLabel = {
        let l = ReusableLabel(
            text: "GB/T",
            textAlignment: .center,
            fontName: "Arch",
            fontSize: 18,
            textColor: .black,
            numberOfLines: 0
        )
        return l
    }()
    private lazy var statusLabel: ReusableLabel = {
        let l = ReusableLabel(
            text: "İşləmir",
            textAlignment: .center,
            fontName: "Arch",
            fontSize: 14,
            textColor: .white,
            numberOfLines: 0,
            cornerRadius: 10
        )
        l.layer.borderColor = UIColor.evBlue.cgColor
        l.layer.borderWidth = 1
        l.backgroundColor = .red
        return l
    }()
    private lazy var stackVIew: ReusableStackView = {
        let s = ReusableStackView(
            arrangedSubviews: [connectorType, titleLabel, statusLabel],
            alignment: .fill,
            distribution: .fillProportionally,
            axis: .vertical,
            spacing: 4
        )
        return s
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView(){
        addViews(view: [stackVIew])
    }
    private func configureConstraints() {
        stackVIew.fillSuperview()
        connectorType.anchorSize(CGSize(width: 0, height: frame.height/1.7))
        statusLabel.anchorSize(CGSize(width: 0, height: frame.height/5.5))

    }
  
    func configureCell(connector: String, status: String) {
            titleLabel.text = getConnectorName(connector: connector)
            connectorType.image = getConnectorImage(connector: connector)
            statusLabel.text = getStatusName(status: status)
            statusLabel.backgroundColor = getStatusColor(status: status)
        }
    private func getConnectorName(connector:String) -> String{
        switch connector {
        case "GB/T", "c_gbt", "GB/T (Fast)": return "GB/T"
        case "GB/T DC", "GBT_DC", "GB/T • DC", "/icons/connectorTypes/gbt-dc.png" : return "GB/T DC"
        case "GB/T • AC": return "GB/T AC"
        case "c_ccs_2", "CCS2_PLUG", "CCS2 • DC", "CCS 2", "/icons/connectorTypes/ccs-2.png":
            return "CCS 2"
        case "Type2", "Type 2 (Mennekes) • AC", "/icons/connectorTypes/type-2.png" : return "Type 2"
        case "c_type_1" : return "Type 1"
        default: return "Naməlum"
        }
    }
        
        private func getConnectorImage(connector: String) -> UIImage? {
            switch titleLabel.text {
            case "GB/T", "GB/T DC", "GB/T AC":
                return UIImage(named: "gbt")
            case "Type 2":
                return UIImage(named: "type2")
            case "CCS 2":
                return UIImage(named: "ccs")
            case "Type 1": return UIImage(named: "type1")
            default: return UIImage(named: "logo")
            }
            
            
        }

    func getStatusName(status: String) -> String {
        switch status {
        case "AVAILABLE", "Available", "available", "active":
            return "Uyğundur"
        case "CHARGING", "IN_USE":
            return "Məşğuldur"
        case "OUT_OF_SERVICE", "UNAVAILABLE", "Unavailable":
            return "İşləmir"
        case "preparing": return "Hazırlanır"
        case "MAINTENANCE": 
            statusLabel.textColor = .evBlue
            return "Təmirdədir"
        case "unknown", "Unknown", "UNKNOWN", "No status":
            return "Bilinmir"
        default:
            return "Naməlum"
        }
    }
        private func getStatusColor(status: String) -> UIColor {
            switch status {
            case "AVAILABLE", "Available", "available", "active":
                return .evNavigation
            case "CHARGING", "IN_USE":
                return .orange
            case "OUT_OF_SERVICE", "UNAVAILABLE", "Unavailable":
                return .red
            case "preparing", "MAINTENANCE": return .yellow
            case "unknown", "Unknown", "UNKNOWN", "No status":
                return .blue
            default:
                return .gray
            }
        }
    
}
