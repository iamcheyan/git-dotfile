# vim: set fileencoding=utf-8:
# @Author: Vayn a.k.a. VT <vayn@vayn.de>
# @Name: feed.py
# @Date: 2012-3-21 13:06:26
# A simple but versatile RSS parser.

from urllib2 import urlopen

try:
  import xml.etree.cElementTree as ET
except ImportError:
  import xml.etree.ElementTree as ET

__metaclass__ = type


class ElementWrapper:
  def __init__(self, element):
    self._element = element

  def __getattr__(self, tag):
    if tag.startswith('__'):
      raise AttributeError(tag)
    return self._element.findtext(tag)


class RssWrapper(ElementWrapper):
  def __init__(self, feed):
    channel = feed.find('channel')
    super(RssWrapper, self).__init__(channel)
    self._items = channel.findall('item')

  def __getitem__(self, index):
    return ElementWrapper(self._items[index])

class NewsItem:
  def __init__(self, title, body, link=''):
    self.title = title
    self.body = body
    self.link = link

class FeedSource:
  def __init__(self, url):
    self.url = url
    self.feed = self._getFeed()

  def _getFeed(self):
    rss = urlopen(self.url)
    tree = ET.parse(rss)
    feed = RssWrapper(tree.getroot())
    return feed

  def getItems(self):
    for item in self.feed:
      yield NewsItem(item.title, item.description, item.link)

if __name__ == '__main__':
  url = 'http://9.douban.com/rss/culture'
  FS = FeedSource(url)
  items = FS.getItems()
  with open('dc.txt', 'w+') as fh:
    for item in items:
       fh.write(item.body.encode('utf8'))