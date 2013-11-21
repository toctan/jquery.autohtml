assert = require 'assert'
$      = require 'jquery'
global.jQuery = $

require ('../src/jquery.autohtml')

describe 'jquery.autohtml', ->
  describe '#autohtml()', ->
    it 'returns the string as is if empty', ->
      html = $.autohtml ''
      assert.equal html, ''

    it 'formats the string with <p> and <br> properly', ->
      html = $.autohtml "morning\nafternoon\n\nnight"
      assert.equal html, '<p>morning<br>afternoon</p><p>night</p>'

    it 'transforms normal URLS into links', ->
      urls = [
        'http://google.com/',
        'http://nic.io',
        'https://about.me'
      ]

      for url in urls
        html = $.autohtml url
        assert.equal html, "<p><a href=\"#{url}\">#{url}</a></p>"

    it 'transforms @someone into a link', ->
      html = $.autohtml '@one @two @three @aaaaaaaaaaaaaaaaaaaa'
      assert.equal html, '<p><a href="/@one">@one</a> <a href="/@two">@two</a>
 <a href="/@three">@three</a> @aaaaaaaaaaaaaaaaaaaa</p>'

    it 'transforms image URLs into html tags', ->
      html = $.autohtml 'http://example.com/wat.jpg'
      assert.equal html, '<p><img src="http://example.com/wat.jpg" alt></p>'

    it 'transforms youtube URL into a video iframe', ->
      html1 = $.autohtml 'https://www.youtube.com/watch?v=eIZTMVNBjc4'
      html2 = $.autohtml 'http://youtu.be/eIZTMVNBjc4?t=49s'
      assert.equal html1, '<div class="video-wrapper"><iframe width="640" height="360"
 src="//www.youtube.com/embed/eIZTMVNBjc4" frameborder="0" allowfullscreen></iframe></div>'
      assert.equal html1, html2

    it 'transforms vimeo URLs into a video iframe', ->
      html1 = $.autohtml 'https://vimeo.com/79606090'
      assert.equal html1, '<div class="video-wrapper"><iframe width="640" height="360"
 src="//player.vimeo.com/video/79606090" frameborder="0" allowfullscreen></iframe></div>'

      html2 = $.autohtml 'https://vimeo.com/groups/shortfilms/videos/79958544'
      assert.equal html2, '<div class="video-wrapper"><iframe width="640" height="360"
 src="//player.vimeo.com/video/79958544" frameborder="0" allowfullscreen></iframe></div>'

    it 'transforms youku URL into a video iframe', ->
      html = $.autohtml 'http://v.youku.com/v_show/id_XNDUxNjY3Nzg4.html'
      assert.equal html, '<div class="video-wrapper"><iframe width="640" height="360"
 src="//player.youku.com/embed/XNDUxNjY3Nzg4" frameborder="0" allowfullscreen></iframe></div>'

    it 'transforms tudou URL into a video', ->
      html = $.autohtml 'http://www.tudou.com/listplay/mBdJ9-1HOcM/6aXI46sGt6U.html'
      assert.equal html, '<div class="video-wrapper"><embed width="640" height="360"
 src="//www.tudou.com/l/mBdJ9-1HOcM" type="application/x-shockwave-flash"
 allowfullscreen allowscriptaccess="always" wmode="opaque"></embed></div>'

      html2 = $.autohtml 'http://www.tudou.com/albumplay/-CnRpR4fhaQ/795OeVeOqBU.html'
      assert.equal html2, '<div class="video-wrapper"><embed width="640" height="360"
 src="//www.tudou.com/a/-CnRpR4fhaQ" type="application/x-shockwave-flash"
 allowfullscreen allowscriptaccess="always" wmode="opaque"></embed></div>'

    it 'transforms tweets URL into a tweet card', ->
      html = $.autohtml 'https://twitter.com/BarackObama/statuses/266031293945503744'
      assert.equal html, '<blockquote class="twitter-tweet">
<a href="https://twitter.com/BarackObama/statuses/266031293945503744"></a>
</blockquote><script async src="//platform.twitter.com/widgets.js"></script>'
