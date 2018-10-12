# Intro

Hey everybody, it's me again, Rony. I want to talk a bit more about what you can do with UIVisualEffectView and in this screencast I will focus on Vibrancy. So, what exactly is vibrancy and how (and why) should you use it? Great questions!
UIVibrancyEffect is Apple's way of allowing us to adjust the colors of the content to make it feel more vivid when using UIVisualEffectView.
As you know, an image is worth a 1,000 words, so this **[Slide 01]** is what it looks like. See the difference between the left image and the right one? In real life situations this may be pretty subtle, but it does create a much smoother and slicker user experience.

> Editor: Same as in the previous part,it'd be great if the slide can appear on the top left part of the screen, next to my talking head... :] Instead of full screen. Is that an option?

Note that a UIVibrancyEffect MUST be added to the contentView of a UIVisualEffectView that has already been configured with a UIBlurEffect. Otherwise, there won't be any blurs to apply the vibrancy effect to.

Ok, now that we've covered all of the background info, let's dive right in to the code...

# Demo

So, I have this cool Brothers Grimm fairytales app, and it has an options view that already includes a blur effect. Let's add vibrancy to it

First, we'll create a vibrancy effect (which is another subclass of UIVisualEffect) based on the blur effect that we already have implemented in code:

```swift
let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
```

Then, we create a UIVisualEffectView based on the vibrancy effect:

```swift
let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
vibrancyView.translatesAutoresizingMaskIntoConstraints = false
```

Next, we add the view, which contains all of the controls we want the vibrancy to be applied to, as a subview of the content view of the new vibrancy view we've just created (wow, that was a complicated sentence; I hope I didn't lose you yet). This is how it looks in code:

```swift
vibrancyView.contentView.addSubview(optionsView)
```

Much easier to understand now, right?
Finally, we add the new vibrancy view to the blur view's content view to complete the effect:

```swift
blurView.contentView.addSubview(vibrancyView)
```

Now we just need to take care of all of the relevant constraints. We want the blur view, the vibrancy view and the view that actually contains the controls that need to be affected to all have the same frame. In this specific case, it'll look like this:

```swift
NSLayoutConstraint.activate([
vibrancyView.heightAnchor.constraint(equalTo: blurView.contentView.heightAnchor),
vibrancyView.widthAnchor.constraint(equalTo: blurView.contentView.widthAnchor),
vibrancyView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
vibrancyView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
])

NSLayoutConstraint.activate([
optionsView.centerXAnchor.constraint(equalTo: vibrancyView.contentView.centerXAnchor),
optionsView.centerYAnchor.constraint(equalTo: vibrancyView.contentView.centerYAnchor),
])
```

Finally, since we've added the view containing all of the controls that need to be affected by the vibrancy effect as a subview of the new vibrancy effect view, we need to comment out the way it was previously added to the view hirarchy (because every view should only have one superview - that's just the way it is). So, let's comment out the relevant code block: 

```swift
//    view.addSubview(optionsView)
//    NSLayoutConstraint.activate([
//      view.centerXAnchor.constraint(equalTo: optionsView.centerXAnchor),
//      view.centerYAnchor.constraint(equalTo: optionsView.centerYAnchor)
//      ])
```

And run...

If we now go to the options view, we'll see that everything is looking... Oh... Wait... That's not exactly what we were going for.
So, what went wrong? The blur effect that we've used uses the light style. The content behind the blur view is also pretty light - resulting in this not so user-friendly display.
So, if we just go back to the code and change the light UIBlurEffectStyle to the dark one instead:

```swift
let blurEffect = UIBlurEffect(style: .dark)
```

And build... and run... and go back to the options view... Vuala! We now get to experience some true vibrancy.

# Conclusion

So, in conclusion - UIVisualEffectView offers us great tools, which we have to use wisely, otherwise we may end up hurting our users' eyes instead of improving thier experience using our app. And we don't really want that to happen, right? 
Have fun playing around with visual effects, and don't worry, you don't have blurry vision, that's what it's supposed to look like... :]
