//
//  WebViewController.h
//  Missal
//
//  Created by Kigen on 8/20/15.
//  Copyright (c) 2015 Strathmore University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iOS-Slide-Menu/SlideNavigationController.h>


@interface WebViewController : UIViewController<UIWebViewDelegate, SlideNavigationControllerDelegate>

@property(nonatomic, strong)NSString *file_resource;
@property(nonatomic, strong)NSString *load_div;
- (IBAction)calendarClick:(id)sender;


@end
