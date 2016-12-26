//
//  ViewDetailController.m
//  iTableMultiSection
//
//  Created by Bui Duc Khanh on 12/7/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewDetailController.h"

@interface ViewDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblNational;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;

@end

@implementation ViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Detail";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void) setData: (NSDictionary *) data{
    self.lblNational.text = [data objectForKey:@"name"];
    self.title = self.lblNational.text;
    self.lblDetail.text = [data objectForKey:@"intro"];
    self.imgMain.image = [UIImage imageNamed:[data objectForKey:@"img"]];
}
@end
