////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DCNavTabView.m
//
//  Created by Dalton Cherry on 4/18/14.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "DCNavTabView.h"

@interface DCNavTabView ()

@end

@implementation DCNavTabView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.customView)
    {
        self.customView.frame = self.bounds;
    }
    else if(self.tab.isHeader)
    {
        self.buttonView.frame = self.bounds;
    }
    else
    {
        CGFloat labelSize = 15;
        CGFloat top = 0;
        self.buttonView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-labelSize);
        top += self.buttonView.frame.size.height;
        self.titleLabel.frame = CGRectMake(0, top, self.frame.size.width, labelSize);
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setTab:(DCNavTab *)tab
{
    _tab = tab;
    self.customView = tab.view;
    if(!self.customView)
    {
        if(!self.buttonView)
        {
            self.buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
            //self.imageView.contentMode = UIViewContentModeCenter;
            [self addSubview:self.buttonView];
            
            self.titleLabel = [[UILabel alloc] init];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor whiteColor];
            self.titleLabel.font = [UIFont systemFontOfSize:12];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 1;
            [self addSubview:self.titleLabel];
        }
        [self.buttonView setImage:tab.image forState:UIControlStateNormal];
        if(tab.selectedImage)
        {
            [self.buttonView setImage:tab.selectedImage forState:UIControlStateSelected];
            [self.buttonView setImage:tab.selectedImage forState:UIControlStateHighlighted];
        }
        self.titleLabel.text = tab.title;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setSelected:(BOOL)selected
{
    self.buttonView.selected = selected;
    if(!selected)
        self.titleLabel.textColor = [UIColor whiteColor];
    else if(self.tab.selectedColor)
        self.titleLabel.textColor = self.tab.selectedColor;
    if([self.customView respondsToSelector:@selector(setSelected:)])
    {
        DCNavTabView *view = (DCNavTabView*)self.customView; 
        [view setSelected:selected];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
