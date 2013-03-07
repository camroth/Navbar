Navbar
============

An unoffical app for [Sidebar.io](http://sidebar.io).

Q: That's nice, but what is Sidebar.io? 

A: Sidebar gives you the 5 best links curated by a selection of great editors, every day!

Q: Why did you call it Navbar?

A: I asked [Sacha Greif](http://), the creator of Sidebar, if it would be okay to create an app and he kindly said yes as long as I don't use the name Sidebar, and suggested I use Footer :) So I used Navbar instead.

Logo
============

I am not a designer, if you would like to contribute a logo be my guest!

![Launch Screen](https://raw.github.com/superlogical/Navbar/master/PSD/screen-3.png)


Tech stuff
=============

I am using the [Parse.com][6] IOS SDK. I am storing the data in Parse rather than querying Sidebar directly so that the app is more robust and can handle changes to the API, downtime and unavailability. 

I am importing data from Sidebar into Parse using a [node.js script][0]. The script is scheduled and runs in the cloud using [IronWorker][5]. The script uses [Kaiseki][1], which is a Parse REST API client for Node.js.

In the case of an API change I can just update my node.js script and upload it to [IronWorker][5] and be back up in running without users ever seeing an error. More importantly it means I don't have to patch the app and wait for Apple to approve the release to the App Store!

Parse makes it easy to cache data locally on the phone. You can see an [example of this in the app here][3]. The app uses the cache while waiting for results to refresh from the network. This allows the screens to load instantly when you page between days. The app also detect's when it is online/offline, and will not issue network requests while offline. To detect changes to internet availability I am using [Reachability][4].

I wish more app's would open links in Chrome if it is installed. The easiest way to have your iOS app open links in Chrome is to use the [OpenInChromeController][7] class by GoogleChrome.

	if ([openInController_ isChromeInstalled]) {
	  [openInController_ openInChrome:urlToOpen
		                withCallbackURL:callbackURL
		                   createNewTab:createNewTab];
	}



Screenshots
=============

![Launch Screen](https://raw.github.com/superlogical/Navbar/master/PSD/screen-1.png)
![Main Screen](https://raw.github.com/superlogical/Navbar/master/PSD/screen-2.png)

I wrote this README using [Mou][2].

[0]:https://github.com/superlogical/Navbar/blob/master/IronIo/worker.js
[1]:https://github.com/shiki/kaiseki
[2]:http://mouapp.com/donate/
[3]:https://github.com/superlogical/Navbar/blob/master/Navbar/PostsViewController.m#L189
[4]:https://github.com/tonymillion/Reachability
[5]:http://www.iron.io/worker
[6]:http://www.parse.com
[7]:https://github.com/GoogleChrome/OpenInChrome/blob/master/OpenInChromeController.h
[8]:http://sachagreif.com/



