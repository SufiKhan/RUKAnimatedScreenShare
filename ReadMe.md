#RUKAnimatedScreenShare.

Share a View or Image with animation.
Add the View as a subview to RUKShareView via Storyboard or Code.
Just add these lines.

```
let sharingView = RUKShareView!           
sharingView.showShareOptions(networkIcons:networksIcons,networkNames: networksTitles, _completion: { (_index) in
// get the selected tab index.
})

```

![demo](https://cloud.githubusercontent.com/assets/13538306/22010553/f210b7f8-dcaf-11e6-8200-550f6b7029c9.gif)

Thank you.
