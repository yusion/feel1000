yaoshun@comba.com.cn http://www.51taonan.com/ comba  
zaq1XSW2

www.feel1000.com


µ±Ç°µÇÂ¼ÕÊºÅ£º113595@qq.com *


OSError: decoder jpeg not available on Windows
http://stackoverflow.com/questions/22558976/oserror-decoder-jpeg-not-available-on-windows


>>> im = Image.open( "sample01.jpg" )

                        

                        >>> im.thumbnail( (400,100) )

                        

                        >>> im.save( "thumbnail.jpg" )

                        

                        >>> print im.size

                        

                        (133, 100)