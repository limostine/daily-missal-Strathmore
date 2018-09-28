//
//  MenuItem.m
//  Missal
//
//  Created by Kigen on 8/31/15.
//  Copyright (c) 2015 Strathmore University. All rights reserved.
//

#import "MenuItems.h"

@implementation MenuItems
+(id)menuItem: (NSString *)title file:(NSString *)file{
    MenuItems *item = [[self alloc] init];
    item.menu_title = title;
    item.file_resource = file;
    return item;
}
@end
