//
//  TextFieldTableCellView.h
//  FBxplr
//
//  Created by andrea gonteri on 28/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "UIImageView+AFNetworking.h"

@interface TextFieldTableCellView : UITableViewCell
{

}

@property (MB_STRONG) UITextField * textField;
@property (MB_STRONG) UILabel * labelTitle;
@end
