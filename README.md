# SnappingHStack

# Usage

Just put this modifier on an HStack

.modifier(SnappingHStack(
    viewAmount:Int, 
    viewWidth:CGFloat, 
    scrollOffset:Binding<CGFloat>,
    screenWidth:CGFloat,
    switchSnapBound:CGFloat)
)

# viewAmount

In the viewAmount parameter, put the number of views that will be contained in your HStack

# viewWidth

Put the width of the views in the HStack, UIScreen.main.bounds.width returns the width of the screen you're on

# scrollOffset

declare a state variable for a scrollOffset and pass it into this parameter, the starting value should be set to:
    
    CGFloat(-(viewAmount - 1))*ScreenWidth / 2)   <- returns minimum scroll offset

You can then change the offset to whatever value is needed through other interactions in the app, and use the scroll offset to change other elements in your app.

# screenWidth

Pass UIScreen.main.bounds.width into this parameter, or whatever the width you want your HStack to display to the user at a time. 

# switchSnapBound

Pass a value from 0 to 1 to create the bounds needed to scroll in order to switch the view that gets snapped to. If set to 0.5, then swiping half way will switch the Snap to the next view in the HStack, any less will remain at the same view. 

Closer to 0, the smaller the bounds needed to switch to a new view
