//
//  main.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/6/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } else {
            // Fallback on earlier versions
        }
    }
}
