////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DCNavTabView.h
//
//  Created by Dalton Cherry on 4/18/14.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import "DCNavTab.h"

@interface DCNavTabView : UIView

@property(nonatomic,weak)DCNavTab *tab;
@property(nonatomic,strong)UIButton *buttonView;
@property(nonatomic,weak)UIView *customView; //our items array has a strong reference
@property(nonatomic,strong)UILabel *titleLabel;

-(void)setSelected:(BOOL)selected;

@end
