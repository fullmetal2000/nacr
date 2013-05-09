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
        [self createAllPages:@""];
    //    [self createMainPage];
        
        
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
    return self;
}

-(void)detailNewsNotificatRecieved:(NSNotification*)notification{
    
    NSString *string1 = [notification object];
    NSLog(@"this is modelcontroller.m,detail news is %@",string1);
    

    
   [self createDetailNewsPages:string1];
    //create content page.
    
}
-(void)backToMainDataNotificatRecieved:(NSNotification*)notification{
    
    NSString *string1 = [notification object];
    NSLog(@"this is modelcontroller.m,detail news is %@",string1);
    NSLog(@"back to main ,modelcontroller is %@",string1);
    [self loadBackToMainData];
    
       //create content page.
    
}


-(void)notificatRecieved:(NSNotification*)notification{
    NSLog(@"Notificaiton was recieved from view 2");
    NSString *string1 = [notification object];
    NSLog(@"mystrig is %@",string1);
    //create content page.
    [self createAllPages:string1];
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

- (void) createDetailNewsPages:(NSString*)article {
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    NSMutableArray * pageArray = [[NSMutableArray alloc] init];
    NSString *mainPage =[NSString stringWithFormat:@"<!doctype html><html><head><meta charset=\"utf-8\" />" ];
    
    NSString *contPages =[NSString stringWithFormat:@"<!doctype html><html><head><meta charset=\"utf-8\" />" ];
    //read js file:
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NativeBridge" ofType:@"js"];
    NSData *jsData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"detailnews" ofType:@"js"];
    NSData *jsData2 = [NSData dataWithContentsOfFile:filePath2];
    
    NSString *strJsData,*strJsData2;
    if (jsData) {
        
        strJsData = [[NSString alloc]initWithData:jsData encoding:NSUTF8StringEncoding];
        // NSLog(@"js=%@",strJsData);
        // do something useful
    }
    if (jsData2) {
        
        strJsData2 = [[NSString alloc]initWithData:jsData2 encoding:NSUTF8StringEncoding];
        // NSLog(@"js=%@",strJsData);
        // do something useful
    }
    
    strJsData = [strJsData stringByAppendingString:strJsData2];
    
    NSString * content;
        
    NSArray *listItems = [article componentsSeparatedByString:@"#30714_2012c#"];
    NSString * idx=listItems[0] ;
    NSString *img=listItems[1];
    NSString *title=listItems[2];
    NSString * author = listItems[3];
    NSString * time = listItems[4];
    NSString * detail =listItems[5];
//    NSLog(@"detail=%@",detail);
    
    int art_len=[detail length];
    
    if (art_len>400){ // will need more pages:
    
        NSRange range = NSMakeRange (0,400);
    
        content = [detail substringWithRange:range];
        // ad in 
        
    }
    else{
        
        content = detail;
    }
    
    mainPage =[ mainPage stringByAppendingString:  [NSMutableString stringWithFormat:
                                                    @"<style></style></head><body><div onclick=\"goback('%@')\" >Back</div><h3>%@</h3><div class=\"authortime\"><span class=\"author\">%@</span><span>"   "</span><span class=\"time\">%@</span></div><div class=\"content\">%@</div><div class=\"img\"><img src=\"%@\"></img></div><script>%@</script></body></html>",idx,title,author,time,content,img,strJsData] ];
    NSLog(@"idx=%@",idx);

    [pageStrings addObject:mainPage];
    
    
    if (art_len>400) {
         
        content = [detail substringFromIndex:400];//remaining article content
        NSLog(@"newcontentlen=%d",[content length]);
        NSRange range = NSMakeRange (0,800);
       
        NSString * newpage=@"";
        NSString * current_content=@"";
        int remain_len = art_len - 400;//remaining length of the article words;
  
        while (remain_len>0){
            
            if (remain_len>800){
               
               // if remaining article len is > 800, than need even more pages
               current_content = [content substringWithRange:range];
                NSLog(@"remainlen1=%d",remain_len);
               content = [content substringFromIndex:800];
               
            }
            else{
                NSLog(@"remainlen2=%d",remain_len);
                current_content  = content;
            }
        
            newpage =[ contPages stringByAppendingString:  [NSMutableString stringWithFormat:
                                                            @"<style></style></head><body><div onclick=\"goback('%@')\" >Back</div><div class=\"content\">%@</div>><script>%@</script></body></html>", idx,current_content ,strJsData] ];
            [pageStrings addObject:newpage];
            remain_len-=800;
        }
    

 
    }
    
    for (NSString * p in pageArray)
    {
        //  NSLog(@"data=%@",p);
        [pageStrings addObject:p];
    }
    _pageData = [[NSArray alloc]  initWithArray:pageStrings];
    pageContent=_pageData;
}

-(void) loadBackToMainData{
    NSLog(@"loadBackToMainData called");
    NSLog(@"mainData[1]=%@",mainData[1]);
    _pageData = [[NSArray alloc]  initWithArray:mainPageStrings];
    
    pageContent=_pageData;
}

- (void) createAllPages:(NSString*)sitename
{
    
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    NSMutableArray * pageArray = [[NSMutableArray alloc] init];
    //hard code 10 tech pages:
    //  NSMutableArray * pageArray = [NSMutableArray arrayWithObjects: @"<html><head></head><body><h1>This is Main Page</h1><h2>Will show top stories of each catogory<h2></body></html>", nil];
    
    NSString *data= @"{cat:";
    [data stringByAppendingString:@"abc"];
    [data stringByAppendingString:@"}"];
    
    
    //read js file:
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NativeBridge" ofType:@"js"];
    NSData *jsData = [NSData dataWithContentsOfFile:filePath];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSData *jsData2 = [NSData dataWithContentsOfFile:filePath2];
    
    NSString *strJsData,*strJsData2;
    if (jsData) {
        
        strJsData = [[NSString alloc]initWithData:jsData encoding:NSUTF8StringEncoding];
        // NSLog(@"js=%@",strJsData);
        // do something useful
    }
    if (jsData2) {
        
        strJsData2 = [[NSString alloc]initWithData:jsData2 encoding:NSUTF8StringEncoding];
        // NSLog(@"js=%@",strJsData);
        // do something useful
    }
    
    //this string 'strJsData' copied all the content of the 2 JS file, main.js and the libarary: NativeBridge.js.
    strJsData = [strJsData stringByAppendingString:strJsData2];
   
   //below is to get the code from style1Jquery.js, this JS file is used to 
    NSString *filePathJquery =[[NSBundle mainBundle] pathForResource:@"style1Jquery" ofType:@"js"];
    NSData *JqueryData = [NSData dataWithContentsOfFile:filePathJquery];

    NSString *strJqueryData;
    if (JqueryData) {
        
        
        strJqueryData = [[NSString alloc]initWithData:JqueryData encoding:NSUTF8StringEncoding];
        // NSLog(@"js=%@",strJsData);
        // do something useful
    }
    
    
    //start to build the main page's html.
    NSString *mainPage =[NSString stringWithFormat:@"<!doctype html><html><head><meta charset=\"utf-8\" />" ];
    //load css code:
    filePath = [[NSBundle mainBundle] pathForResource:@"mainpage" ofType:@"css" ];
    NSString *cssCode = [NSString stringWithContentsOfFile:filePath];
    // mainPage =[ mainPage stringByAppendingString:cssCode];
    
    //
    mainPage =[ mainPage stringByAppendingString:  [NSMutableString stringWithFormat:
                                                    @"<style>%@</style></head><body><div class=\"div1\" onclick=\"myFunction('wenxuecity')\">文学城</div><div class=\"div2\" onclick=\"myFunction('creaders')\">万维读者</div><div class=\"div3\" onclick=\"myFunction('6park')\">文坛揽胜</div><div class=\"div4\" onclick=\"myFunction('6park')\">谈股论今</div><div class=\"div5\" onclick=\"myFunction('6park')\">史海乘钩</div><div class=\"div6\" onclick=\"myFunction('6park')\">外交风云</div><div class=\"div7\">找deal</div><div class=\"div8\"onclick=\"myFunction('6park')\">体育新闻</div><script>%@</script></body></html>",cssCode,strJsData] ];
    
        // NSLog(@"data=%@",p);
    //insert page html to pageStrings (pageStrings is a array to store pages )
    [pageStrings addObject:mainPage];
   
    // now start to load real news info from json

    //1 get rec list from jason
    NSString * url=[NSString stringWithFormat:@"http://cnewsfinder.appspot.com/?sitename=%@",sitename]; //e.g. wenxuecity";
    GetDataFromServer * getData=[[GetDataFromServer alloc] init];
    NSArray * jasonDataArray=[getData getJasonData:url forkey:@"website"];
    /*
     Now the jasonDataArray contains the real url of images, it's better to save it locally, use local storage?? 
     */
    
    //do some thing to convert images urls here:
//    
//     ConvertImageToLocalUrl * convertImage = [[ConvertImageToLocalUrl alloc] init];
//    
//   // [testlist addObject:@"http://space.wenxuecity.com/media/news/201301/2176274.jpg"];
//    NSArray *temp = [[NSArray alloc] initWithObjects:@"http://space.wenxuecity.com/media/news/201301/2176274.jpg", nil];
//    
//    NSArray * localImageList = [convertImage saveImageToLocal:temp];
//    
//    for (NSString * u in localImageList) {
//        NSLog(@"uuu=%@",u);
//    }
//    
//    
//     NSLog(@"8");
    // dataArray = convertImage startConvert:jasonDataArray
    //check how many news records.
    NSUInteger count = [jasonDataArray count];
    
    NSLog(@"count = %d",count);
    NSString *tmppage = [[NSString alloc] init];
    int len=0;
    
    //body head,include css head
    tmppage=@"";
     NSCharacterSet *myCharacterSet1  = [NSCharacterSet characterSetWithCharactersInString:@"<p>"];
     NSCharacterSet *myCharacterSet2  = [NSCharacterSet characterSetWithCharactersInString:@"</p>"];
    
    
    
    for (NSUInteger i=1;i<count;i++){
        
        NSDictionary* newsRec=[jasonDataArray objectAtIndex:i];
        if (i%5==0) {
            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div1\" onclick=\"loadDetail('%@','%@','%@','%@','%@','%@')\")><h3>%@</h3><span id=\"timeauthor\">%@ %@</span><img id=img1 src=%@ ></img> <div id=p1>%@ </div></div>", [NSString stringWithFormat:@"%d", i/5],[newsRec objectForKey:@"img"], [newsRec objectForKey:@"title"], [newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[[newsRec objectForKey:@"article"] stringByReplacingOccurrencesOfString:@"\n"                                                                                                                                                                                                                                                                                     withString:@" "],[newsRec objectForKey:@"title"] ,[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"paragraph"] ]];
          
             NSLog(@"img1=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
            NSLog(@"title1=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"]]);
             NSLog(@"p1=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]]);
        }
//
//        if (i%5==0) {
//            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div1\" ><h3>%@</h3><span id=\"timeauthor\">%@ %@</span><img id=img1 src=%@ ></img> <div id=p1>%@ </div></div>", [newsRec objectForKey:@"title"] ,[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"paragraph"] ]];
//            
//            NSLog(@"img1=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
//            NSLog(@"title1=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"]]);
//            NSLog(@"p1=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]]);
//        }
       
        if (i%5==1) {
            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div2\" onclick=\"loadDetail('%@','%@','%@','%@','%@','%@')\")><h3>%@</h3><span id=\"timeauthor\">%@ %@</span> <div class=\"viewport\"><img id=img2 class=\"clipped\" src=%@ alt=\"ddfsf\"></img></div> <div id=p2>%@ </div></div>", [NSString stringWithFormat:@"%d", i/5+1],[newsRec objectForKey:@"img"], [newsRec objectForKey:@"title"] , [newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"title"] ,[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"article"],[newsRec objectForKey:@"paragraph"]]];
           NSLog(@"img2=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
            NSLog(@"title2=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"] ]);
            NSLog(@"p2=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]                                                                                                                                                                                                                                                                               ]);
        }
        
//        if (i%5==1) {
//            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div2\" ><h3>%@</h3><span id=\"timeauthor\">%@ %@</span> <div class=\"viewport\"><img id=img2 class=\"clipped\" src=%@ alt=\"ddfsf\"></img></div> <div id=p2>%@ </div></div>", [newsRec objectForKey:@"title"] ,[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],/*[newsRec objectForKey:@"article"],*/[newsRec objectForKey:@"paragraph"]]];
//            NSLog(@"img2=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
//            NSLog(@"title2=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"] ]);
//            NSLog(@"p2=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]                                                                                                                                                                                                                                                                               ]);
//        }
//        
        if (i%5==2) {
            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div3\" onclick=\"loadDetail('%@','%@','%@','%@','%@','%@')\")><h3>%@</h3><span id=\"timeauthor\">%@ %@</span><img id=img3 src=%@ ></img> <div id=p3>%@ </div></div>", [NSString stringWithFormat:@"%d", i/5+1],[newsRec objectForKey:@"img"], [newsRec objectForKey:@"author"], [newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[[newsRec objectForKey:@"article"] stringByReplacingOccurrencesOfString:@"\n"                                                                                                                                                                                                                                                                                     withString:@"#n"],[newsRec objectForKey:@"title"],[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"paragraph"]]];
            NSLog(@"img3=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
            NSLog(@"title3=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"]]);
            NSLog(@"p3=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]]);
        }
        
        if (i%5==3) {
            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div4\" onclick=\"loadDetail('%@','%@','%@','%@','%@','%@')\")><h3>%@</h3><span id=\"timeauthor\">%@ %@</span><img id=\"img4\" class=\"clipped\" src=%@ ></img> <div id=p4>%@</div> </div>", [NSString stringWithFormat:@"%d", i/5+1],[newsRec objectForKey:@"img"], [newsRec objectForKey:@"title"], [newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[[newsRec objectForKey:@"article"] stringByReplacingOccurrencesOfString:@"\n"                                                                                                                                                                                                                                                                                     withString:@"#n"],[newsRec objectForKey:@"title"] ,[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"paragraph"]]];
            NSLog(@"img4=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
            NSLog(@"title4=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"]]);
            NSLog(@"p4=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]]);
        }
        if (i%5==4) {
            tmppage = [ tmppage stringByAppendingString:[NSMutableString stringWithFormat: @"<div class=\"div5\" onclick=\"loadDetail('%@','%@','%@','%@','%@','%@')\")><h3>%@</h3><span id=\"timeauthor\">%@ %@</span><img id=img5 src=%@ ></img> <div id=p4>%@ </div></div>", [NSString stringWithFormat:@"%d", i/5+1],[newsRec objectForKey:@"img"], [newsRec objectForKey:@"title"], [newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[[newsRec objectForKey:@"article"] stringByReplacingOccurrencesOfString:@"\n"                                                                                                                                                                                                                                                                                     withString:@"#n"],[newsRec objectForKey:@"title"],[newsRec objectForKey:@"author"],[newsRec objectForKey:@"time"],[newsRec objectForKey:@"img"],[newsRec objectForKey:@"paragraph"]]];
            NSLog(@"img5=%@",[NSString stringWithFormat:@"%@", [newsRec objectForKey:@"img"]]);
            NSLog(@"title5=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"title"]]);
            NSLog(@"p5=%@",[NSString stringWithFormat:@"%@",[newsRec objectForKey:@"article"]]);
        }
        if ((0==i%5) && (0!=i)){
            
            //  NSLog(@"len1=%d",len);
            NSString *tempStr = [[NSString alloc] init];
            tempStr = tmppage;
            
            //add in head and tail before insert in object
            //read css file test use, different css for each page, round robin style1 to 5.
            NSString *cssCode=@"";
            if ((i/5)%5==0){
                //this is page1,
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recstyle1" ofType:@"css" ];
                cssCode = [NSString stringWithContentsOfFile:filePath];
            }
            
            if ((i/5)%5==1){
                
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recstyle2" ofType:@"css" ];
                cssCode = [NSString stringWithContentsOfFile:filePath];
            }
            if ((i/5)%5==2){
            
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recstyle3" ofType:@"css" ];
                cssCode = [NSString stringWithContentsOfFile:filePath];
            }
            
            if ((i/5)%5==3){
                
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recstyle4" ofType:@"css" ];
                cssCode = [NSString stringWithContentsOfFile:filePath];
            }
            if ((i/5)%5==4){
                
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recstyle5" ofType:@"css" ];
                cssCode = [NSString stringWithContentsOfFile:filePath];
            }
            //cssCode=@"";
            
            NSString   * pagehead=[ NSString stringWithFormat:@"<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\" /><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"><style>%@</style><div class=\"header\"><p>科技_____________________________________________________________________________________________________________</p><div><script src=\"http://code.jquery.com/jquery-latest.js\"></script><script>%@</script></head><body class=\"demos \">  <session><div id=\"body\" class=\"clearfix\">",cssCode,strJqueryData];
            
            tempStr=[pagehead stringByAppendingString:tempStr];
            
            
//            NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"style1" ofType:@"js"];
//            NSData *jsData3 = [NSData dataWithContentsOfFile:filePath3];
//            
//            NSString *strJsData3;
//            if (jsData3) {
//                
//                strJsData3 = [[NSString alloc]initWithData:jsData3 encoding:NSUTF8StringEncoding];
//                // NSLog(@"js=%@",strJsData);
//                // do something useful
//            }
//    
//            strJsData = [strJsData stringByAppendingString:strJsData3];
            
            tempStr=[tempStr stringByAppendingString:[NSMutableString stringWithFormat:@"</session> <script>%@</script></body></html>",strJsData]];
            
            [pageArray addObject:tempStr];
            tmppage=@"";
            //    NSLog(@"len2=%d",len);
            len+= [tempStr length];
            //   NSLog(@"html=%@",tempStr);
            
        }
        
    }
    
    
    for (NSString * p in pageArray)
    {
        //  NSLog(@"data=%@",p);
        [pageStrings addObject:p];
    }
    
   
    mainPageStrings = [[NSArray alloc] initWithArray:pageStrings];
    _pageData = [[NSArray alloc]  initWithArray:mainPageStrings];   
  
    pageContent=_pageData;
    
    //    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    //
    //    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"webviewtest1" ofType:@"html"];
    //    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"webviewtest2" ofType:@"html"];
    //    [testArray addObject:path1];
    //    [testArray addObject:path2];
    
    // _pageData = [[NSArray alloc]  initWithArray:testArray];
    
}

@end
