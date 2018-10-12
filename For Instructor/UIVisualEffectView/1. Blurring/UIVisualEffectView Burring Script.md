# Intro

Hey everybody, I'm Rony, and in this screencast I want to talk to you about UIVisualEffectView and how you can use it in your apps.

Blurs became a big part of our lives back in iOS7, when Apple made a dramatic design change to iOS, and since then, you can see them more commonly used throughout various apps. Two examples you probably interact with multiple times a day are **[Slide 01]** Control Center and Notifications Center. Each of these panels take a slightly different spin on blurs: one blurring the entire background and the other blurring just the background of each specific notification. But both provide a great user experience and ensure the important content stands out regardless of what the current background happens to be. 
Your users, and human beings in general, have a tendency to pay attention to elements that are in focus and ignore those that aren't. Also, it's clear to us that swiping up in these situations will bring us back to the blurred view in the background. Keep these assumptions in mind when deciding when and how to use blurs in your own apps...

> Editor: At this point, the slide should disappear, but the new slide will only appear in a few sentences... 
> Editor: Also, I want all of the slide to appear on the top left part of the screen, next to my talking head... :] Instead of full screen. Is that an option?

Apple provides an easy way to implement this kind of effect, and that is, you guessed it - UIVisualEffectView. But before we dive into the implementation details, let's briefly discuss how blurs actually work.

## How Blurs Work

To acheive a blur, you need to apply a blurring algorithm to each of the image's pixels. There are many blurring algorithms out there, but for this breif explanation, we'll use Gaussian blur. For each pixel, we'll examine the surrounding pixels to calculate its new blurred value. If we look at this grid, for example: **[Slide 02]** and assume that each pixel can be represented by a value between 1 and 10. We're currently applying the algorithm to the middle pixel by averaging the values of its sorrounding pixels, resulting in: **[Slide 03]**. If we then repeat this process for every single pixel in the original image, we'll get our blurred image. **[Slide 04]** If we want to make our image blurrier (if that's even a word), we can increase the blur radius. So instead of averaging the value of a single pixel in each direction, we'll use a radius of 2, 3 or even more pixels in each direction, resulting in something more like this **[Slide 05]**.

Note that generally speaking, the greater the blur radius, the greater the processing power needed to generate the new image (not to mention the potential strain on the user's eyes). So, use it wisely...

# Demo

Ok, now it's time to see what this all means in code. 
I have this very cool app that displays Brothers Grimm fairytales. When I click on this button, an options view appears. I think, it'll provide a better user experience and will look much cooler with a blur. So, in order to acheive this, I'll use UIBlurEffect (which is a subclass of UIVisualEffect), by applying it to a UIVisualEffectView, which will be added to the same view whose background we want to blur. In other words:

```swift
view.backgroundColor = .clear
let blurEffect = UIBlurEffect(style: .light)
let blurView = UIVisualEffectView(effect: blurEffect)
blurView.translatesAutoresizingMaskIntoConstraints = false
view.insertSubview(blurView, at: 0)
```

Note that the background of the superview of the view whose content we want to blur, has to be transperant. We created a blur effect with a certain style (there are also others you can choose from), and then created a UIVIsualEffectView using that blur. We then added the new view to the bottom of the view stack (so that it'll only blur the background and not the view's controllers).

Finally, we just need to make sure that the new UIVisualEffects view is laid out properly, covering the entire view whose background we want to blur:

```swift
NSLayoutConstraint.activate([
blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
])
```

Let's build and run... Now you can see we have a cool blur effect, that's easily noticable (and updated in real time) as the user scrolls the fairytale displayed in the back. Pretty awesome, right?

# Conclusion

Ok, that was all I wanted to cover in this screencast. Note that we only discussed the basics of what you can do with UIVisualEffectsView. If you wanna hear more about it, stay tuned for future screencasts on more topics like Visual Effects Vibrancy and Accessibility. Can't wait, right? Well, in the meantime, you can play around with adding cool visual effects to your apps and experiment with the different options we didn't get a chance to cover, and just remember - with great power comes great responsiblity. In other words, you CAN blur evertyhing in your app, but please don't. I (and your future users) will really appriciate this. Thank you very much in advance... :]
