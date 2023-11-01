//
//  WeatherView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 11.09.2023.
//

import UIKit
 
class WeatherView : UIView {
 
   private let weatherImageView: UIImageView = {
        let sunImageView = UIImageView()
        sunImageView.image = UIImage(named: "sun")
        sunImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return sunImageView
    }()
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Loding..."
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.font = .systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        
       return label
    }()
    
    
    private let weatherDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.textColor = .lightGray
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setWeatherView()
        setConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setWeatherView() {
        addShadowOnView()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(weatherImageView)
        addSubview(weatherDiscriptionLabel)
        addSubview(weatherStatusLabel)
    }
    
    func updateImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        weatherImageView.image = image
    }
    
    func updateLabels(model: WeatherModel) {
        weatherStatusLabel.text = model.weather[0].myDescription + " " + "\(model.main.temperatureСelsius)°C"
        
        switch model.weather[0].weatherDescription {
            case "clear sky":
                weatherDiscriptionLabel.text = "Хорошая погода, чтобы позаниматься на улице"
            case "shower rain", "rain", "thunderstorm":
                weatherDiscriptionLabel.text = "Лучше остаться дома и провести домашнюю тренировку"
            default:
            weatherDiscriptionLabel.text = "Можно собираться в зал"
            }
        }
    }

//MARK: - Set Constraints
extension WeatherView{
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            
            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            weatherStatusLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weatherDiscriptionLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 0),
            weatherDiscriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherDiscriptionLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            weatherDiscriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}



