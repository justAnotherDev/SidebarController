//
//  ViewController.m
//  SidebarDemo
//
//  Created by cevanoff on 12/30/14.
//  Copyright (c) 2014 cevanoff. All rights reserved.
//

#import "ViewController.h"
#import "SidebarController.h"

#import "MainViewController.h"
#import "SidebarViewController.h"


@interface ViewController ()
@property (nonatomic, strong) SidebarController *sidebarController;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	

	// create the "Side View Controller"
	// presented when the sidebar opens
	SidebarViewController *sideVC = [[SidebarViewController alloc] init];
	
	
	
	// create the "Main View Controller"
	// presented at launch as a fullscreen view
	MainViewController *mainVC = [[MainViewController alloc] init];
	
	// place the main view in a nav controller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
	
	
	// create the sidebar controller and set it's view controllers
	_sidebarController = [[SidebarController alloc] init];
	_sidebarController.mainViewController = navController;
	_sidebarController.sidebarViewController = sideVC;
	
	// customize the sidebar controller
	_sidebarController.mainViewDimmerAlpha = 0.6;
	_sidebarController.shouldAutoCollapse = YES;
	
	// present the sidebar controller using auto layout
	[self.view addSubview:_sidebarController.view];
	NSDictionary *views = @{@"sidebarController":_sidebarController.view};
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sidebarController]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sidebarController]|" options:0 metrics:nil views:views]];
	
	// add the bar button to dismiss the sidebar
	UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"OPEN" style:UIBarButtonItemStylePlain target:self action:@selector(openSidebarHit)];
	mainVC.navigationItem.leftBarButtonItem = aItem;
	

}

-(void)openSidebarHit {
	[_sidebarController openSidebarWithAnimation:YES];
}

@end
