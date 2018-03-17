// ==UserScript==
// @name         Find books
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Find books
// @author       Hsieh Li-Yi
// @match        *://read.moe.edu.tw/*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function ($, undefined) {
    $(function () {
        'use strict';

        function toTitleCase(str)
        {
            return str.replace(/(?:^|\w)\S*/g, function(txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
        }

        $('input#name_book').on('change', function() {
            var line = toTitleCase($(this).val());
            $(this).val(line);
        });

        $('input#auth_content').on('change', function() {
            var line = toTitleCase($(this).val());
            $(this).val(line);
        });

        $('input#isbn').on('change', function() {
            var isbn = $(this).val();
            $.getJSON('http://www.chps.tn.edu.tw/python/isbn.py?callback=?&isbn=' + isbn, function(json) {
                if (json) {
                    console.log(json);
                    $('input#name_book').val(json.Title);
                    $('input#auth_content').val(json.Authors);
                    if (json.Language == 'eng') {
                        $('select#lang').val('eng');
                    }
                }
            });
        });
        
        $('input#isbn').focus();
    });
})(window.jQuery.noConflict(true));
