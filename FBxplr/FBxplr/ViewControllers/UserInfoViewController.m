//
//  UserInfoViewController.m
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@property (MB_STRONG) UITableView * tableView;
@property (MB_STRONG) NSArray * items;
@property (MB_STRONG) FBProfilePictureView *expandZoomImageView;
@end


static NSString *CellIdentifier = @"_UserInfoViewController";
static CGFloat kImageZoomHeight = 240.f;


@implementation UserInfoViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    RELEASE_OBJ(_tableView);
    SUPER_DEALLOC();
}

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self setupUI];
}

-(void)setupUI
{
    self.navigationItem.title = LSTR(@"Info");
    
   
    
    [self createTableView];
    
    self.expandZoomImageView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(0, -kImageZoomHeight, self.view.size.width, kImageZoomHeight)];
    
    self.expandZoomImageView.profileID = [AppManager sharedInstance].currentUser.uid;
    self.expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageZoomHeight, 0, 0, 0);
    [self.tableView addSubview:self.expandZoomImageView];
    
    [self loadData];
    
}

-(void)updateUI
{
    [self.tableView reloadData];
}

-(void)createTableView
{
    if(self.tableView)
    {
        SAFE_REMOVE_SUBVIEWS(self.tableView);
        RELEASE(self.tableView);
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    
    // Register Class for Cell Reuse Identifier
    [self.tableView registerClass:[FriendTableCellView class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    //self.tableView.backgroundColor = [UIColor clearColor ];
    [self.view addSubview:self.tableView];
    RELEASE(self.tableView);
    

    
}

-(void)loadData
{
    [self showActivity];
    
    [[FacebookManager sharedInstance] findFriendsWithCompletion:^(NSArray * friends) {
        
        //success
        self.items = friends;
        [self updateUI];
        [self hideActivity];
        
        
    } failure:^(NSError *error) {
        //failure
        [self hideActivity];
        
        
        [AppManager showError:error];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageZoomHeight)
    {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
    }
}


#pragma mark - UITableVieDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   // Friend * friend = [self.items objectAtIndex: indexPath.row ];
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure Cell
    
 
    
    return cell;
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Friend * friend = [self.items objectAtIndex: indexPath.row ];
    
    
    FriendTableCellView *cell = (FriendTableCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure Cell
    
    
    // Set the data for this cell:
    [cell setItem:friend];
    
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend * friend = [self.items objectAtIndex: indexPath.row ];
    ULog(@"id: %@", friend.uid);
}
*/


@end
