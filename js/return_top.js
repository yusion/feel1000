var IMYUAN;
IMYUAN || (IMYUAN = {});

(function(a) {
    a.fn.extend({
        returntop: function() {
            if (this[0]) {
                var b = this.click(function() {
                    a("html, body").animate({
                        scrollTop: 0
                    },
                    120)
                }),
                c = null;
                a(window).bind("scroll",
                function() {
                    var ie6=!-[1,]&&!window.XMLHttpRequest;
                    var d = a(document).scrollTop(),
                    e = a(window).height();
                    0 < d ? b.css("bottom", "200px") : b.css("bottom", "-200px");
                    ie6 && (b.hide(), clearTimeout(c), c = setTimeout(function() {
                        b.show();
                        clearTimeout(c)
                    },
                    1E3), b.css("top", d + e - 125))
                })
            }
        }

    })
})

(jQuery); 

$(document).ready(function(e){
    $("#returnTop").returntop()
});
  