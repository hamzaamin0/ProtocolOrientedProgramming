import Foundation
import UIKit
import PlaygroundSupport

protocol Drawable {
    
    func draw(on context: CGContext)
}

protocol Geometery {
    
    var size: CGSize { get }
    func area() -> CGFloat
    func perimeter() -> CGFloat
}

extension Geometery{
    
    func area() -> CGFloat{
        
        return size.height * size.width
    }
}

struct Circle: Geometery, Drawable{
    
    var center: CGPoint
    var radius: CGFloat
    var color: UIColor
    var fillColor: UIColor
    var lineWidth: CGFloat
    
    var diameter: CGFloat {
        
        return radius * 2
    }
    
    var size: CGSize {
        
        return CGSize(width: diameter, height: diameter)
    }
    
    func area() -> CGFloat {
        return .pi * radius * radius
    }
    
    func perimeter() -> CGFloat {
        return (2 * .pi) * radius
    }
    
    func draw(on context: CGContext) {
        context.setFillColor(fillColor.cgColor)
        let rect = CGRect(x: center.x-radius, y: center.y-radius, width: diameter, height: diameter)
        context.addEllipse(in: rect)
        context.fillPath()
        context.setStrokeColor(color.cgColor)
        context.addEllipse(in: rect)
        context.setLineWidth(lineWidth)
        context.strokePath()
      }
}



extension UIColor {
  static func rgb(_ r: UInt8, _ g: UInt8, _ b: UInt8) -> UIColor {
    return UIColor(displayP3Red: CGFloat(r)/255,
                   green: CGFloat(g)/255,
                   blue: CGFloat(b)/255, alpha: 1)
    
  }
}

final class RenderView: UIView {
  
  var shapes: [Drawable] = [] {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    context.setFillColor(backgroundColor?.cgColor ?? UIColor.white.cgColor)
    context.fill(rect)
    
    for shape in shapes {
      shape.draw(on: context)
    }
  }
}

let renderView = RenderView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
renderView.backgroundColor = .lightGray

var shapes: [Drawable] = []

for _ in 1 ... 5 {
  
  let position = CGPoint(x: CGFloat.random(in: 0...renderView.frame.size.width),
                         y: CGFloat.random(in: 0...renderView.frame.size.width))
  let size = CGSize(width: CGFloat.random(in: 50...80),
                    height: CGFloat.random(in: 50...80))
  let lineWidth = CGFloat.random(in: 5...15)
  

  
  let colors: [UIColor] = [.rgb(255,0,156),
                           .rgb(255,0,113),
                           .rgb(255,0,219),
                           .rgb(255,0,182),
                           .rgb(255,0,94)]
  
    let shape = Circle(center: position, radius: size.width,
                     color: .rgb(255,0,15),
                     fillColor: colors.randomElement()!,
                     lineWidth: lineWidth)
  shapes.append(shape)
}

renderView.shapes = shapes
PlaygroundPage.current.liveView = renderView


extension CGRect: Geometery {
    func perimeter() -> CGFloat {
        return 2 * (size.width + size.height)
    }
    
    func area() -> CGFloat {
        return size.width * size.height
    }
    
}

let size = CGSize(width: CGFloat.random(in: 50...80),
                  height: CGFloat.random(in: 50...80))
let lineWidth = CGFloat.random(in: 5...15)

let aCircle = Circle(center: .zero, radius: size.width, color: .rgb(240, 0, 90), fillColor: .brown, lineWidth: lineWidth)

let aRect = CGRect(origin: .zero, size: size)

let shapesArray: [Geometery] = [aCircle, aRect]

print(shapesArray.reduce(0) { ($0 + $1.perimeter() )})

