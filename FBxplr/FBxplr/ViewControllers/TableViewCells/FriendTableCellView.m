//
//  FriendTableCellView.m
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "FriendTableCellView.h"

@implementation FriendTableCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float imageViewWidth = 60;//self.frame.size.height;
        // _imageView
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewWidth, imageViewWidth)];
        _imageView.layer.cornerRadius = 10;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;

        [self.contentView addSubview:_imageView];
        // RELEASE_OBJ(_imageView);
        
        // _labelTitle
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageViewWidth, 0, self.frame.size.width, 24)];
        [self.contentView addSubview:_labelTitle];
        // RELEASE_OBJ(_labelTitle);
        
        // _labelSubtitle
        _labelSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(imageViewWidth, 24, self.frame.size.width, 24)];
        [self.contentView addSubview:_labelSubtitle];
        //RELEASE_OBJ(_labelSubtitle);
        
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


-(void)setItem:(Friend *)item
{
    _item = item;
    
    _labelTitle.text = [NSString stringWithFormat:@" %@",item.name];
    
    //_labelSubtitle.text = [item.timestamp distanceOfTimeInWords];
    
    [ _imageView setImageWithURL:[NSURL URLWithString:item.pictureFriend.url]];
    
    // set the accessory view:
    self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

@end
