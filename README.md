![](https://cdn-images-1.medium.com/max/2000/1*ZQCI076hEXJCRZ9R3ChatQ.png)

# Swift: UIView Animation Syntax Sugar
## Because closures make ugly couples

If you hadn’t already heard, closures are a great tool to utilise in your Swift code. They’re first-class citizens, they can become trailing closures if they’re at the end of an API and now they’re @noescape by default which is a massive win in the fight against reference cycles.
But every once in a while we have to work with APIs that contain more than one closure, which turns this beautiful language feature into something far less appealing. I’m looking at you, `UIView`.

Read the full article [here](https://medium.com/@AndyyHope)

--

###tl;dr
####Turn this

```swift
UIView.animate(withDuration: 0.4, animations: {
    view.frame.size.height = 100
    view.frame.size.width = 100
}) { finished in
    view.backgroundColor = .black
}
```

####Into this

```swift
UIView.Animator(duration: 0.3)
    .animations {
        view.frame.size.height = 100
        view.frame.size.width = 100
    }
    .completion { finished in
        view.backgroundColor = .black
    }
    .animate()
```