//
//  SidebarController.h
//  GuardianStats
//
//  Created by cevanoff on 12/30/14.
//
//

#import <UIKit/UIKit.h>

@class SidebarController;
@protocol SidebarControllerDelegate <UISplitViewControllerDelegate>

@end

@interface SidebarController : UISplitViewController

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UIViewController *sidebarViewController;
@property (nonatomic, assign) id <SidebarControllerDelegate> delegate;

@property (nonatomic, readonly) BOOL isSidebarVisible;

// sets how much the main view should be dimmed when the sidebar is presented
// defaults to 0 (no dimming)
@property (nonatomic) float mainViewDimmerAlpha;

// sets if the sidebar should close when the main view is tapped
// defaults to NO
@property(nonatomic) BOOL shouldAutoCollapse;

// opens the sidebar
-(void)openSidebarWithAnimation:(BOOL)shouldAnimate;

// closes the sidebar
-(void)closeSidebarWithAnimation:(BOOL)shouldAnimate;

// toggle the sidebar state
-(void)toggleSidebarWithAnimation:(BOOL)shouldAnimate;

@end
