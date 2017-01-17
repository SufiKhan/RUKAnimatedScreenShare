RUKAnimatedScreenShare.

Share a View or Image with animation.
Add the View as a subview to RUKShareView via Storyboard or Code.
Just add these lines.

```
let sharingView = RUKShareView!           
sharingView.showShareOptions(networkIcons:networksIcons,networkNames: networksTitles, _completion: { (_index) in
// get the selected tab index.
})

```
