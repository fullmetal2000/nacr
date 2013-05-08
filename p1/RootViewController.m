//
//  RootViewController.m
//  p1
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import "RootViewController.h"

#import "ModelController.h"

#import "DataViewController.h"

@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController,pageCount,pageNum;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    
    // 1 curl effect:
//    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    // 2 scroll effect:
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    self.pageViewController.delegate = self;

//    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
//    NSArray *viewControllers = @[startingViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
//
//    self.pageViewController.dataSource = self.modelController;
    
    [self goStartPage];

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
  //  [self.view addSubview:menuView];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
   CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    
    self.pageViewController.view.frame = pageViewRect;
//    //if you want to whole page, use below:
    //self.pageViewController.view.frame = [[self view] bounds];

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
   // menuView.hidden=YES;
    NSString * string1;
    string2=string1;
    //subscribe to the notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificatRecieved:)
                                                 name:@"testNotification" object:string1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detailNewsNotificatRecieved:)
                                                 name:@"detailNewsNotification" object:string1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backToMainDataNotificatRecieved:)
                                                 name:@"backToMainNotification" object:string1];
    
}

-(void)detailNewsNotificatRecieved:(NSNotification*)notification{

//    NSString *string1 = [notification object];
//    NSLog(@"this is root,detail news is %@",string1);
//    
    
    //create content page.
    [self goStartPage];
}
-(void)backToMainDataNotificatRecieved:(NSNotification*)notification{
    
    NSString *string1 = [notification object];
    NSLog(@"this is root,detail news is %@",string1);
    int idx=[string1 intValue];
    [self goCurrentPage:idx];
    //create content page.
    
}
-(void)notificatRecieved:(NSNotification*)notification{
    NSLog(@"Notificaiton was recieved from view 2");
    NSString *string1 = [notification object];
    NSLog(@"this is root,mystrig is %@",string1);
    //create content page.
    [self go2ndPage];
 
}


-(void)goStartPage
{
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;

}
-(void)goCurrentPage:(int) idx
{
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:idx storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    
}
-(void)go2ndPage
{
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:1 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    pageNum.text=[NSString stringWithFormat:@"%d",1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    int idx=[_modelController indexOfViewController:pendingViewControllers[0]];
    NSLog(@"currentpage is=%@",[NSString stringWithFormat:@"%d",idx]);
    pageNum.text=[NSString stringWithFormat:@"%d",idx];
    currentpage = idx;
    pageCount=[NSString stringWithFormat:@"%d",[pendingViewControllers count]];
    
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{


//    int idx=[_modelController indexOfViewController:previousViewControllers[0]];
//    NSLog(@"%@",[NSString stringWithFormat:@"%d",idx]);
//    pageNum.text=[NSString stringWithFormat:@"%d",idx];
//    pageCount=[NSString stringWithFormat:@"%d",[previousViewControllers count]];
    
    // below code not work
//    int idx=[_modelController presentationIndexForPageViewController:self.pageViewController];
//    int ct = [_modelController presentationCountForPageViewController:self.pageViewController];
//    
//    printf("%d    %d", idx,ct);
//    

}
 

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }

    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];


    return UIPageViewControllerSpineLocationMid;
}

- (IBAction)handle_home_btn:(id)sender {
    
    [self goStartPage];
     pageNum.text=[NSString stringWithFormat:@"%d",0];
}

- (IBAction)handle_setting_btn:(id)sender {
  
    if ([sender isSelected]) {
        
        menuView.hidden=NO;
        
        
        [sender setSelected:NO];
    }
        else {
            menuView.hidden=YES;

            [sender setSelected:YES];
            
        }
    
}
@end
