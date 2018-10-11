# Intro

Hey, It's me again, Rony. And I just want to tell you one more thing about UIVisualEffectView. Yeah, I know, I can't seem to shut up about the topic. This time, I want to talk about a very important and too often overlooked topic - Accessibility. Hear me out, I promise to keep this one short.

Let's say you worked hard on creating your beautiful blurred design BUT some of your users have disabled blurs on their devices. What do you think will happen then? Let's check!

# Demo

On your device, or simulator, go to Settings -> General -> Accessibility -> Reduce Transperancy and flip the switch to On. Now, if we look at our sample app, oh no! This is totally not what we were going for. So what should we do?

# Interlude

In these situations it's usually best to just go back to the way things were before we added the blur. That way, it won't be blurred, but at least we'll have control over how things look and are able to provide a good user experience to our users who chose not to have blurred views in their apps (and I'm sure they have their reasons!).

Let's go back to the code and see how this is done.

# Demo

All we need to do, is check UIAccessibility.isReduceTransparencyEnabled and act accordingly. So, if it is enabled, we'll just add the optionsView as is, and skip all of the blur and vibrancy tricks that we added before. If not, this code block will simply be ignored and all of the magic that we previously added, will result in an awesome blurred options view for the users who chose not to disable it. Win-Win!

```swift
//more code would go here...
guard UIAccessibility.isReduceTransparencyEnabled == false else {
view.addSubview(optionsView)

NSLayoutConstraint.activate([
view.centerXAnchor.constraint(equalTo: optionsView.centerXAnchor),
view.centerYAnchor.constraint(equalTo: optionsView.centerYAnchor)
])

return
}
```

Let's just run and make sure that everything looks good.  Yup.

And just in case, let's bring back blurs (because life is so much better with them), and re-run our sample app. And now we have all of our blurry goodness again. Yay!

# Conclusion

Alright, that's now officially everything I wanted to say about UIVisualEffectView. I hope you'll use this new knowledge for good and not evil purposes (like having an all blurred app that will annoy your users and will make them question their eyesight). And may you only see blurry stuff on beautifully designed apps while still having clear vision in real life. Cheers!
