    //
    //  LeftMenuViewController.h
    //  Missal
    //
    //  Created by Kigen on 8/20/15.
    //  Copyright (c) 2015 Strathmore University. All rights reserved.
    //

#import <UIKit/UIKit.h>
#import <iOS-Slide-Menu/SlideNavigationController.h>
@interface LeftMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *arrayForBool;
    NSArray *sectionTitleArray;

}
@property (weak, nonatomic) IBOutlet UITableView *expandableTableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@end
