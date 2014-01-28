//
//  TextFieldTableCellView.m
//  FBxplr
//
//  Created by andrea gonteri on 28/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "TextFieldTableCellView.h"

@implementation TextFieldTableCellView


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // _labelTitle
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 44)];
        self.labelTitle.font = [UIFont boldFlatFontOfSize:11];
         self.labelTitle.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview: self.labelTitle];
        // RELEASE_OBJ(_labelTitle);
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 2, self.frame.size.width-100, 40)];
        
        
        self.textField.textColor = [UIColor blackColor];
        self.textField.font = [UIFont flatFontOfSize:12];
        self.textField.backgroundColor = [UIColor cloudsColor];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
       // self.textField.layer.borderColor = [UIColor colorWithHex:0xcccccc].CGColor;
        self.textField.layer.borderWidth = 1;
        self.textField.layer.cornerRadius = 4;
        [self.contentView addSubview:self.textField];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextFieldEnabled:(BOOL)enabled
{
    if(!enabled){
        self.textField.enabled = NO;
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.layer.borderWidth = 0;
        self.textField.font = [UIFont boldFlatFontOfSize:11];
        self.textField.textColor = [UIColor greenSeaColor];
    }
}


@end
