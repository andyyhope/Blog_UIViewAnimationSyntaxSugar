//:
//:  UIView Animation Syntax Sugar
//:
//:  Created by Andyy Hope on 18/08/2016.
//:  Twitter: @andyyhope
//:  Medium: Andyy Hope, https://medium.com/@AndyyHope

import UIKit

extension UIView {
    
    class Animator {
        
        typealias Completion = (Bool) -> Void
        typealias Animations = () -> Void
        
        private var animations: Animations
        private var completion: Completion?
        private let duration: TimeInterval
        private let delay: TimeInterval
        private let options: UIViewAnimationOptions
        
        init(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = []) {
            self.animations = {}
            self.completion = nil
            self.duration = duration
            self.delay = delay
            self.options = options
        }
        
        func animations(_ animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }
        
        func completion(_ completion: @escaping Completion) -> Self {
            self.completion = completion
            return self
        }
        
        func animate() {
            UIView.animate(withDuration: duration, animations: animations, completion: completion)
        }
    }
    
    final class SpringAnimator: Animator {
        
        private let damping: CGFloat
        private let velocity: CGFloat
        
        init(duration: TimeInterval, delay: TimeInterval = 0, damping: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions = []) {
        
            self.damping = damping
            self.velocity = velocity
            
            super.init(duration: duration, delay: delay, options: options)
        }
    }
}


// MARK: - Example API

var view = UIView(frame: .zero)

// Old Way

UIView.animate(withDuration: 0.4, animations: {
    view.frame.size.height = 100
    view.frame.size.width = 100
}) { finished in
    view.backgroundColor = .black
}

// Regular Animations

UIView.Animator(duration: 0.3)
    .animations {
        view.frame.size.height = 100
        view.frame.size.width = 100
    }
    .completion { finished in
        view.backgroundColor = .black
    }
    .animate()


// Regular Animations with options

UIView.Animator(duration: 0.4, delay: 0.2)
    .animations { }
    .completion { _ in }
    .animate()

UIView.Animator(duration: 0.4, options: [.autoreverse, .curveEaseIn])
    .animations { }
    .completion { _ in }
    .animate()

UIView.Animator(duration: 0.4, delay: 0.2, options: [.autoreverse, .curveEaseIn])
    .animations { }
    .completion { _ in }
    .animate()

// Spring Animator

UIView.SpringAnimator(duration: 0.3, delay: 0.2, damping: 0.2, velocity: 0.2, options: [.autoreverse, .curveEaseIn])
    .animations { }
    .completion { _ in }
    .animate()