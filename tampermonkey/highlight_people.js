// ==UserScript==
// @name         Highlight People
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Highlight People
// @author       Hsieh Li-Yi
// @match        *://e-learning.tn.edu.tw/CourseManager/CourseListManager.aspx?OCID=*
// @grant        none
// @require      http://code.jquery.com/jquery-latest.js
// ==/UserScript==

(function ($, undefined) {
    $(function () {
        'use strict';

        // statically created
        $('td span:nth-child(3)').each(function() {
            var t = $(this).text();
            if (t.match(/(臨時約僱|替代役男|正式職員工|其他|代理代課教師|實習教師)/)) {
                $(this).parent().css('background-color', '#ff0000');
                console.log(t);
            }
        });
    });
})(window.jQuery.noConflict(true));
