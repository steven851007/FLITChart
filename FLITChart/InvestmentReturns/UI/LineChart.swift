//
//  LineChart.swift
//  FLITChart
//
//  Created by Istvan Balogh on 07.12.21.
//

import UIKit

struct LineLayer {
    
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    let lineGap: CGFloat = 60.0
    
    let dataEntries: [PointEntry]
    
    init(dataEntries: [PointEntry]) {
        self.dataEntries = dataEntries
    }
    
    func drawCurvedChart(height: CGFloat, minMax: (Int,Int)) -> CALayer? {
        let dataPoints = convertDataEntriesToPoints(entries: dataEntries, height: height, minMax: minMax)
        guard dataPoints.count > 0 else {
            return nil
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let dataLayer: CALayer = CALayer()
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.systemBlue.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
            return dataLayer
        }
        return nil
    }
    
    private func convertDataEntriesToPoints(entries: [PointEntry], height: CGFloat, minMax: (Int,Int)) -> [CGPoint] {
        let max = minMax.1
        let min = minMax.0
        
        var result: [CGPoint] = []
        let minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
        
        for i in 0..<entries.count {
            let height = height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
            let point = CGPoint(x: CGFloat(i)*lineGap + 40, y: height)
            result.append(point)
        }
        return result
        
    }
}

class LineChart: UIView {
    
    /// gap between each point
    let lineGap: CGFloat = 60.0
    
    /// preseved space at top of the chart
    let topSpace: CGFloat = 40.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 40.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0

    /// Dot inner Radius
    var innerRadius: CGFloat = 8

    /// Dot outer Radius
    var outerRadius: CGFloat = 12
    
    var lineLayer1: LineLayer?
    var lineLayer2: LineLayer?
    var lineLayer3: LineLayer?
    var lineLayer4: LineLayer?
    
    func addDataEntry(_ entry1: [PointEntry], entry2: [PointEntry], entry3: [PointEntry], entry4: [PointEntry]) {
        self.lineLayer1 = LineLayer(dataEntries: entry1)
        self.lineLayer2 = LineLayer(dataEntries: entry2)
        self.lineLayer3 = LineLayer(dataEntries: entry3)
        self.lineLayer4 = LineLayer(dataEntries: entry4)
        self.setNeedsLayout()
    }
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    private var lineLayers = [CALayer]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        
        self.layer.addSublayer(gridLayer)
        self.addSubview(scrollView)
        self.backgroundColor = .systemBackground
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        let allEntries = (lineLayer1?.dataEntries ?? []) + (lineLayer2?.dataEntries ?? []) + (lineLayer3?.dataEntries ?? []) + (lineLayer4?.dataEntries ?? [])
        guard let max = allEntries.max()?.value,
            let min = allEntries.min()?.value else {
                return
        }
        
        if let dataEntries = lineLayer1?.dataEntries {
            scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)

            gridLayer.frame = CGRect(x: 0, y: topSpace, width: self.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            clean()
            
            if let dataLayer = lineLayer1?.drawCurvedChart(height: mainLayer.frame.height - topSpace - bottomSpace, minMax: (min, max)) {
                mainLayer.addSublayer(dataLayer)
                lineLayers.append(dataLayer)
            }
            
            drawHorizontalLines()
            drawLables()
        }
        
        if let lineLayer2 = lineLayer2 {
            if let dataLayer = lineLayer2.drawCurvedChart(height: mainLayer.frame.height - topSpace - bottomSpace, minMax: (min, max)) {
                mainLayer.addSublayer(dataLayer)
                lineLayers.append(dataLayer)
            }
        }
        
        if let lineLayer3 = lineLayer3 {
            if let dataLayer = lineLayer3.drawCurvedChart(height: mainLayer.frame.height - topSpace - bottomSpace, minMax: (min, max)) {
                mainLayer.addSublayer(dataLayer)
                lineLayers.append(dataLayer)
            }
        }
        
        if let lineLayer4 = lineLayer4 {
            if let dataLayer = lineLayer4.drawCurvedChart(height: mainLayer.frame.height - topSpace - bottomSpace, minMax: (min, max)) {
                mainLayer.addSublayer(dataLayer)
                lineLayers.append(dataLayer)
            }
        }
    }
    
    /**
     Create titles at the bottom for all entries showed in the chart
     */
    private func drawLables() {
        if let dataEntries = lineLayer1?.dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height - bottomSpace/2 - 8, width: lineGap, height: 16)
                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 11
                textLayer.string = dataEntries[i].label
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    /**
     Create horizontal lines (grid lines) and show the value of each line
     */
    private func drawHorizontalLines() {
        guard let dataEntries1 = lineLayer1?.dataEntries,
              let dataEntries2 = lineLayer2?.dataEntries,
              let dataEntries3 = lineLayer3?.dataEntries,
              let dataEntries4 = lineLayer4?.dataEntries else {
                  return
              }
        let dataEntries = dataEntries1 + dataEntries2 + dataEntries3 + dataEntries4
        
        
        var gridValues: [CGFloat]? = nil
        if dataEntries.count < 4 && dataEntries.count > 0 {
            gridValues = [0, 1]
        } else if dataEntries.count >= 4 {
            gridValues = [0, 0.25, 0.5, 0.75, 1]
        }
        if let gridValues = gridValues {
            for value in gridValues {
                let height = value * gridLayer.frame.size.height
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: height))
                path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))
                
                let lineLayer = CAShapeLayer()
                lineLayer.path = path.cgPath
                lineLayer.fillColor = UIColor.clear.cgColor
                lineLayer.strokeColor = #colorLiteral(red: 0.2784313725, green: 0.5411764706, blue: 0.7333333333, alpha: 1).cgColor
                lineLayer.lineWidth = 0.5
                if (value > 0.0 && value < 1.0) {
                    lineLayer.lineDashPattern = [4, 4]
                }
                
                gridLayer.addSublayer(lineLayer)
                
                var minMaxGap:CGFloat = 0
                var lineValue:Int = 0
                if let max = dataEntries.max()?.value,
                   let min = dataEntries.min()?.value {
                    minMaxGap = CGFloat(max - min) * topHorizontalLine
                    lineValue = Int((1-value) * minMaxGap) + Int(min)
                }
                
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: 4, y: height, width: 100, height: 16)
                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 12
                textLayer.string = "$ " + formatNumber(lineValue)
                
                gridLayer.addSublayer(textLayer)
            }
        }
    }
    
    func clean() {
        for layer in lineLayers {
            layer.removeFromSuperlayer()
        }
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    
    private func formatNumber(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"
        }
    }

}


private extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

