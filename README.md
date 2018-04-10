# Unify-10-Shots

Hello Unify, welcome to my project!

MADE IN UNDER 3 HOURS (please forgive the lack of attention to detail)

As requested, I have made an app that takes 10 pictures of you using the front camera, and haved stored them localy using an Apple API known as 'UserDefaults'. Due to the time constraint I am afraid I may have made a bit of a mess of things in the code and it may be hard to follow since I did not want to spend all my time commenting things, but I tried to make it as elegant as possible. Also the user interface could use a bit of a face lift, but it does get the job done.

The app itself is fairly straight forward, When first initaly launch it, it will ask for your approval to use the camera then you will be presented with a button that says "take ten photos" which does exactly what it says. The photos will be stored in an array as they are being taken. Then after the ten images are stored to an array, the array will be iterated through and each iteration will write the image at the selected index into 'UserDefaults'. To prove that they have been written into 'UserDefaults', I have set up a 'UICollectionView' to display the images on screen. You will see that the images are not just cached because you can then quit the application and upon reopening it, you will see that the images you took will already be reloaded into the 'UICollectionView'.

Thank you for your time and your consideration. I hope you like it!
