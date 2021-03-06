//
//  UserInfoViewController.h
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
 
#import "TextFieldTableCellView.h"
#import "EditUserInfoViewController.h"

@interface UserInfoViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (MB_STRONG) IBOutlet UITableView * tableView;

@property (MB_STRONG) NSArray * items;
@property (MB_STRONG) FBProfilePictureView *expandZoomImageView;

@end
