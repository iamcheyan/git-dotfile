// PLUGIN_INFO//{{{
var PLUGIN_INFO =
<VimperatorPlugin>
    <name>{NAME}</name>
    <description>Minimize the browser window</description>
    <author mail="vayn@vayn.de" homepage="http://elnode.com">Vayn</author>
    <version>0.1.0</version>
    <minVersion>2.0pre</minVersion>
    <detail><![CDATA[
== COMMANDS ==
min:
    Minimize the browser window
]]></detail>
</VimperatorPlugin>;
//}}}

(function (){

/**
 * 参考
 * https://developer.mozilla.org/en/Working_with_windows_in_chrome_code
 * https://developer.mozilla.org/en/DOM/window
 **/
var minimize = function() { // {{{
  var wm = Components.classes["@mozilla.org/appshell/window-mediator;1"]
                     .getService(Components.interfaces.nsIWindowMediator);
  var browserWindow = wm.getMostRecentWindow("navigator:browser");
  browserWindow.minimize();
}; // }}}

// ---------------------------
// User Command
// ---------------------------
commands.addUserCommand(['min'], 'Minimize the browser window', // {{{
  function (args) {
    minimize();
  }
); // }}}

// ---------------------------
// User Mappings
// ---------------------------
mappings.addUserMap([modes.NORMAL], ['<A-F9>'], // {{{
                    'Minimize the browser window', function () {
                      minimize();
                    }); // }}}

})();

// vim: fdm=marker sw=2 ts=2 et:
