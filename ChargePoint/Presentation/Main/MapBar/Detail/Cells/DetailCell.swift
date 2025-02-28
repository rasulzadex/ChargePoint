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
        statusLabel.anchorSize(CGSize(width: 0, height: frame.height/5))

    }
  
    func configureCell(model: DetailModel) {
        let connectors = model.charger.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

         // 2. Uyğun gələn ilk şəkli tapmaq üçün dəyişən
         var selectedImage: UIImage? = nil
         
         // 3. Connector-ləri dövrə salırıq və ilk uyğun gələn şəkli təyin edirik
         for connector in connectors {
             if connector.contains("GB/T") {
                 selectedImage = UIImage(named: "gbt") // GB/T üçün "A" şəkli
                 break
             } else if connector.contains("Type2") {
                 selectedImage = UIImage(named: "type2") // Type2 üçün "B" şəkli
                 break
             } else if connector.contains("CCS") {
                 selectedImage = UIImage(named: "ccs") // CCS üçün "C" şəkli
                 break
             }
         }

         // 4. Əgər heç bir uyğunluq tapılmayıbsa, default şəkil istifadə et
         connectorType.image = selectedImage ?? UIImage(named: "logo")

         // 5. Charger-ləri `titleLabel`-də göstəririk (bütün connector-ləri yazmaq üçün)
         titleLabel.text = connectors.joined(separator: ", ")

         // 6. Statusları parçalayırıq və ilk statusu götürürük
         let statuses = model.status.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
         statusLabel.text = statuses.first ?? "Naməlum"

        if let firstStatus = statuses.first {
            switch firstStatus {
            case "AVAILABLE":
                statusLabel.backgroundColor = .green
            case "UNAVAILABLE":
                statusLabel.backgroundColor = .orange
            case "OUT_OF_SERVICE":
                statusLabel.backgroundColor = .red
            default:
                statusLabel.backgroundColor = .gray
            }
        } else {
            statusLabel.backgroundColor = .gray
        }
    }

    
}
