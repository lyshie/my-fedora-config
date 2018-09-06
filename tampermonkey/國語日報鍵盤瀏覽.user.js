// ==UserScript==
// @name         國語日報鍵盤瀏覽
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  國語日報鍵盤瀏覽
// @author       HSIEH, Li-Yi <lyshie@tn.edu.tw>
// @match        http://ereading.mdnkids.com/images/ebooks/uploads/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function($, undefined) {
    $(function() {
        'use strict';

        setTimeout(function() {
            $('#closeButton')[0].click();
        }, 500);

        // 左、右鍵
        $('body').on('keydown', function(e) {
            if (e.keyCode == 37) {
                $('#pagePrevArrow')[0].click();
            }
            else if (e.keyCode == 39) {
                $('#nextPageArrow')[0].click();
            }
        });
    });
})(window.jQuery.noConflict(true));