////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DCSideNavViewController.m
//
//  Created by Dalton Cherry on 4/18/14.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "DCSideNavViewController.h"
#import "DCNavTabView.h"

@interface DCSideNavViewController ()

@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,strong)UINavigationController *navBar;
@property(nonatomic,strong)NSMutableArray *tabViews;

@end

@implementation DCSideNavViewController

static CGFloat barWidth = 88;
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(instancetype)initWithNav:(UINavigationController *)navBar
{
    if(self = [super init])
    {
        self.navBar = navBar;
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat left = 0;
    CGFloat top = 0;
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(left, top, barWidth, self.view.frame.size.height)];
    self.tabBarView.backgroundColor = [UIColor blackColor];
    self.tabBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tabBarView];
    left += self.tabBarView.frame.size.width;
    [self addChildViewController:self.navBar];
    [self.view addSubview:self.navBar.view];
    self.navBar.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.navBar.view.frame = CGRectMake(left, top, self.view.frame.size.width-(left), self.view.frame.size.height);
    [self layoutTabs:[[UIApplication sharedApplication] statusBarOrientation]];
    if(self.tabViews.count > 0)
    {
        DCNavTabView *tabView = self.tabViews[0];
        [tabView setSelected:YES];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutTabs:toInterfaceOrientation];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutTabs:(UIInterfaceOrientation)orient
{
    for(UIView *view in self.tabViews)
        [view removeFromSuperview];
    if(!self.tabViews)
        self.tabViews = [NSMutableArray new];
    else {
        [self.tabViews removeAllObjects];
    }
    CGFloat pad = 15;
    if(UIInterfaceOrientationIsLandscape(orient) && self.items.count > 8 && self.footerItem) //too many tabs...
        pad = 5;
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat tabHeight = barWidth/2 + 20;
    if(self.headerItem)
    {
        top = 20;
        DCNavTabView *headerView = [self createTabView:self.headerItem];
        headerView.frame = CGRectMake(left, top, barWidth, tabHeight-top);
    }
    top = tabHeight + top;
    for(DCNavTab *tab in self.items)
    {
        DCNavTabView *tabView = [self createTabView:tab];
        tabView.frame = CGRectMake(left, top, barWidth, tabHeight);
        top += tabHeight + pad;
    }
    if(self.footerItem)
    {
        top = self.view.frame.size.height;
        if(UIInterfaceOrientationIsLandscape(orient))
            top = self.view.frame.size.width;
        DCNavTabView *footerView = [self createTabView:self.footerItem];
        footerView.frame = CGRectMake(left, top-tabHeight, barWidth, tabHeight);
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(DCNavTabView*)createTabView:(DCNavTab*)tab
{
    DCNavTabView *view = [DCNavTabView new];
    view.tab = tab;
    [self.tabBarView addSubview:view];
    [self.tabViews addObject:view];
    [view.buttonView addTarget:self action:@selector(didTapTab:) forControlEvents:UIControlEventTouchUpInside];
    if(view.customView)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTab:)];
        [view.customView addGestureRecognizer:tap];
    }
    return view;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)didTapTab:(id)sender
{
    DCNavTabView *tabView = nil;
    if([sender isKindOfClass:[UIGestureRecognizer class]])
    {
        UIView *view = [sender view];
        tabView = (DCNavTabView*)view.superview;
    }
    else
    {
        UIButton *button = sender;
        tabView = (DCNavTabView*)button.superview;
        
    }
    for(DCNavTabView *view in self.tabViews)
        [view setSelected:NO];
    
    [tabView setSelected:YES];
    UIViewController *vc = [[tabView.tab.vcClass alloc] init];
    [self switchTab:vc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)switchTab:(UIViewController*)vc
{
    [self.navBar removeFromParentViewController];
    [self.navBar.view removeFromSuperview];
    UINavigationController *newNavBar = [[UINavigationController alloc] initWithRootViewController:vc];
    self.navBar = newNavBar;
    [self addChildViewController:self.navBar];
    [self.view addSubview:self.navBar.view];
    self.navBar.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CGFloat left = self.tabBarView.frame.size.width;
    CGRect frame = self.view.frame;
    if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
    {
        frame.size.width = self.view.frame.size.height;
        frame.size.height = self.view.frame.size.width;
    }
    self.navBar.view.frame = CGRectMake(left, 0, frame.size.width-(left), frame.size.height);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setHeaderItem:(DCNavTab *)headerItem
{
    _headerItem = headerItem;
    _headerItem.isHeader = YES;
    [self layoutTabs:[[UIApplication sharedApplication] statusBarOrientation]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setFooterItem:(DCNavTab *)footerItem
{
    _footerItem = footerItem;
    _footerItem.isHeader = NO;
    [self layoutTabs:[[UIApplication sharedApplication] statusBarOrientation]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setItems:(NSArray *)items index:(NSInteger)index
{
    _items = items;
    for(DCNavTab *tab in items)
        tab.isHeader = NO;
    [self layoutTabs:[[UIApplication sharedApplication] statusBarOrientation]];
    if(self.tabViews.count > index)
    {
        DCNavTabView *tabView = self.tabViews[index];
        [tabView setSelected:YES];
        UIViewController *vc = [[tabView.tab.vcClass alloc] init];
        [self switchTab:vc];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setItems:(NSArray *)items
{
    [self setItems:items index:0];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - factory methods
////////////////////////////////////////////////////////////////////////////////////////////////////
+(DCSideNavViewController*)navWithController:(UIViewController*)vc
{
    UINavigationController *newNavBar = [[UINavigationController alloc] initWithRootViewController:vc];
    DCSideNavViewController *side = [[DCSideNavViewController alloc] initWithNav:newNavBar];
    return side;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
