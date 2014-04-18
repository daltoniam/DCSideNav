DCSideNav
=========

Custom Navigation for iPad. Similar to iPad twitter app navigation.

### Example Usage

![alt tag](https://raw.github.com/daltoniam/DCSideNav/master/screenshots/demo.png)

### Example Code

```objc
    UIColor *color = [UIColor grayColor];
    DCSideNavViewController *sideBar = [DCSideNavViewController navWithController:[[ActivityViewController alloc] init]];
    sideBar.headerItem = [DCNavTab tabWithTitle:@"" image:[UIImage imageNamed:@"user"] selectedImage:nil selectedColor:color viewController:[UserViewController class]];

    sideBar.items = @[[DCNavTab tabWithTitle:@"Activity" image:[UIImage imageNamed:@"activity"] selectedImage:nil selectedColor:color viewController:[LibViewController class]],
                      [DCNavTab tabWithTitle:@"Notifications" image:[UIImage imageNamed:@"notify"] selectedImage:nil selectedColor:color viewController:[NotifyViewController class]],
                      [DCNavTab tabWithTitle:@"Groups" image:[UIImage imageNamed:@"groups"] selectedImage:nil selectedColor:color viewController:[GroupsViewController class]],
                      [DCNavTab tabWithTitle:@"Messsages" image:[UIImage imageNamed:@"messages"] selectedImage:nil selectedColor:color viewController:[MessagesViewController class]]];

    sideBar.footerItem = [DCNavTab tabWithTitle:@"Settings" image:[UIImage imageNamed:@"settings"] selectedImage:nil selectedColor:color viewController:[SettingsViewController class]];
    self.window.rootViewController = sideBar;
```

## Install ##

The recommended approach for installing DCSideNav is via the CocoaPods package manager, as it provides flexible dependency management and dead simple installation.

via CocoaPods

Install CocoaPods if not already available:

	$ [sudo] gem install cocoapods
	$ pod setup
Change to the directory of your Xcode project, and Create and Edit your Podfile and add DCSideNav:

	$ cd /path/to/MyProject
	$ touch Podfile
	$ edit Podfile
	platform :ios, '7.0'
	pod 'DCSideNav'

Install into your project:

	$ pod install

Open your project in Xcode from the .xcworkspace file (not the usual project file)

## Requirements ##

DCSideNav requires at least iOS 7 or above.


## License ##

DCSideNav is license under the Apache License.

## Contact ##

### Dalton Cherry ###
* https://github.com/daltoniam
* http://twitter.com/daltoniam
