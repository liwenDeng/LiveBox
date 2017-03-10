//
//  MSBaseViewController.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSHTTPRequestProtocol <NSObject>

@optional
- (void)refresh;
- (void)loadMore;

@end

@protocol MSSearchButtonProtocol <NSObject>

@optional
- (void)searchButtonClicked;

@end

@interface MSBaseViewController : UIViewController <MSHTTPRequestProtocol>

@end
