import SwiftUI

@available(iOS 14, macOS 10.15, *)
public struct SnappingHStack: ViewModifier {
    @Binding private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    @State private var initialOffset: CGFloat
    @State var index: CGFloat
    @State var oldIndex: Int
    
    public var ScreenWidth: CGFloat
    public var viewAmount: Int
    public var viewWidth: CGFloat
    public var viewSpacing: CGFloat
    
    public init(viewAmount:Int, viewWidth:CGFloat, viewSpacing:CGFloat, scrollOffset:Binding<CGFloat>,screenWidth:CGFloat) {
        
        self.ScreenWidth = screenWidth
        self.viewAmount = viewAmount
        self.viewWidth = viewWidth
        self.viewSpacing = viewSpacing
        self.index = CGFloat(viewAmount)
        self.oldIndex = viewAmount - 1
        
        let totalWidth:CGFloat = CGFloat(viewAmount) * viewWidth + viewSpacing * CGFloat(viewAmount-1)
        
        let initialOffset = (totalWidth/2) - (screenWidth/2)
        
        self._scrollOffset = scrollOffset
        
        self._dragOffset = State(initialValue: 0)
        self._initialOffset = State(initialValue: initialOffset)
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(x:dragOffset + scrollOffset)
            .gesture(DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.width
                })
                    .onEnded({ event in
                        initialOffset = 0
                        
                        scrollOffset += event.translation.width
                        dragOffset = 0
                        
                        let contentWidth: CGFloat = CGFloat(viewAmount) * viewWidth + CGFloat(viewAmount - 1) * viewSpacing
                        
                        let midpoint = scrollOffset + (contentWidth / 2.0)
                        
                        index = (midpoint) / (viewWidth + viewSpacing)
                        
                        if index - 0.5 < CGFloat(oldIndex){
                            if CGFloat(oldIndex) - (index - 0.5) > 0.05 {
                                print("1st \(index)")
                                oldIndex -= 1
                                index = CGFloat(oldIndex)
                                print("2nd \(index)")

                            } else {
                                print("3rd \(index)")

                                index = (CGFloat(oldIndex))
                                print("4th \(index)")

                            }
                        } else {
                            if (index - 0.5) - CGFloat(oldIndex) > 0.5 {
                                print("5th \(index)")

                                oldIndex += 1
                                index = CGFloat(oldIndex)
                                print("6th \(index)")

                            } else{
                                print("7th \(index)")

                                index = CGFloat(oldIndex)
                                print("8th \(index)")

                            }
                        }
                        
                        index = min(index, CGFloat(viewAmount) - 1)
                        index = max(index, 0)
                        
                        var newOffset = index * viewWidth + (index - 1) * viewSpacing - (contentWidth/2.0) + (ScreenWidth / 2.0) - ((ScreenWidth - viewWidth) / 2.0) + viewSpacing
                        
                        newOffset = min(newOffset,CGFloat((viewAmount - 1))*ScreenWidth / 2)
                        newOffset = max(newOffset,CGFloat(-(viewAmount - 1))*ScreenWidth / 2)
                        
                        withAnimation{
                            scrollOffset = newOffset
                        }
                        
                    })
            )
        
    }
}

