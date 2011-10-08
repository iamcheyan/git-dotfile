/**
 * Author:
 *    Vayn a.k.a. VT <vayn@vayn.de>
 *    http://elnode.com
 *
 * URL:
 *    http://p.vim-cn.com/cbG/js
 *
 * File:             googleImageSearch.js
 * Create Date:      2011年 06月 27日 星期一 09:29:57 CST
 */

var srcNode = FireGestures.sourceNode;
var imgURL = getComputedStyle(srcNode, '').getPropertyValue('background-image'); 

if (imgURL == 'none')
  imgURL = FireGestures.getImageURL(srcNode);
else
  imgURL = imgURL.replace(/"|'/g,"").replace(/url\(|\)$/ig, "");

if (!imgURL)
    throw "Not on a image";

// check the URL is safe
FireGestures.checkURL(imgURL, srcNode.ownerDocument);

imgURL = 'http://www.google.com/searchbyimage?image_url='
            + encodeURIComponent(imgURL) + '&num=10'

// open image in new tab
var background = gPrefService.getBoolPref("browser.tabs.loadInBackground");
if (event.shiftKey || event.ctrlKey)
    background = !background;
gBrowser.loadOneTab(imgURL, null, null, null, background, false);
