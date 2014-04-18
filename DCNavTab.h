////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DCNavTab.h
//
//  Created by Dalton Cherry on 4/18/14.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface DCNavTab : NSObject

/**
 This is the title text shown under the image.
 */
@property(nonatomic,copy)NSString *title;

/**
 This is the image shown for the button.
 */
@property(nonatomic,strong)UIImage *image;

/**
 This is the image shown when the button is selected.
 */
@property(nonatomic,strong)UIImage *selectedImage;

/**
 This is the color the button is tinted when selected.
 */
@property(nonatomic,strong)UIColor *selectedColor;

/**
 This is the view to show. If set, it will be used instead of the image.
 */
@property(nonatomic,strong)UIView *view;

/**
 This is the view controller to open when selected.
 */
@property(nonatomic,strong)Class vcClass;

/**
 Set if it is the header item or not.
 The header item is short than the average tab, and can't include a title.
 It is uneeded to set this value, the headerItem assignment will do this.
 */
@property(nonatomic,assign)BOOL isHeader;

/**
 Create a new tab.
 @param title is the title string of the tab.
 @param image is the image of the tab.
 @param selectedImage is the selected image of the tab.
  @param selectedColor is the selected text color of the tab.
 @param vcClass is the view controller class to create when the tab is selected
 @return A new DCNavTab.
 */
+(DCNavTab*)tabWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage
           selectedColor:(UIColor*)selectedColor viewController:(Class)vcClass;

/**
 Create a new tab.
 @param view is a custom view for the tab.
 @param vcClass is the view controller class to create when the tab is selected
 @return A new DCNavTab.
 */
+(DCNavTab*)tabWithView:(UIView*)view viewController:(Class)vcClass;

@end
