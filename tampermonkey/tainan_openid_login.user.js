// ==UserScript==
// @name         Tainan OpenID Login
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Tainan OpenID Login
// @author       HSIEH, Li-Yi <lyshie@tn.edu.tw>
// @match        *://openid.tn.edu.tw/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function($, undefined) {
    $(function() {
        'use strict';

        // 去除所有空白字元
        function trimSpace(str) {
            return str.replace(/[\s\n\r]/g, '');
        }

        // 使用者名稱
        $('input#ctl00_Main_login1_UserName').on('change', function() {
            var username = trimSpace($(this).val());
            $(this).val(username);
        });

        // 預設為「使用者名稱」欄位
        $('input#ctl00_Main_login1_UserName').focus();
    });
})(window.jQuery.noConflict(true));