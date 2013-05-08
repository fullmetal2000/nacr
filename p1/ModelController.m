//
//  ModelController.m
//  p1
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import "ModelController.h"

#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController
@synthesize pageContent;
- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
   //     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    _pageData = [[dateFormatter monthSymbols] copy];
         [self createContentPages];
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (void) createContentPages
{
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    
    //hard code 10 tech pages:
    NSMutableArray * pageArray = [NSMutableArray arrayWithObjects: @"<html><head></head><body><h1>This is Main Page</h1><h2>Will show top stories of each catogory<h2></body></html>", nil];
       
    

    
    NSString * page1=@"<html><head></head><body><table><tr><td><div onclick=\"location.href='http://www.ic.gc.ca/eic/site/icgc.nsf/eng/h_07056.html';\" style=\"cursor:pointer;\"><p><img border=\"0\" src=\"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRNPffb0ooDemII-3h3GgFiq4LgGkrFPom5N5nhcUzLflp0YyJp\"  width=\"150\" height=\"120\"></a></p><p>Our place in the world  \
    Have a look at international comparisons for Canadas performance in science, technology, research and development. Our S&T data publication provides annual snapshots of the state of S&T in Canada.</p></div><br></td><td><div onclick=\"location.href='http://www.ic.gc.ca/eic/site/icgc.nsf/eng/h_07056.html';\" style=\"cursor:pointer;\"><p><img border=\"0\" src=\"http://www.mcgill.ca/science/sites/mcgill.ca.science/files/images/urc2011.jpg\"  width=\"150\" height=\"120\"></a></p><p>The Faculty of Science's 8th annual Undergraduate Research Conference is coming up! On October 4th join us for poster presentations and a keynote speech from the president of NSERC, Dr. Suzanne Fortier. .</p></div></br></td></tr><tr><td><div onclick=\"location.href='http://www.ic.gc.ca/eic/site/icgc.nsf/eng/h_07056.html';\" style=\"cursor:pointer;\"><p><img border=\"0\" src=\"http://www.sciencetech.technomuses.ca/english/whatson/images/2009-rocket-science.jpg\"  width=\"210\" height=\"180\"></a></p><p>The Great Canadian Balloon Rocket Challenge\
    10 a.m. to 11:30 a.m. and 2 p.m. to 4 p.m.\
    Launch into action! Discover how air can make a rocket fly. Make your own balloon rocket racer, and then test it out.\
    Story Corner\
    11:45 a.m. and 1:15 p.m.\
    Journey to the land of imagination. Cozy up and let our teller enchant you with a story that will whisk you off your feet..</p></div></br></td><td><div onclick=\"location.href='http://www.ic.gc.ca/eic/site/icgc.nsf/eng/h_07056.html';\" style=\"cursor:pointer;\"><p><img border=\"0\" src=\"http://www.autokinematics.com/resource/science-and-technology.jpg\"  width=\"90\" height=\"80\"></a></p><p>There was a time when science was the pre-occupation of lone scientists trying to unravel the mysteries of nature. Their purpose possibly had been to derive ethereal sense of pleasure by contributing in some messure towards the intellectual growth of mankind. Recent pass has brought about revolutionary change in the scientific outlook of the people, specially after realising that nature is a great source of power, and it is Science alone that can assist in placing that Power in the hands of man for promoting the human progress, prosperity and well being.</p></div></br></td></tr><table></body></html>";
   

    
    NSString * page2 = @"<html><head></head><body><h1>Tech</h1><img border=\"0\" src=\"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR5k0OQ0qHoUsE1Ag0891HqiwuzrnsUBK-Eg8hIcpj8z1-SebH8oWwOCg\"  width=\"300\" height=\"280\"><p>b has discovered a new aterial for light transfering3....</p></body></html>";
   
    NSString *page3 = @"<html><head></head><body></br></br><h1>Tech</h1><img border=\"0\" src=\"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTEbsRNr46_xgP3t2VOmAoQ4mIWrx8HlyXmMhF-x0VpiUUc7mJj\"  width=\"300\" height=\"280\"><p>c has discovered a new aterial for light transfering1....</p></body></html>";
        [pageArray addObject:page1];
        [pageArray addObject:page2];
        [pageArray addObject:page3];
   
    
    
    //hard code 10 pet pages:
    
    for (NSString * p in pageArray)
    {
        [pageStrings addObject:p];
    }
    _pageData = [[NSArray alloc] initWithArray:pageStrings];
}



@end
