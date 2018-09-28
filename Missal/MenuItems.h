//
//  MenuItem.h
//  Missal
//
//  Created by Kigen on 8/31/15.
//  Copyright (c) 2015 Strathmore University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItems : NSObject

@property(nonatomic, strong)NSString *menu_title;
@property(nonatomic, strong)NSString *file_resource;

+(id)menuItem: (NSString *)title file:(NSString *)file;

@end
