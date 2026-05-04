# Graph Report - /Users/luowei/projects/libs/LWDrawboard  (2026-05-04)

## Corpus Check
- Corpus is ~33,832 words - fits in a single context window. You may not need a graph.

## Summary
- 381 nodes · 369 edges · 24 communities detected
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]
- [[_COMMUNITY_Community 22|Community 22]]
- [[_COMMUNITY_Community 23|Community 23]]

## God Nodes (most connected - your core abstractions)
1. `LWDrawView` - 38 edges
2. `DrawType` - 19 edges
3. `LWBrushBoardViewController` - 17 edges
4. `AFBrushBoard` - 17 edges
5. `LWDrawToolsView` - 15 edges
6. `LWDrawView` - 15 edges
7. `UIBezierPath` - 14 edges
8. `LWDrawViewModel` - 12 edges
9. `LWHandwrittingView` - 9 edges
10. `LWTileImagesView` - 8 edges

## Surprising Connections (you probably didn't know these)
- `LWDrawView` --inherits--> `View`  [EXTRACTED]
  LWDrawboard_swift/SwiftUI/LWDrawView.swift →   _Bridges community 5 → community 8_

## Communities (45 total, 1 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.04
Nodes (45): LWControlImgV, LWControlView, -drawRect, -initWithFrame, -setHidden, LWDrawView, -bezMakerWithNKT, -compWithNandK (+37 more)

### Community 1 - "Community 1"
Cohesion: 0.06
Nodes (34): LWColorCell, -colorView, -initWithFrame, -layoutSubviews, LWDrawBar, -drawBarWithFrame, -initWithFrame, -layoutSubviews (+26 more)

### Community 2 - "Community 2"
Cohesion: 0.08
Nodes (24): CaseIterable, Int, DrawConstants, DrawStatus, drawing, editing, texting, DrawType (+16 more)

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (21): NSString, -image, UIBezierPath, -moveCenterToPoint, -rotateDegree, -scaleWidthscaleHeight, UIColor, -colorComponentFromstartlength (+13 more)

### Community 4 - "Community 4"
Cohesion: 0.11
Nodes (7): CGPoint, GeometryUtilities, String, UIBezierPath, UIColor, UIImage, View

### Community 5 - "Community 5"
Cohesion: 0.11
Nodes (12): AnyObject, PreviewProvider, ColorPickerView, EmojiPickerView, FontPickerView, LWDrawBar, LWDrawboardExample, LWDrawboardExample_Previews (+4 more)

### Community 6 - "Community 6"
Cohesion: 0.11
Nodes (17): LWBrushBoardViewController, -colorPenBtnTouchUpInside, -colorPickerViewpickedColor, -colorWheelBtnTouchUpInside, -drawClearBtnTouchUpInside, -drawSaveBtnTouchUpInside, -hideDrawColorPickerView, -hideDrawPenPickerView (+9 more)

### Community 7 - "Community 7"
Cohesion: 0.11
Nodes (17): AFBrushBoard, -bezMakerWithNKT, -changeImage, -cleanDrawImage, -compWithNandK, -curveFactorizationWithFromPointtoPointcontrolPointscount, -drawRect, -initWithFrame (+9 more)

### Community 9 - "Community 9"
Cohesion: 0.13
Nodes (4): Identifiable, ObservableObject, LWDrafter, LWDrawViewModel

### Community 10 - "Community 10"
Cohesion: 0.13
Nodes (15): LWDrawToolsView, -collectionViewcellForItemAtIndexPath, -collectionViewdidDeselectItemAtIndexPath, -collectionViewdidSelectItemAtIndexPath, -collectionViewlayoutsizeForItemAtIndexPath, -collectionViewnumberOfItemsInSection, -initWithFramecollectionViewLayout, -numberOfSectionsInCollectionView (+7 more)

### Community 11 - "Community 11"
Cohesion: 0.13
Nodes (14): UIBezierPath, -addDashes, -applyPathPropertiesToContext, -center, -clipToPath, -clipToStroke, -computedBounds, -computedBoundsWithLineWidth (+6 more)

### Community 12 - "Community 12"
Cohesion: 0.2
Nodes (9): LWHandwrittingView, -drawCurveWithPoints, -drawRect, -handwrittingViewWithFramedelegate, -initWithFrame, -touchesBeganwithEvent, -touchesCancelledwithEvent, -touchesEndedwithEvent (+1 more)

### Community 13 - "Community 13"
Cohesion: 0.25
Nodes (7): LWAppDelegate, -applicationDidBecomeActive, -applicationDidEnterBackground, -applicationdidFinishLaunchingWithOptions, -applicationWillEnterForeground, -applicationWillResignActive, -applicationWillTerminate

### Community 14 - "Community 14"
Cohesion: 0.25
Nodes (7): LWViewController, -getAllAssetInPhotoAblumWithAscending, -penDrawboardAction, -requestImageForAssetsizecompletion, -resetBtnAction, -simpleDrawboardAction, -viewDidLoad

### Community 15 - "Community 15"
Cohesion: 0.25
Nodes (7): NSObject, -is_iPad, -vibrate, UIButton, -hitTestEdgeInsets, -pointInsidewithEvent, -setHitTestEdgeInsets

### Community 16 - "Community 16"
Cohesion: 0.25
Nodes (7): LWDrawBoardPenPickerView, -brightnessSlideChanged, -colorPickerDidChangeSelection, -currentColorBtnTouchUpInside, -initWithFrame, -penPickerWithFramedelegate, -penSizeSliderChanged

### Community 17 - "Community 17"
Cohesion: 0.25
Nodes (7): LWDrawboardColorPickerView, -brightnessSlideChanged, -colorPickerDidChangeSelection, -colorPickerWithFramedelegate, -currentColorBtnTouchUpInside, -initWithFrame, -opacitySliderChanged

### Community 18 - "Community 18"
Cohesion: 0.25
Nodes (7): LWDrawWrapView, -drawWrapViewWithDelegate, -editBtnAction, -getAllAssetInPhotoAblumWithAscending, -initWithFrame, -requestTileImageForAssetsizecompletion, -resetDrawing

### Community 19 - "Community 19"
Cohesion: 0.25
Nodes (8): LWTileImagesView, -collectionViewcellForItemAtIndexPath, -collectionViewdidSelectItemAtIndexPath, -collectionViewnumberOfItemsInSection, -collectionViewviewForSupplementaryElementOfKindatIndexPath, -initWithFrame, -layoutSubviews, -showTileImagesView

### Community 20 - "Community 20"
Cohesion: 0.29
Nodes (6): LWHandwrittingViewController, -touchCancelledWithPathPoints, -touchMovedWithPointpathPoints, -touchMoveEndWithPointpathPoints, -viewDidLoad, LWHandWrittingWrapView

### Community 21 - "Community 21"
Cohesion: 0.29
Nodes (7): LWColorSelectorView, -collectionViewcellForItemAtIndexPath, -collectionViewdidSelectItemAtIndexPath, -collectionViewnumberOfItemsInSection, -initWithFrame, -layoutSubviews, -showColorSelectorViewInView

### Community 22 - "Community 22"
Cohesion: 0.33
Nodes (5): LWDrafter, -burshSize, -color, -init, -shadow

### Community 23 - "Community 23"
Cohesion: 0.4
Nodes (4): Tests, -setUp, -tearDown, -testExample

## Knowledge Gaps
- **230 isolated node(s):** `-setUp`, `-tearDown`, `-testExample`, `-viewDidLoad`, `-viewWillAppear` (+225 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `LWDrawView` connect `Community 8` to `Community 5`?**
  _High betweenness centrality (0.041) - this node is a cross-community bridge._
- **What connects `-setUp`, `-tearDown`, `-testExample` to the rest of the system?**
  _230 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.06 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.08 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.09 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.11 - nodes in this community are weakly interconnected._