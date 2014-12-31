//
//  SidebarController.m
//  GuardianStats
//
//  Created by cevanoff on 12/30/14.
//
//

#import "SidebarController.h"

@interface SidebarController () <UISplitViewControllerDelegate>
@property (nonatomic, strong) UIView *blockerView;
@end

@implementation SidebarController

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
	self.presentsWithGesture = NO;
}

-(void)setMainViewController:(UIViewController *)mainViewController {
	if (mainViewController == _mainViewController)
		return;
	
	// remove the existing main vc
	NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
	[viewControllers removeObject:_mainViewController];
	
	// update the main vc
	_mainViewController = mainViewController;
	
	// add the main view controller at index 1
	if (_mainViewController)
		[viewControllers addObject:_mainViewController];
	
	// update the view controllers
	[self setViewControllers:viewControllers];
}
-(void)setSidebarViewController:(UIViewController *)sidebarViewController {
	if (sidebarViewController == _sidebarViewController)
		return;
	
	// remove the existing sidebar vc
	NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
	[viewControllers removeObject:_sidebarViewController];
	
	// update the main vc
	_sidebarViewController = sidebarViewController;
	
	// if it exists then add it at index 0
	if (_sidebarViewController)
		[viewControllers insertObject:_sidebarViewController atIndex:0];
	
	// update the view controllers
	[self setViewControllers:viewControllers];
	
}

-(void)openSidebarWithAnimation:(BOOL)shouldAnimate {
	
	if (_isSidebarVisible)
		return;
	
	_isSidebarVisible = YES;
	
	_blockerView = [[UIView alloc] init];
	_blockerView.translatesAutoresizingMaskIntoConstraints = NO;
	_blockerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
	_blockerView.exclusiveTouch = YES;
	[_mainViewController.view addSubview:_blockerView];
	
	// add gesture recognizer to the blocker view if we should auto collapse when tapped off screen
	if (_shouldAutoCollapse) {
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSidebarWithAnimation:)];
		[_blockerView addGestureRecognizer:tapRecognizer];
	}
	
	NSDictionary *views = NSDictionaryOfVariableBindings(_blockerView);
	[_mainViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_blockerView]|" options:0 metrics:nil views:views]];
	[_mainViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_blockerView]|" options:0 metrics:nil views:views]];
	
	
	void (^changeBlock)(void) = ^ {
		self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
		_blockerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:_mainViewDimmerAlpha];
	};
	
	if (!shouldAnimate) {
		changeBlock();
		return;
	}

	[_mainViewController.view layoutIfNeeded];
	[UIView animateWithDuration:0.5 animations:changeBlock];
}

-(void)closeSidebarWithAnimation:(BOOL)shouldAnimate {
	
	if (!_isSidebarVisible)
		return;
	
	_isSidebarVisible = NO;
	
	void (^changeBlock)(void) = ^ {
		self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
		_blockerView.alpha = 0;
	};
	
	void (^completionBlock)(BOOL) = ^(BOOL complete) {
		[_blockerView removeFromSuperview];
		_blockerView = nil;
	};
	
	
	if (!shouldAnimate) {
		changeBlock();
		completionBlock(YES);
		return;
	}
	
	[_mainViewController.view layoutIfNeeded];
	[UIView animateWithDuration:0.5 animations:changeBlock completion:completionBlock];
}


-(void)toggleSidebarWithAnimation:(BOOL)shouldAnimate {
	if (!_isSidebarVisible) {
		[self openSidebarWithAnimation:shouldAnimate];
	} else {
		[self closeSidebarWithAnimation:shouldAnimate];
	}
}


@end
