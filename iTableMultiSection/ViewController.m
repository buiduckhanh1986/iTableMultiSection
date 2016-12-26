//
//  ViewController.m
//  iTableMultiSection
//
//  Created by Bui Duc Khanh on 12/5/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"
#import "ViewDetailController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray * data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Multi Section";
    
    // Tạo data
    data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    self.tableView.rowHeight = 70; // Chiều cao
    self.tableView.separatorColor = [UIColor whiteColor];
}


#pragma mark - Table view data source

// Trả về số section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return data.count;
}


// Trả về tiêu đề section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *continents = [data objectAtIndex:section];
    
    return [continents objectForKey:@"name"];
}


// Trả về số row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *continents = [data objectAtIndex:section];
    NSArray *items = [continents objectForKey:@"data"];
    
    return items.count;
}


// Thiết lập dữ liệu cho các cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.6];
    }
    
    NSDictionary *continents = [data objectAtIndex:indexPath.section];
    NSArray *items = [continents objectForKey:@"data"];
    
    NSDictionary* menuItem = items[indexPath.row];
    
    cell.textLabel.text = [menuItem objectForKey:@"name"];
    cell.detailTextLabel.text = [menuItem objectForKey:@"intro"];
    cell.imageView.image = [UIImage imageNamed:[menuItem objectForKey:@"img"]];
    
    CGSize itemSize = CGSizeMake(100, 66);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imgRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imgRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}


#pragma mark - UITableViewDelegate

// Chỉnh GUI cho title
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor brownColor];
    
    UITableViewHeaderFooterView *hfView = (UITableViewHeaderFooterView *)view;
    [hfView.textLabel setTextColor:[UIColor whiteColor]];
    
}


// Chỉnh GUI cho title
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    
    ViewDetailController* detailScreen = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewDetail"];

    
    NSDictionary *continents = [data objectAtIndex:indexPath.section];
    NSArray *items = [continents objectForKey:@"data"];
    
    NSDictionary* menuItem = items[indexPath.row];
    
    if ([detailScreen view]) {
        
        [detailScreen setData:menuItem];
        
        [self.navigationController pushViewController:detailScreen animated:YES];

    }

    
    
}
@end
