//
//  UserInfoViewController.m
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIImage+FlatUI.h"
#import "UITableViewCell+FlatUI.h"
#import "TPKeyboardAvoidingTableView.h"


//#define kIndex_name 0
#define kIndex_first_name   0
#define kIndex_last_name    1
#define kIndex_username     2
#define kIndex_middle_name  3
#define kIndex_link         4


static NSString *CellIdentifier = @"_UserInfoViewController";
static CGFloat kImageZoomHeight = 120.f;


@implementation UserInfoViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    RELEASE_OBJ(_expandZoomImageView);
    RELEASE_OBJ(_tableView);
    RELEASE_OBJ(_items);
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    [self createTableView];
    
    // self.expandZoomImageView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(0, -kImageZoomHeight, self.view.size.width, kImageZoomHeight)];
    self.expandZoomImageView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, kImageZoomHeight)];
    //    self.tableView.contentInset = UIEdgeInsetsMake(kImageZoomHeight, 0, 0, 0);
    //  [self.tableView addSubview:self.expandZoomImageView];
    
    
    self.expandZoomImageView.profileID = [AppManager sharedInstance].currentUser.uid;
    self.expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.tableView.tableHeaderView = self.expandZoomImageView;
    
    
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    //buttonSave
    FUIButton * buttonSave = [[FUIButton alloc] initWithFrame:CGRectMake(60, 10, 200, 44)];
    [buttonSave setTitle: LSTR(@"Save") forState:UIControlStateNormal];
    buttonSave.buttonColor = [UIColor turquoiseColor];
    buttonSave.shadowColor = [UIColor greenSeaColor];
    buttonSave.shadowHeight = 3.0f;
    buttonSave.cornerRadius = 6.0f;
    buttonSave.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [buttonSave setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [buttonSave setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [viewFooter addSubview:buttonSave];
    [buttonSave addTarget:self action:@selector(buttonSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    RELEASE_OBJ(buttonSave);
    
    self.tableView.tableFooterView = viewFooter;
    RELEASE_OBJ(viewFooter);
    
    
    [self loadData];
    
}

-(void)buttonSaveClicked:(id)sender
{
    ULog(@"SAVED");
    
    User * clone = [self cloneUserFromUI];
    
    ALog(@"%@",clone.first_name);
    
    
}

-(void)updateUI
{
    [self.tableView reloadData];
}

-(void)createTableView
{
    
    // Register Class for Cell Reuse Identifier
    [self.tableView registerClass:[TextFieldTableCellView class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0);
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    self.tableView.rowHeight = 44;
    self.tableView.allowsSelection = NO;
    //self.tableView.backgroundColor = [UIColor clearColor ];
    
    
    
}




-(void)loadData
{
    [self showActivity];
    
    
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
    
    [array insertObject:@"first_name"  atIndex:kIndex_first_name];
    [array insertObject:@"last_name" atIndex:kIndex_last_name];
    [array insertObject:@"username" atIndex:kIndex_username];
    [array insertObject:@"middle_name" atIndex:kIndex_middle_name];
    [array insertObject:@"link" atIndex:kIndex_link];
    
    
    
    if(self.items)
    {
        RELEASE_OBJ(_items);
    }
    self.items = [[NSArray alloc] initWithArray:array];
    
    RELEASE_OBJ(array);
    
    [self updateUI];
    [self hideActivity];
    
    
}

/**
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
 **/

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
    
    
    
    NSString * itemKey = [self.items objectAtIndex: indexPath.row ];
    
    User * user = [AppManager sharedInstance].currentUser;
    
    SEL  keySelector = NSSelectorFromString(itemKey);
    
    TextFieldTableCellView *cell = (TextFieldTableCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure Cell
    if([user respondsToSelector:keySelector]){
        cell.labelTitle.text =itemKey;
        cell.textField.text = [user performSelector:keySelector];;
        cell.textField.delegate = self;
        
    }
    return cell;
    
}



-(NSString*)getTextFromTextFieldAtCellIndex:(int)index
{
    TextFieldTableCellView *cell = (TextFieldTableCellView*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.textField.text;
    
}

-(User*)cloneUserFromUI
{
    User * clone = [AppManager sharedInstance].currentUser;

    clone.first_name = [self getTextFromTextFieldAtCellIndex:kIndex_first_name];
    clone.last_name = [self getTextFromTextFieldAtCellIndex:kIndex_last_name];
    clone.username = [self getTextFromTextFieldAtCellIndex:kIndex_username];
    clone.middle_name = [self getTextFromTextFieldAtCellIndex:kIndex_middle_name];
    clone.link = [self getTextFromTextFieldAtCellIndex:kIndex_link];
    
    return clone;
}


#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}


@end
