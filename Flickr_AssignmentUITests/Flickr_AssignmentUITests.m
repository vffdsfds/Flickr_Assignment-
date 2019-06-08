//
//  Flickr_AssignmentUITests.m
//  Flickr_AssignmentUITests
//
//  Created by Xin Chen on 6/6/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Header.h"

@interface Flickr_AssignmentUITests : XCTestCase
@property (weak, nonatomic)  XCUIElement *collectionView;
@property (weak, nonatomic)  XCUIElementQuery *cells;

@end

@implementation Flickr_AssignmentUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
-(void)testSlide{
    
    XCUIApplication *application = [[XCUIApplication alloc] init];

    // 找到当前界面上所有的collectionView
    XCUIElementQuery *collectionViewsQuery = application.collectionViews;
    NSInteger queryCount = collectionViewsQuery.count;
    //给出一个frame，用来匹配想要操作的collectionView
    CGRect colletionFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    for (int i = 0; i < queryCount; i++) {
        XCUIElement *collection = collectionViewsQuery.allElementsBoundByIndex[i];
        CGRect tempFrame = collection.frame;
        if (CGRectContainsRect(colletionFrame, tempFrame) &&[self canOperateElement:collection]) {
           self.collectionView = collection;
            
        }
    }
    [self.collectionView swipeUp];
    [self.collectionView swipeDown];

}

-(void)testCellClick{
    //当前找到的collectionView中的cell
  self.cells = [self.collectionView descendantsMatchingType:XCUIElementTypeCell];
    NSInteger cellCount = self.cells.count;
    if (cellCount > 0) {
        XCUIElement *lastCell = self.cells.allElementsBoundByIndex[cellCount -1];
        //滑动到最后
        if ([self canOperateElement:self.collectionView]) {
            XCUIElement *lastCell = self.cells.allElementsBoundByIndex[cellCount -1];
            if ([self canOperateElement:lastCell]) {
                //进行点击操
                [lastCell tap];
                
            }
            
        }
    }
    
}

- (BOOL)canOperateElement:(XCUIElement *)element {
    if (element != nil) {
        if (element.exists) {
            return YES;
        }
    }
    return NO;
}
@end
