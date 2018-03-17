// ==UserScript==
// @name         Find books
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Find books
// @author       HSIEH, Li-Yi <lyshie@tn.edu.tw>
// @match        *://read.moe.edu.tw/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function($, undefined) {
    $(function() {
        'use strict';

        // 第一個字母大寫
        function toTitleCase(str) {
            return str.replace(/(?:^|\w)\S*/g, function(txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
        }

        // 書名 與 作者
        $('input#name_book, input#auth_content').on('change', function() {
            var line = toTitleCase($(this).val());
            $(this).val(line);
        });

        // ISBN 欄位
        $('input#isbn').on('change', function() {
            $('input#name_book, input#auth_content, input#publisher').attr('placeholder', '查詢中...');

            var isbn = $(this).val();
            $.getJSON('//www.chps.tn.edu.tw/python/isbn.py?callback=?&isbn=' + isbn, function(json) {
                if (json) {
                    console.log(json);
                    $('input#name_book').val(json.Title);
                    $('input#auth_content').val(json.Authors);
                    $('input#publisher').val(json.Publisher);

                    if (json.Language == 'eng') {
                        $('select#lang').val('eng');
                    }
                }
            });
        });

        // 預設為 ISBN 欄位
        $('input#isbn').focus();
    });
})(window.jQuery.noConflict(true));
