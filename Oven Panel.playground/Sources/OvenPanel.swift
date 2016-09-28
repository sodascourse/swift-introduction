import UIKit
import PlaygroundSupport


public class OvenPanel: UIView {

    var temperatureSlider: UISlider!
    var celsiusLabel: UILabel!
    var fahrenheitLabel: UILabel!
    var kelvinLabel: UILabel!
    var foodLabel: UILabel!

    var currentTemperature: Float = 0.0 {
        didSet {
            self.updateLabels()
        }
    }

    // MARK: - Initialization

    public static func thermometerFixedPanel() -> OvenPanel {
        return ThermometerCorrectOvenPanel()
    }

    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 320, height: 136)
        self.init(frame: frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.setupSubviews()
        self.currentTemperature = self.temperatureSlider.minimumValue
        self.updateLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        let temperatureSliderFrame = CGRect(x: 20, y: 20, width: 280, height: 40)
        let celsiusLabelFrame = CGRect(x: 20, y: 68, width: 88, height: 20)
        let fahrenheitLabelFrame = CGRect(x: 116, y: 68, width: 88, height: 20)
        let kelvinLabelFrame = CGRect(x: 212, y: 68, width: 88, height: 20)
        let foodLabelFrame = CGRect(x: 20, y: 96, width: 280, height: 20)

        self.temperatureSlider = UISlider(frame: temperatureSliderFrame)
        self.temperatureSlider.tintColor = UIColor.red
        self.temperatureSlider.minimumValue = 60.0
        self.temperatureSlider.maximumValue = 300.0
        self.temperatureSlider.addTarget(self, action: #selector(OvenPanel.temperatureChanged),
                                         for: .valueChanged)
        self.addSubview(self.temperatureSlider)

        self.celsiusLabel = UILabel(frame: celsiusLabelFrame)
        self.celsiusLabel.textAlignment = .right
        self.addSubview(self.celsiusLabel)

        self.fahrenheitLabel = UILabel(frame: fahrenheitLabelFrame)
        self.fahrenheitLabel.textAlignment = .right
        self.addSubview(self.fahrenheitLabel)

        self.kelvinLabel = UILabel(frame: kelvinLabelFrame)
        self.kelvinLabel.textAlignment = .right
        self.addSubview(self.kelvinLabel)

        self.foodLabel = UILabel(frame: foodLabelFrame)
        self.addSubview(self.foodLabel)
    }

    // MARK: - UI Actions

    func temperatureChanged(_ sender: UISlider) {
        self.currentTemperature = sender.value
    }

    func updateLabels() {
        self.celsiusLabel.text = String(format: "%.2f °C", self.currentTemperature)

        let temperatureInFahrenheit = self.fahrenheitConverter(self.currentTemperature)
        self.fahrenheitLabel.text = String(format: "%.2f °F", temperatureInFahrenheit)

        let temperatureInKelvin = self.kelvinConverter(self.currentTemperature)
        self.kelvinLabel.text = String(format: "%.2f °K", temperatureInKelvin)

        let food = self.getRecommendedFood(self.currentTemperature)
        self.foodLabel.text = food.isEmpty ? "" : "Suitable for \(food)."
    }

    // MARK: - Handlers

    public var fahrenheitConverter: ((Float) -> Float) = { $0 }
    public var kelvinConverter: ((Float) -> Float) = { $0 }
    public var getRecommendedFood: ((Float) -> String) = { _ in "" }

}


class ThermometerCorrectOvenPanel: OvenPanel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fahrenheitConverter = { $0 * 1.8 + 32 }
        self.kelvinConverter = { $0 + 273.15 }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - Playground Support

extension OvenPanel {
    public func showInPlayground() {
        self.updateLabels()
        PlaygroundPage.current.liveView = self
    }
}
