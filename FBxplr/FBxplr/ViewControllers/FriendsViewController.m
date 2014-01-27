//
//  FriendsViewController.m
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@property (MB_STRONG) UITableView * tableView;
@property (MB_STRONG) NSArray * items;
@end


static NSString *CellIdentifier = @"_FriendTableCellView";



@implementation FriendsViewController

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
    self.navigationItem.title = LSTR(@"Friends");
    [self createTableView];
    
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



@end
