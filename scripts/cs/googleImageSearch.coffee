###
  Author:
     Vayn a.k.a. VT <vayn@vayn.de>
     http://elnode.com
 
  URL:
     http://p.vim-cn.com/cbG/js
 
  File:             googleImageSearch.js
  Create Date:      2011年 11月 13日 星期日 22:27:22 CST
###

srcNode = FireGestures.sourceNode
imgURL = (getComputedStyle srcNode, '').getPropertyValue 'background-image'

if imgURL is 'none'
  imgURL = FireGestures.getImageURL srcNode
else
  imgURL = imgURL.replace(/"|'/g, '').replace /url\(|\)$/ig, ''

unless imgURL
  throw 'Not on an image'

FireGestures.checkURL imgURL, srcNode.ownerDocument

imgURL = 'http://www.google.com/searchbyimage?image_url=' +
  encodeURIComponent(imgURL) + '&num=10'

background = gPrefService.getBoolPref 'browser.tabs.loadInBackground'
if event.shiftKey or event.ctrlKey
  background = not background
gBrowser.loadOneTab imgURL, null, null, null, background, false
