    //
    //  WebViewController.m
    //  Missal
    //
    //  Created by Kigen on 8/20/15.
    //  Copyright (c) 2015 Strathmore University. All rights reserved.
    //

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation WebViewController
#pragma mark - Getters & Setters
-(NSString *)file_resource{
    if(!_file_resource)_file_resource= @"Index";
    
    return _file_resource;
}
#pragma mark - Custom code

- (void)injectJavascript:(NSString *)resource {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

-(void)setup{
  
    
    self.webView.delegate = self;
    
    self.webView.userInteractionEnabled =YES;
    
    
    [self injectJavascript:@"script"];
    
    self.webView.scalesPageToFit =YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.file_resource ofType:@"htm"];
    
        //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_bar_logo.png"]];
    
        //self.navigationController.title = @"Daily Missal";
    
    self.title = @"Daily Missal";
    
    
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebView:) name:@"refresh_page" object:nil];
   
}

- (IBAction)calendarClick:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Calendar" withExtension:@"htm"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)reloadWebView:(NSNotification *)data{
    self.file_resource = [[data userInfo] objectForKey:@"file_resource"];
    
    NSString *html_div = [[data userInfo] objectForKey:@"html_div"];
    
    NSString *view_title = [[data userInfo] objectForKey:@"view_title"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.file_resource ofType:@"htm"];
    
    NSURL *url = nil;
    
    if(html_div.length){
        NSURL *temp_url = [NSURL fileURLWithPath:path];
        
        NSString *absolute_string = [temp_url absoluteString];
        
        NSString *absoluteURLwithQueryString = [absolute_string stringByAppendingString:html_div];
        url = [NSURL URLWithString:absoluteURLwithQueryString];
        
        
    }else{
        url= [NSURL fileURLWithPath:path];
    }
    
    self.title = view_title;
    
        //NSLog(@"URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - SlideNavigationControllerDelegate

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication]
     setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication]
     setNetworkActivityIndicatorVisible:NO];
    //[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ", (int)webView.frame.size.width]];
    [self.webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     "var meta = document.createElement('meta');"
     "meta.name = 'viewport';"
     "meta.content = 'width=device-width, initial-scale=1.0, user-scalable=yes';"
     "var head = document.getElementsByTagName('head')[0];"
     "head.appendChild(meta);"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:
(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
        //NSLog(@"Nav type: %ld", (long)navigationType);
    return YES;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}



@end
