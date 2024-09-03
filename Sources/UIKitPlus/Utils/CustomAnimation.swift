//
//  CustomAnimation.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 03/09/2024.
//

// MARK: Need documentation and UTs
import UIKit

public enum AniDuration: Double {
    case springWithDamping = 0.75
    case springVelocity = 0.6
    case interval = 0.1
    case duration = 0.61
    
    public func double() -> Double {
        return self.rawValue
    }
    
    public func float() -> CGFloat {
        return CGFloat(self.rawValue)
    }
}

@MainActor
public class CustomAnimation {
    
  public static func zoomInBounce(view: UIView, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?) {
        
        view.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        view.isHidden = false
        
        // usingSpringWithDamping - higher values make the bouncing finish faster.
        // initialSpringVelocity - higher values give the spring more initial momentum.
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            view.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: completed)
        
    }
    
    public static func scaleFrom(view: UIView, scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions, completed: ((_ animated: Bool) -> Void)?, useBounceEffect: Bool = false, startAlpha: CGFloat = 1, endAlpha: CGFloat = 1) {
        view.alpha = startAlpha
        view.transform = CGAffineTransform.identity.scaledBy(x: scaleX, y: scaleY)
        if useBounceEffect {
            // usingSpringWithDamping - higher values make the bouncing finish faster.
            // initialSpringVelocity - higher values give the spring more initial momentum.
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                view.alpha = endAlpha
                view.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }, completion: completed)
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                view.alpha = endAlpha
                view.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }, completion: completed)
        }
        
    }
    
    public static func scaleTo(view: UIView, scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions, completed: ((_ animated: Bool) -> Void)?, useBounceEffect: Bool = false) {
        
        if useBounceEffect {
            //usingSpringWithDamping - higher values make the bouncing finish faster.
            //initialSpringVelocity - higher values give the spring more initial momentum.
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                view.transform = CGAffineTransform.identity.scaledBy(x: scaleX, y: scaleY)
            }, completion: completed)
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                view.transform = CGAffineTransform.identity.scaledBy(x: scaleX, y: scaleY)
            }, completion: completed)
        }
    }
    
    public enum DirectionCustom {
        case TOP
        case BOTTOM
        case LEFT
        case RIGHT
    }
    
    public static func moveFrom(direction: [DirectionCustom], view: UIView, fromX: CGFloat, fromY: CGFloat, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?, useBounceEffect: Bool = false) {
        
        var horizontal: CGFloat = 1
        var vertical: CGFloat = 1
        for dir in direction {
            switch dir {
            case .TOP: vertical = -1
            case .BOTTOM: vertical = 1
            case .LEFT:  horizontal = -1
            case .RIGHT:  horizontal = 1
            }
        }
        view.transform = CGAffineTransform.identity.translatedBy(x: fromX * horizontal, y: fromY * vertical)
        view.alpha = 0
        view.isHidden = false
        
        if useBounceEffect {
            //usingSpringWithDamping - higher values make the bouncing finish faster.
            //initialSpringVelocity - higher values give the spring more initial momentum.
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                view.alpha = 1
                view.transform =  CGAffineTransform.identity.translatedBy(x: 0, y: 0)
            }, completion: completed)
        } else {
            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut], animations: {
                view.alpha = 1
                view.transform =  CGAffineTransform.identity.translatedBy(x: 0, y: 0)
            }, completion: completed)
        }
    }
    
    public static func moveTo(direction: [DirectionCustom], view: UIView, toX: CGFloat, toY: CGFloat, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?, useBounceEffect: Bool = false) {
        
        var horizontal: CGFloat = 1
        var vertical: CGFloat = 1
        for dir in direction {
            switch dir {
            case .TOP: vertical = -1
            case .BOTTOM: vertical = 1
            case .LEFT:  horizontal = -1
            case .RIGHT:  horizontal = 1
            }
        }
        
        if useBounceEffect {
            //usingSpringWithDamping - higher values make the bouncing finish faster.
            //initialSpringVelocity - higher values give the spring more initial momentum.
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                view.alpha = 1
                view.transform =  CGAffineTransform.identity.translatedBy(x: toX * horizontal, y: toY * vertical)
            }, completion: completed)
        } else {
            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut], animations: {
                view.alpha = 1
                view.transform =  CGAffineTransform.identity.translatedBy(x: toX * horizontal, y: toY * vertical)
            }, completion: completed)
        }
    }
    
    public enum ShakeDensity {
        case SOFT
        case NORMAL
        case HARD
    }
    
    public static func shake(view: UIView, duration: TimeInterval = 1.0, density: ShakeDensity = .HARD) {
        var shakeValues: [Double] = []
        
        switch density {
        case .SOFT: shakeValues = [-2, 2, 0]
        case .NORMAL: shakeValues = [-3, 3, -2, 2, 0]
        case .HARD: shakeValues = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        }
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = shakeValues
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = shakeValues.map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        view.layer.add(shakeGroup, forKey: "shakeIt")
        
    }
    
    public static func rotateTo(view: UIView, angle: CGFloat, clockwise: Bool, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?, useBounceEffect: Bool = false) {
        var rotateAngle = angle
        if clockwise { rotateAngle = angle * -1 }
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut], animations: {
            view.alpha = 1
            view.transform =  CGAffineTransform.identity.rotated(by: rotateAngle)
        }, completion: completed)
    }
    
    public enum Position {
        case TOP_LEFT
        case TOP_RIGHT
        case BOT_LEFT
        case BOT_RIGHT
    }
    
    public static func sparkAt(position: Position, view: UIView, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?, sparkSize: CGFloat = 2, sparkColor: UIColor = .white) {
        let size = view.frame.height*sparkSize
        let imgSpark = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imgSpark.image = UIImage(named: "spark")?.withRenderingMode(.alwaysTemplate)
        imgSpark.tintColor = sparkColor
        
        
        switch position {
        case .TOP_LEFT: break
        case .TOP_RIGHT:
            imgSpark.frame.origin.x = view.frame.origin.x + view.frame.width - (size/2)
            imgSpark.frame.origin.y = view.frame.origin.y - (size/2)
        case .BOT_LEFT: break
        case .BOT_RIGHT: break
        }
        view.superview?.addSubview(imgSpark)
        
        imgSpark.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
        
        UIView.animate(withDuration: duration * 0.5, delay: delay,  options: [.curveEaseOut], animations: {
            imgSpark.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1).rotated(by: CGFloat.pi)
        }, completion: { _ in
            UIView.animate(withDuration: duration * 0.5,  delay: 0, options: [.curveEaseOut], animations: {
                imgSpark.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01).rotated(by: CGFloat.pi * 2)
            }, completion: { animated in
                imgSpark.removeFromSuperview()
                completed?(animated)
            })
        })
        
    }
    
    public static func changeImage(imageView: UIImageView, toImage: UIImage?, duration: TimeInterval, options:UIView.AnimationOptions,completed: ((_ animated: Bool) -> Void)?) {
        UIView.transition(with: imageView, duration: duration, options: options, animations: {
            imageView.image = toImage
        }, completion: nil)
    }
    
    public static func alpha(view: UIView, toAlpha: CGFloat, duration: TimeInterval, delay: TimeInterval, completed: ((_ animated: Bool) -> Void)?) {
        UIView.animate(withDuration: duration * 0.5, delay: delay,  options: [.curveEaseOut], animations: {
            view.alpha = toAlpha
        }, completion: completed)
    }
    
    public static func wave(view: UIView, waveImage: String) {
        
        for sub in view.subviews {
            sub.removeFromSuperview()
        }
        
        for i in 0..<3 {
            let wave = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            wave.image = UIImage(named: waveImage)
            wave.frame.origin.x = view.frame.width * CGFloat(i)
            view.addSubview(wave)
        }
        
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .curveLinear], animations: {
            view.transform =  CGAffineTransform.identity.translatedBy(x: -(view.frame.width), y: 0)
        }, completion: { _ in
            view.transform =  CGAffineTransform.identity
        })
    }
}

