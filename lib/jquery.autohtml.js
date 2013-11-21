(function() {
  var $, AutoHTML;

  $ = jQuery;

  AutoHTML = (function() {
    function AutoHTML(html) {
      this.html = html;
    }

    AutoHTML.prototype.set_html = function(html) {
      this.html = html.replace('<p></p>', '').replace('<p><br>', '<p>').replace('<br></p>', '</p>');
      return this;
    };

    AutoHTML.prototype.all = function(html) {
      return this.simpleFormat().mention().image().twitter().youtube().vimeo().youku().tudou().link().html;
    };

    AutoHTML.prototype.simpleFormat = function() {
      return this.set_html(this.html.replace(/\n{2,}/g, '</p><p>').replace(/\n/g, '<br>').replace(/^(<p>)*/, '<p>').replace(/(<\/p>)*$/, '</p>'));
    };

    AutoHTML.prototype.mention = function() {
      var regex;
      regex = /@\w+/g;
      return this.set_html(this.html.replace(regex, function(match, offset, str) {
        if (match.length > 20) {
          return match;
        }
        return "<a href=\"/" + match + "\">" + match + "</a>";
      }));
    };

    AutoHTML.prototype.link = function() {
      var regex;
      regex = /((https?|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/gi;
      return this.set_html(this.html.replace(regex, '<a href="$1">$1</a>'));
    };

    AutoHTML.prototype.image = function() {
      var regex;
      regex = /https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/gi;
      return this.set_html(this.html.replace(regex, '<img src="$&" alt>'));
    };

    AutoHTML.prototype.twitter = function() {
      var regex;
      regex = /https:\/\/twitter\.com\/[A-Za-z0-9_]{1,15}\/status(es)?\/\d+/gi;
      return this.set_html(this.html.replace(regex, '\
</p><blockquote class="twitter-tweet"><a href="$&"></a></blockquote>\
<script async src="//platform.twitter.com/widgets.js"></script><p>'));
    };

    AutoHTML.prototype.youtube = function() {
      var regex;
      regex = /https?:\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/)([A-Za-z0-9_-]*)(\&\S+)?[\w?=&.\/-;#~%]*/gi;
      return this.set_html(this.html.replace(regex, '</p><div class="video-wrapper">\
<iframe width="640" height="360" src="//www.youtube.com/embed/$3" frameborder="0" allowfullscreen>\
</iframe></div><p>'));
    };

    AutoHTML.prototype.vimeo = function() {
      var regex;
      regex = /https?:\/\/(www.)?vimeo\.com\/(\w+\/)*(\d+)((\?|#)\S+)?/gi;
      return this.set_html(this.html.replace(regex, '</p><div class="video-wrapper">\
<iframe width="640" height="360" src="//player.vimeo.com/video/$3" frameborder="0" allowfullscreen>\
</iframe></div><p>'));
    };

    AutoHTML.prototype.youku = function() {
      var regex;
      regex = /http:\/\/v.youku.com\/v_show\/id_(\w+)(\.)?[\w?=&.\/-;#~%]*/gi;
      return this.set_html(this.html.replace(regex, '</p><div class="video-wrapper">\
<iframe width="640" height="360" src="//player.youku.com/embed/$1" frameborder="0" allowfullscreen>\
</iframe></div><p>'));
    };

    AutoHTML.prototype.tudou = function() {
      var regex;
      regex = /https?:\/\/(www.)?tudou\.com\/(\w)(istplay|lbumplay|iew)\/([\w-]+)[\w?=&.\/-;#~%]*/gi;
      return this.set_html(this.html.replace(regex, '</p><div class="video-wrapper">\
<embed width="640" height="360" src="//www.tudou.com/$2/$4"\
 type="application/x-shockwave-flash" allowfullscreen allowscriptaccess="always"\
 wmode="opaque"></embed></div><p>'));
    };

    return AutoHTML;

  })();

  $.autohtml = function(html) {
    if (html === '') {
      return html;
    }
    return new AutoHTML(html).all();
  };

  $.fn.autohtml = function() {
    return this.each(function() {
      return $(this).html(new AutoHTML($(this).html()).all());
    });
  };

}).call(this);
