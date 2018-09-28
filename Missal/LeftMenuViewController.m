//
//  LeftMenuViewController.h
//  Missal
//
//  Created by Kigen on 8/20/15.
//  Copyright (c) 2015 Strathmore University. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MenuItems.h"
#import "LeftMenuViewController.h"
#import "WebViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"



@interface LeftMenuViewController ()
@property(nonatomic, strong)NSArray *menu;
@end

@implementation LeftMenuViewController

#pragma mark - Getters & Setters
-(NSArray *)menu{
    if(!_menu){
        //First menu items ungrouped
        MenuItems *home = [MenuItems menuItem:@"Home" file:@"Index"];
        //MenuItems *calendar = [MenuItems menuItem:@"Calendar" file:@"Calendar"];
        MenuItems *introductory_rites = [MenuItems menuItem:@"Introductory Rites" file:@"Introductory Rites"];
        MenuItems *prayer_texts = [MenuItems menuItem:@"Prayer Texts" file:@"Prayers"];
        MenuItems *gloria = [MenuItems menuItem:@"Gloria" file:@"Introductory Rites"];
        MenuItems *readings = [MenuItems menuItem:@"Readings" file:@"Readings"];
        MenuItems *credo = [MenuItems menuItem:@"Credo" file:@"Introductory Rites"];
        MenuItems *prayers_faithfull = [MenuItems menuItem:@"Prayers Faithful" file:@"Prayer of the Faithful"];
        MenuItems *offertory = [MenuItems menuItem:@"Offertory" file:@"Offertory"];
        MenuItems *prefaces = [MenuItems menuItem:@"Prefaces" file:@"Prefaces"];
        
        NSArray *first_array =   @[
                                   home,
                                   introductory_rites,
                                   prayer_texts,
                                   gloria,
                                   readings,
                                   credo,
                                   prayers_faithfull,
                                   offertory,
                                   prefaces
                                   ];
        
        NSDictionary *first_ungrouped = @{@"first_ungrouped" : first_array};
        
        
        //Eucharistic prayers - Grouped
        MenuItems *prayer_I = [MenuItems menuItem:@"Prayer I" file:@"Eucharistic Prayer I"];
        MenuItems *prayer_II = [MenuItems menuItem:@"Prayer II" file:@"Eucharistic Prayer II"];
        MenuItems *prayer_III = [MenuItems menuItem:@"Prayer III" file:@"Eucharistic Prayer III"];
        MenuItems *prayer_IV = [MenuItems menuItem:@"Prayer IV" file:@"Eucharistic Prayer IV"];
        MenuItems *additional_prayer = [MenuItems menuItem:@"Additional Prayers" file:@"Eucharistic Prayers Additional"];
        
        NSArray *eucharistic_array = @[
                                       prayer_I,
                                       prayer_II,
                                       prayer_III,
                                       prayer_IV,
                                       additional_prayer
                                       ];
        
        NSDictionary *eucharistic_prayers = @{@"Eucharistic Prayers" : eucharistic_array};
        
        //Communion rite - Ungrouped
        MenuItems *communion_rite = [MenuItems menuItem:@"Communion Rite" file:@"Communion Rite"];
        
        NSArray *communion_rite_array = @[communion_rite];
        
        NSDictionary *second_ungrouped = @{@"second_ungrouped": communion_rite_array};
        
        //Others grouped
        MenuItems *communion_outside_mass = [MenuItems menuItem:@"Communion Outside Mass" file:@"Communion Outside Mass"];
        MenuItems *communion_for_the_sick = [MenuItems menuItem:@"Communion For The Sick" file:@"Communion Sick"];
        MenuItems *index_celebrations = [MenuItems menuItem:@"Index Celebrations" file:@"Index Celeb"];
        MenuItems *index_celebrations_by_date = [MenuItems menuItem:@"Index Celebrations By Date" file:@"Index Celeb Dates"];
        MenuItems *liturgical_calendar = [MenuItems menuItem:@"Liturgical Calendar" file:@"Liturgical Calendar"];
        MenuItems *appendix = [MenuItems menuItem:@"Appendix" file:@"Appendix"];
        MenuItems *treasury_prayers = [MenuItems menuItem:@"Treasury prayers" file:@"TREASURY OF PRAYERS"];
        
        NSArray *others_array = @[
                                  communion_outside_mass,
                                  communion_for_the_sick,
                                  index_celebrations,
                                  index_celebrations_by_date,
                                  liturgical_calendar,
                                  appendix,
                                  treasury_prayers
                                  ];
        NSDictionary *others = @{@"Others" : others_array};
        
        _menu = @[
                  first_ungrouped,
                  eucharistic_prayers,
                  second_ungrouped,
                  others
                  ];
        
    }
    return _menu;
}

#pragma  mark - Initialization
- (id)initWithCoder:(NSCoder *)aDecoder{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}


-(void)initialization
{
    arrayForBool=[[NSMutableArray alloc]init];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for(int i=0; i<self.menu.count; i++){
        NSDictionary *dict = self.menu[i];
        
        NSArray *keys = dict.allKeys;
        
        NSString *key = keys.firstObject;
        
        [temp addObject:key];
    }
    
    sectionTitleArray=[[NSArray alloc] initWithArray:temp];
    
    for (int i=0; i<[sectionTitleArray count]; i++) {
        
        BOOL temp = NO;
        if([sectionTitleArray[i] isEqualToString:@"first_ungrouped"] || [sectionTitleArray[i] isEqualToString:@"second_ungrouped"] ){
            temp=YES;
            
        }
        [arrayForBool addObject:[NSNumber numberWithBool:temp]];
    }
    
    //Space menu at the top
    CGRect frame = CGRectMake(0, 0, self.expandableTableView.bounds.size.width, 64);
    UIView *tableHeader = [[UIView alloc] initWithFrame:frame];
    //tableHeader.backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithRed:207.0/256 green:19.0/256 blue:38.0/256 ]];
    self.expandableTableView.tableHeaderView = tableHeader;
    
}

#pragma mark - UITapGestureRecognizer
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[sectionTitleArray count]; i++) {
            if (indexPath.section==i) {
                [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [_expandableTableView reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}


#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialization];
    self.expandableTableView.backgroundView = [[UIImageView alloc] initWithImage:
                                               [UIImage imageNamed:@"bg.jpg"]];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    @try {
        
        NSDictionary *dict = self.menu[section];
        
        NSArray *keys = dict.allKeys;
        
        NSString *key = keys.firstObject;
        
        NSArray *values = [dict objectForKey:key];
        
        return values.count;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception.debugDescription);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu_cell"];
    
    
    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    
    NSDictionary *dict = self.menu[indexPath.section];
    
    NSArray *keys = dict.allKeys;
    
    NSString *key = keys.firstObject;
    
    NSArray *values = [dict objectForKey:key];
    
    MenuItems *item = values[indexPath.row];
    
    // If the section supposed to be closed
    if(!manyCells){
        cell.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.text=@"";
    }
    //If the section supposed to be Opened
    else{
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.text = item.menu_title;
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sectionTitleArray count];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    
    WebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"webView"];
    
    @try {
        
        NSDictionary *dict = self.menu[indexPath.section];
        
        NSArray *keys = dict.allKeys;
        
        NSString *key = keys.firstObject;
        
        NSArray *values = [dict objectForKey:key];
        
        MenuItems *item = values[indexPath.row];
        
        webViewController.file_resource = item.file_resource;
        
        
        
        
        [self.expandableTableView deselectRowAtIndexPath:[self.expandableTableView indexPathForSelectedRow] animated:YES];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:webViewController withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
        
        NSString *html_div = @"";
        
        if([item.menu_title isEqualToString:@"Gloria"]){
            html_div = @"#gloria";
        }
        
        
        if([item.menu_title isEqualToString:@"Credo"]){
            html_div = @"#creed";
        }
        
        NSString *view_title = [item.menu_title isEqualToString:@"Home"] ? @"Daily Missal" : item.menu_title;
        
        
        NSDictionary *userInfo = @{@"file_resource" : item.file_resource, @"html_div" : html_div, @"view_title" : view_title};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh_page" object:nil userInfo:userInfo];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"Cell/Row exception: %@", exception.debugDescription);
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 40;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    @try{
        NSDictionary *dict = self.menu[section];
        
        NSArray *keys = dict.allKeys;
        
        NSString *key = keys.firstObject;
        
        if([key isEqualToString:@"first_ungrouped"] || [key isEqualToString:@"second_ungrouped"]){
            return 0;
        }else{
            return 30;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception.debugDescription);
    }
}

#pragma mark - UITableView Headers

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,30)];
    //sectionView.backgroundColor = [UIColor lightGrayColor];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _expandableTableView.frame.size.width-10, 40)];
    //viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"%@",sectionTitleArray[section]];
    [sectionView addSubview:viewLabel];
    
    //UITapGestureRecognizer
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return  sectionView;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
