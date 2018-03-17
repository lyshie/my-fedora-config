#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import cgi
import isbnlib
import json
import requests
from hanziconv import HanziConv


def findbook(isbn):
    res = requests.get('http://api.findbook.tw/book/{}.html'.format(isbn), headers={
                       'User-Agent': 'Opera/9.80 (Windows NT 6.1; U; en) Presto/2.2.15 Version/10.00'})
    res.encoding = 'utf-8'
    p = re.compile(
        r'''
            <div\s+class="book\-profile">
            <h1>(?P<title>.+?)</h1>          # <h1>title</h1>
            .*                               # skip
            作者：
            (?:<a[^<>]*>)*                   # <a>
            (?P<authors>.+?)                 # authors
            (?:</a>)*                        # </a>
            ,\s+出版社：
            (?P<publisher>.+?)               # publisher
            ,\s+出版日期：
            ''', re.VERBOSE)
    m = p.search(res.text.encode("UTF-8"))

    return m


def main():
    ''' Variables '''
    isbn = ''
    book = None
    callback = 'jsonp'

    ''' GET method '''
    args = cgi.FieldStorage()

    if args.has_key('callback'):
        callback = args['callback'].value

    if args.has_key('isbn'):
        isbn = args['isbn'].value
        isbn = re.sub(r'\D', '', isbn)

    ''' Lookup books '''
    try:
        book = isbnlib.meta(isbn)
    except:
        pass

    ''' Convert Simp. Chinese to Trad. Chinese '''
    if book:  # isbnlib
        if book['Language'] != 'eng':
            m = findbook(isbn)
            if m:  # lookup trad.
                book['Title'] = m.group('title')
                book['Authors'] = [m.group('authors')]
                book['Publisher'] = m.group('publisher')
            else:  # convert simp. to trad.
                book['Title'] = HanziConv.toTraditional(book['Title'])
                book['Authors'] = list(
                    map(lambda x: HanziConv.toTraditional(x), book['Authors']))
                book['Publisher'] = HanziConv.toTraditional(book['Publisher'])
    else:  # findbook
        m = findbook(isbn)
        if m:
            book = {
                'Title': m.group('title'),
                'Authors': [m.group('authors')],
                'Publisher': m.group('publisher'),
            }

    ''' Output JSON header and content '''
    print('Content-Type: application/json')
    print('')
    print("{}({})".format(callback, json.dumps(book)))


if __name__ == '__main__':
    main()
