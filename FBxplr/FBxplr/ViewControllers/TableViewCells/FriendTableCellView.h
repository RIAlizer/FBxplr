//
//  FriendTableCellView.h
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "UIImageView+AFNetworking.h"

@interface FriendTableCellView : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _labelTitle;
    UILabel * _labelSubtitle;
}

@property (MB_STRONG) Friend * item;
@end
