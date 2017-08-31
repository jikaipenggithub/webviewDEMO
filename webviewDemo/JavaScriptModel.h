//
//  JavaScriptModel.h
//  webviewDemo
//
//  Created by jikaipeng on 2017/8/31.
//  Copyright © 2017年 kuxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

// js调用原声，需要写协议方法，而且，JSExport
@protocol jSObjectdelegate <JSExport>

- (void)callme:(NSString *)string;

- (void)share:(NSString *)shareUrl;

@end

@interface JavaScriptModel : NSObject


@end
