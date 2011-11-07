// ==UserScript==
//
// @name          Vanilla Reader Sharer
// @namespace     http://keakon.net/vayn
// @description   Enable sharing on Google Reader, vanilla JS version.
// @icon          http://vayn.de/reader-sharer
// @include       https://www.google.*/reader/view/*
// @include       http://www.google.*/reader/view/*
// @include       https://google.*/reader/view/*
// @include       http://google.*/reader/view/*
// @version       0.1.0
//
// ==/UserScript==

function $(aSelector, aElem) {
  if (!aElem)
    aElem = document
  return aElem.querySelector(aSelector)
}

function $$(aSelector, aElem) {
   if (!aElem)
     aElem = document
   return Array.prototype.slice.call(aElem.querySelectorAll(aSelector))
}

function htmlToDomNode(aHtml) {
  var container = document.createElement('div')
  container.innerHTML = aHtml
  return container.firstChild
}

function isChild(aParent, aChild) {
  var node = aChild.parentNode
  while (node !== null) {
    if (node == aParent)
      return true
    node = node.parentNode
  }
  return false
}

var serialize = function(obj) {
  var str = []
  for(p in obj)
     str.push(p + '=' + encodeURIComponent(obj[p]))
  return str.join('&')
}

var Listener = (function() {
  var i = 1
  var listeners = {}
  return {
    addListener: function(element, event, handler, capture) {
      element.addEventListener(event, handler, capture)
      listeners[i] = {
        element: element,
        event: event,
        handler: handler,
        capture: capture
      }
      return i++
    },
    removeListener: function(id) {
      if (id in listeners) {
        var h = listeners[id]
        h.element.removeEventListener(h.event, h.handler, h.capture)
      }
    }
  }
})()

function clsDelegate(aParent, aChild, aType, aFn) {
  return Listener.addListener(aParent, aType, function(e) {
    var node = e.target
    while (node !== null) {
      if (node.classList !== undefined && node.classList.contains(aChild)) {
        aFn()
        break
      }
      else
        node = node.parentNode
    }
  }, false)
}

function insertAfter(aNew, aRef) {
  if (aRef.nextSibling !== null)
    aRef.parentNode.insertBefore(aNew, aRef.nextSibling)
  else
    aRef.parentNode.appendChild(aNew)
  return aNew
}

var scripts = $$('script')
var script = scripts[scripts.length-1]
var match = /id:"display-lang",\s?value:"([^"]+)"/.exec(script.innerHTML)
var lang
if (match)
  lang = match[1]
else
  lang = 'en'

var shared_text, notes_text, share_text, share_note_text, like_text,
    liked_text, add_share_text, post_text, posting_text, close_text
if (lang == 'zh-CN') {
  shared_text = '共享条目'
  notes_text = '备注'
  share_text = '共享'
  share_note_text = '共享备注'
  like_text = '喜欢'
  liked_text = '您喜欢的条目'
  add_share_text = '添加到共享条目'
  post_text = '发布备注'
  posting_text = '发布备注中…'
  close_text = '关闭'
}
else if (lang == 'zh-TW' || lang == 'zh-HK') {
  shared_text = '共享條目'
  notes_text = '備註'
  share_text = '共享'
  share_note_text = '共享備註'
  like_text = '喜歡'
  liked_text = '您喜歡的條目'
  add_share_text = '添加到共享條目'
  post_text = '發佈備註'
  posting_text = '發佈備註中…'
  close_text = '關閉'
}
else {
  shared_text = 'Your shared items'
  notes_text = 'Notes'
  share_text = 'Share'
  share_note_text = 'Share with note'
  like_text = 'Like'
  liked_text = 'Your liked items'
  add_share_text = 'Add to shared items'
  post_text = 'Post item'
  posting_text = 'Posting item…'
  close_text = 'Close'
}

var url = document.URL

$('#lhn-friends').classList.add('section-minimized')

var $shared = htmlToDomNode('<div id="shared-selector" class="selector"><a href="#stream/user/-/state/com.google/broadcast" class="link"><div class="selector-icon"></div><span class="text">' + shared_text + '</span></a></div>')
insertAfter($shared, $('#star-selector'))
$shared.addEventListener('click', function() {
  this.classList.add('selected')
})

var $notes = htmlToDomNode('<div id="notes-selector" class="selector"><a href="#stream/user/-/state/com.google/created" class="link"><div class="selector-icon"></div><span class="text">' + notes_text + '</span></a></div>')
insertAfter($notes, $shared).addEventListener('click', function() {
  $notes.classList.add('selected')
})

var $liked = htmlToDomNode('<div id="like-selector" class="selector"><a href="#stream/user/-/state/com.google/like" class="link"><div class="selector-icon"></div><span class="text">' + liked_text + '</span></a></div>')
insertAfter($liked, $notes).addEventListener('click', function() {
  $liked.classList.add('selected')
})

if (/broadcast(?!-friends)/.exec(url))
  $shared.classList.addC('selected')
else if (/created/.exec(url))
  $notes.classList.add('selected')
else if (/like/.exec(url))
  $liked.classList.add('selected')

var lhns = $$('#lhn-recommendations, #lhn-subscriptions, \
               #scrollable-sections .selector')

for (var i = 0; i < lhns.length; i++) {
  lhns[i].addEventListener('click', function() {
    if (this.id != 'shared-selector')
      $shared.classList.remove('selected')
    if (this.id != 'notes-selector')
      $notes.classList.remove('selected')
    if (this.id != 'like-selector')
      $liked.classList.remove('selected')
  })
}

var user_id = unsafeWindow._USER_ID

var data = null
var key, key2, state_key, state_key2
var key3 = 'mf'
var token_key = null

function check(aEvent) {
  var which = aEvent.which
  if (aEvent.shiftKey && !aEvent.ctrlKey && !aEvent.altKey && (which == 83 || which == 115)) {
    share()
  }
  else if (!aEvent.shiftKey && !aEvent.ctrlKey && !aEvent.altKey && (
    which == 13 ||
    which == 111 || which == 79 ||
    which == 110 || which == 78 ||
    which == 112 || which == 80 ||
    which == 106 || which == 74 ||
    which == 107 || which == 75)) {
    setTimeout(showButton, 0)
  }
}

var $share_button = htmlToDomNode('<span class="broadcast"><span class="link unselectable">' + share_text + '</span></span>')

function scrollCheck() {
  setTimeout(function () {
    if (isChild($('#current-entry'), $share_button))
      showButton()
  }, 100)
}

function showButton() {
  if (data === null) {
    findDataLoop:
    for (key in unsafeWindow) {
      if (key.length == 2) {
        var obj = unsafeWindow[key]
        if (obj && typeof(obj) == 'object' && !('length' in obj)) {
          for (key2 in obj) {
            if (key2.length == 2) {
              var obj2 = obj[key2]
              if (obj2 && typeof(obj2) == 'object'
                  && !('length' in obj2) && key3 in obj2) {
                var obj3 = obj2[key3]
                if (obj3 && typeof(obj3) == 'object' && 'length' in obj3) {
                  data = obj
                  break findDataLoop
                }
              }
            }
          }
        }
      }
    }

    if (data === null || data[key2][key3].length == 0) {
      Listener.removeListener(collapsedHandler)
      $('#viewer-entries-container').removeEventListener('scroll', scrollCheck)
      document.removeEventListener('keypress', check)
      $expanded_view_button.removeEventListener('click', clickExpandedViewButton)
      $list_view_button.removeEventListener('click', clickListViewButton)
      return
    }

    var item = data[key2][key3][0]
    for (key in item) {
      var value = item[key]
      if (!value)
        continue

      if (!token_key && typeof(value) == 'string'
          && value.substring(0, 32) == 'tag:google.com,2005:reader/item/')
        token_key = key

      if (!state_key && typeof(value) == 'object' && value.length) {
        findStateKey:
        for (var i = 0; i < value.length; ++i) {
          var value2 = value[i]
          if (value2 && typeof(value) == 'object' && value2.type == 'state') {
            state_key = key
            for (state_key2 in value2) {
              var value3 = value2[state_key2]
              if (value3 && typeof(value3) == 'object' && 'length' in value3)
                break findStateKey
            }
          }
        }
      }
      if (token_key && state_key)
        break
    }
  }

  var current_entry = $('#current-entry')
  if (!current_entry)
    return

  var className = current_entry.className
  var match = /entry-(\d+)/.exec(className)
  var index = parseInt(match[1], 10)
  item = data[key2][key3][index]

  if (item.shared)
    $share_button.classList.add('shared')
  else if (item.shared === undefined) {
    item.shared = false
    var states = item[state_key]
    for (var i = 0; i < states.length; ++i) {
      var state = states[i]
      if (state.userId == user_id && state[state_key2][1] == 'broadcast') {
        $share_button.classList.add('shared')
        item.shared = true
        break
      }
    }
  }
  var sibling = $('#current-entry .item-plusone')
  sibling.parentNode.insertBefore($share_button, sibling.nextSibling)
}

var collapsegHandler = clsDelegate(document, 'collapsed', 'click', showButton)

function share() {
  var className = $('#current-entry').className
  try {
    var match = /entry-(\d+)/.exec(className)
    var index = parseInt(match[1], 10)
    var item = data[key2][key3][index]
    var feed_link = decodeURIComponent(
      $('#current-entry a.entry-source-title').getAttribute('href').substring(13))
    var post_data = {
      T: unsafeWindow._COMMAND_TOKEN,
      i: item[token_key],
      async: true,
      s: feed_link
    }
    post_data[item.shared ? 'r' : 'a'] = 'user/-/state/com.google/broadcast'

    function toggle() {
      item.shared = !item.shared
      if ($share_button.classList.contains('shared'))
        $share_button.classList.remove('shared')
      else
        $share_button.classList.add('shared')
    }
    GM_xmlhttpRequest({
      method: 'POST',
      url: 'https://www.google.com/reader/api/0/edit-tag?client=scroll',
      data: serialize(post_data),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      //onload: function(response) {
        //GM_log([response.status,
               //response.statusText,
               //response.readyState,
               //response.responseHeaders,
               //response.responseText,
               //response.finalUrl,
               //response.responseXML
        //].join("\n"))
      //},
      onerror: toggle
    })
    toggle()
  } catch (e) {
  }
}

$share_button.addEventListener('click', share)
document.addEventListener('keypress', check)

var $view_buttons = $$('#stream-view-options-container>div')
var $expanded_view_button = $view_buttons[1]
var $list_view_button = $view_buttons[2]
var is_expand_view = null
if ($expanded_view_button.classList.contains('jfk-button-checked')) {
  is_expand_view = true
  $('#viewer-entries-container').addEventListener('scroll', scrollCheck)
}
else {
  is_expand_view = false
}

function clickExpandedViewButton() {
  if (!is_expanded_view) {
    is_expanded_view = true
    $('#viewer-entries-container').addEventListener('scroll', scrollCheck)
  }
}

function clickListViewButton() {
  if (is_expanded_view) {
    is_expanded_view = false
    $('#viewer-entries-container').removeEventListener('scroll', scrollCheck)
  }
}

$expanded_view_button.addEventListener('click', clickExpandedViewButton)
$list_view_button.addEventListener('click', clickListViewButton)


GM_addStyle((<><![CDATA[
  #lhn-selectors #shared-selector .selector-icon {
    background-position: -64px -122px;
  }
  #lhn-selectors #notes-selector .selector-icon {
    background-position: -66px -100px;
  }
  #lhn-selectors #like-selector .selector-icon {
    background-position: -44px -100px;
  }
  #current-entry .like {
    background-position: -128px -256px;
  }
  #current-entry .like.liked {
    background-position: -144px -289px;
  }
  #current-entry .broadcast {
    background-position: -32px -66px;
  }
  #current-entry .broadcast.shared {
    background-position: -48px -98px;
  }
  #current-entry .broadcast-with-note {
    background-position: -96px -194px;
  }
  #lhn-friends {
    display: block !important;
    font-weight: 700;
    max-height: 200px;
    overflow-y: auto;
  }
]]></>).toString())

/* vim: set fdm=syntax: */
