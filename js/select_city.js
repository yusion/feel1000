/* *
 * ---------------------------------------- *
 * 城市选择组件 v1.0
 * Author: VVG
 * QQ: 83816819
 * Mail: mysheller@163.com
 * http://www.cnblogs.com/NNUF/
 * ---------------------------------------- *
 * Date: 2012-07-10
 * ---------------------------------------- *
 * */

/* *
 * 全局空间 Vcity
 * */
var Vcity = {};
/* *
 * 静态方法集
 * @name _m
 * */
Vcity._m = {
    /* 选择元素 */
    $:function (arg, context) {
        var tagAll, n, eles = [], i, sub = arg.substring(1);
        context = context || document;
        if (typeof arg == 'string') {
            switch (arg.charAt(0)) {
                case '#':
                    return document.getElementById(sub);
                    break;
                case '.':
                    if (context.getElementsByClassName) return context.getElementsByClassName(sub);
                    tagAll = Vcity._m.$('*', context);
                    n = tagAll.length;
                    for (i = 0; i < n; i++) {
                        if (tagAll[i].className.indexOf(sub) > -1) eles.push(tagAll[i]);
                    }
                    return eles;
                    break;
                default:
                    return context.getElementsByTagName(arg);
                    break;
            }
        }
    },

    /* 绑定事件 */
    on:function (node, type, handler) {
        node.addEventListener ? node.addEventListener(type, handler, false) : node.attachEvent('on' + type, handler);
    },

    /* 获取事件 */
    getEvent:function(event){
        return event || window.event;
    },

    /* 获取事件目标 */
    getTarget:function(event){
        return event.target || event.srcElement;
    },

    /* 获取元素位置 */
    getPos:function (node) {
        var scrollx = document.documentElement.scrollLeft || document.body.scrollLeft,
                scrollt = document.documentElement.scrollTop || document.body.scrollTop;
        var pos = node.getBoundingClientRect();
        return {top:pos.top + scrollt, right:pos.right + scrollx, bottom:pos.bottom + scrollt, left:pos.left + scrollx }
    },

    /* 添加样式名 */
    addClass:function (c, node) {
        if(!node)return;
        node.className = Vcity._m.hasClass(c,node) ? node.className : node.className + ' ' + c ;
    },

    /* 移除样式名 */
    removeClass:function (c, node) {
        var reg = new RegExp("(^|\\s+)" + c + "(\\s+|$)", "g");
        if(!Vcity._m.hasClass(c,node))return;
        node.className = reg.test(node.className) ? node.className.replace(reg, '') : node.className;
    },

    /* 是否含有CLASS */
    hasClass:function (c, node) {
        if(!node || !node.className)return false;
        return node.className.indexOf(c)>-1;
    },

    /* 阻止冒泡 */
    stopPropagation:function (event) {
        event = event || window.event;
        event.stopPropagation ? event.stopPropagation() : event.cancelBubble = true;
    },
    /* 去除两端空格 */
    trim:function (str) {
        return str.replace(/^\s+|\s+$/g,'');
    }
};

/* 所有城市数据,可以按照格式自行添加（北京|beijing|bj），前16条为热门城市 */

Vcity.allCity = ['北京|beijing|bj','天津|tianjin|tj','上海|shanghai|sh','重庆|zhongqing|zq','石家庄|shijiazhuang|sjz','唐山|tangshan|ts',
'秦皇岛|qinhuangdao|qhd','邯郸|handan|hd','邢台|xingtai|xt','保定|baoding|bd','张家口|zhangjiakou|zjk',
'承德|chengde|cd','沧州|cangzhou|cz','廊坊|langfang|lf','衡水|hengshui|hs','太原|taiyuan|ty',
'大同|datong|dt','阳泉|yangquan|yq','长治|changzhi|cz','晋城|jincheng|jc','朔州|shuozhou|sz',
'晋中|jinzhong|jz','运城|yuncheng|yc','忻州|xinzhou|xz','临汾|linfen|lf','吕梁|lvliang|ll',
'台北|taibei|tb','高雄|gaoxiong|gx','基隆|jilong|jl','台中|taizhong|tz','台南|tainan|tn',
'新竹|xinzhu|xz','嘉义|jiayi|jy','台北|taibei|tb','宜兰|yilan|yl','桃园|taoyuan|ty',
'新竹|xinzhu|xz','苗栗|miaoli|ml','台中|taizhong|tz','彰化|zhanghua|zh','南投|nantou|nt',
'云林|yunlin|yl','嘉义|jiayi|jy','台南|tainan|tn','高雄|gaoxiong|gx','屏东|pingdong|pd',
'澎湖|penghu|ph','台东|taidong|td','花莲|hualian|hl','沈阳|shenyang|sy','大连|dalian|dl',
'鞍山|anshan|as','抚顺|fushun|fs','本溪|benxi|bx','丹东|dandong|dd','锦州|jinzhou|jz',
'营口|yingkou|yk','阜新|fuxin|fx','辽阳|liaoyang|ly','盘锦|panjin|pj','铁岭|tieling|tl',
'朝阳|chaoyang|cy','葫芦岛|huludao|hld','长春|changchun|cc','吉林|jilin|jl','四平|siping|sp',
'辽源|liaoyuan|ly','通化|tonghua|th','白山|baishan|bs','松原|songyuan|sy','白城|baicheng|bc',
'延边|yanbian|yb','哈尔滨|haerbin|heb','齐齐哈尔|qiqihaer|qqhe','鹤岗|hegang|hg','双鸭山|shuangyashan|sys',
'鸡西|jixi|jx','大庆|daqing|dq','伊春|yichun|yc','牡丹江|mudanjiang|mdj','佳木斯|jiamusi|jms',
'七台河|qitaihe|qth','黑河|heihe|hh','绥化|suihua|sh','大兴安岭|daxinganling|dxal','南京|nanjing|nj',
'无锡|wuxi|wx','徐州|xuzhou|xz','常州|changzhou|cz','苏州|suzhou|sz','南通|nantong|nt',
'连云港|lianyungang|lyg','淮安|huaian|ha','盐城|yancheng|yc','扬州|yangzhou|yz','镇江|zhenjiang|zj',
'泰州|taizhou|tz','宿迁|suqian|sq','杭州|hangzhou|hz','宁波|ningbo|nb','温州|wenzhou|wz',
'嘉兴|jiaxing|jx','湖州|huzhou|hz','绍兴|shaoxing|sx','金华|jinhua|jh','衢州|quzhou|qz',
'舟山|zhoushan|zs','台州|taizhou|tz','丽水|lishui|ls','合肥|hefei|hf','芜湖|wuhu|wh',
'蚌埠|bangbu|bb','淮南|huainan|hn','马鞍山|maanshan|mas','淮北|huaibei|hb','铜陵|tongling|tl',
'安庆|anqing|aq','黄山|huangshan|hs','滁州|chuzhou|cz','阜阳|fuyang|fy','宿州|suzhou|sz',
'巢湖|chaohu|ch','六安|liuan|la','亳州|bozhou|bz','池州|chizhou|cz','宣城|xuancheng|xc',
'福州|fuzhou|fz','厦门|xiamen|xm','莆田|putian|pt','三明|sanming|sm','泉州|quanzhou|qz',
'漳州|zhangzhou|zz','南平|nanping|np','龙岩|longyan|ly','宁德|ningde|nd','南昌|nanchang|nc',
'景德镇|jingdezhen|jdz','萍乡|pingxiang|px','九江|jiujiang|jj','新余|xinyu|xy','鹰潭|yingtan|yt',
'赣州|ganzhou|gz','吉安|jian|ja','宜春|yichun|yc','抚州|fuzhou|fz','上饶|shangrao|sr',
'济南|jinan|jn','青岛|qingdao|qd','淄博|zibo|zb','枣庄|zaozhuang|zz','东营|dongying|dy',
'烟台|yantai|yt','潍坊|weifang|wf','济宁|jining|jn','泰安|taian|ta','威海|weihai|wh',
'日照|rizhao|rz','莱芜|laiwu|lw','临沂|linyi|ly','德州|dezhou|dz','聊城|liaocheng|lc',
'滨州|binzhou|bz','菏泽|heze|hz','郑州|zhengzhou|zz','开封|kaifeng|kf','洛阳|luoyang|ly',
'平顶山|pingdingshan|pds','安阳|anyang|ay','鹤壁|hebi|hb','新乡|xinxiang|xx','焦作|jiaozuo|jz',
'濮阳|puyang|py','许昌|xuchang|xc','漯河|luohe|lh','三门峡|sanmenxia|smx','南阳|nanyang|ny',
'商丘|shangqiu|sq','信阳|xinyang|xy','周口|zhoukou|zk','驻马店|zhumadian|zmd','济源|jiyuan|jy',
'武汉|wuhan|wh','黄石|huangshi|hs','十堰|shiyan|sy','荆州|jingzhou|jz','宜昌|yichang|yc',
'襄樊|xiangfan|xf','鄂州|ezhou|ez','荆门|jingmen|jm','孝感|xiaogan|xg','黄冈|huanggang|hg',
'咸宁|xianning|xn','随州|suizhou|sz','仙桃|xiantao|xt','天门|tianmen|tm','潜江|qianjiang|qj',
'神农架|shennongjia|snj','恩施|enshi|es','长沙|changsha|cs','株洲|zhuzhou|zz','湘潭|xiangtan|xt',
'衡阳|hengyang|hy','邵阳|shaoyang|sy','岳阳|yueyang|yy','常德|changde|cd','张家界|zhangjiajie|zjj',
'益阳|yiyang|yy','郴州|chenzhou|cz','永州|yongzhou|yz','怀化|huaihua|hh','娄底|loudi|ld',
'湘西|xiangxi|xx','广州|guangzhou|gz','深圳|shenzhen|sz','珠海|zhuhai|zh','汕头|shantou|st',
'韶关|shaoguan|sg','佛山|foshan|fs','江门|jiangmen|jm','湛江|zhanjiang|zj','茂名|maoming|mm',
'肇庆|zhaoqing|zq','惠州|huizhou|hz','梅州|meizhou|mz','汕尾|shanwei|sw','河源|heyuan|hy',
'阳江|yangjiang|yj','清远|qingyuan|qy','东莞|dongguan|dg','中山|zhongshan|zs','潮州|chaozhou|cz',
'揭阳|jieyang|jy','云浮|yunfu|yf','兰州|lanzhou|lz','金昌|jinchang|jc','白银|baiyin|by',
'天水|tianshui|ts','嘉峪关|jiayuguan|jyg','武威|wuwei|ww','张掖|zhangye|zy','平凉|pingliang|pl',
'酒泉|jiuquan|jq','庆阳|qingyang|qy','定西|dingxi|dx','陇南|longnan|ln','临夏|linxia|lx',
'甘南|gannan|gn','成都|chengdu|cd','自贡|zigong|zg','攀枝花|panzhihua|pzh','泸州|luzhou|lz',
'德阳|deyang|dy','绵阳|mianyang|my','广元|guangyuan|gy','遂宁|suining|sn','内江|neijiang|nj',
'乐山|leshan|ls','南充|nanchong|nc','眉山|meishan|ms','宜宾|yibin|yb','广安|guangan|ga',
'达州|dazhou|dz','雅安|yaan|ya','巴中|bazhong|bz','资阳|ziyang|zy','阿坝|aba|ab',
'甘孜|ganzi|gz','凉山|liangshan|ls','贵阳|guiyang|gy','六盘水|liupanshui|lps','遵义|zunyi|zy',
'安顺|anshun|as','铜仁|tongren|tr','毕节|bijie|bj','黔西南|qianxinan|qxn','黔东南|qiandongnan|qdn',
'黔南|qiannan|qn','海口|haikou|hk','三亚|sanya|sy','五指山|wuzhishan|wzs','琼海|qionghai|qh',
'儋州|danzhou|dz','文昌|wenchang|wc','万宁|wanning|wn','东方|dongfang|df','澄迈|chengmai|cm',
'定安|dingan|da','屯昌|tunchang|tc','临高|lingao|lg','白沙|baisha|bs','昌江|changjiang|cj',
'乐东|ledong|ld','陵水|lingshui|ls','保亭|baoting|bt','琼中|qiongzhong|qz','昆明|kunming|km',
'曲靖|qujing|qj','玉溪|yuxi|yx','保山|baoshan|bs','昭通|zhaotong|zt','丽江|lijiang|lj',
'思茅|simao|sm','临沧|lincang|lc','文山|wenshan|ws','红河|honghe|hh','西双版纳|xishuangbanna|xsbn',
'楚雄|chuxiong|cx','大理|dali|dl','德宏|dehong|dh','怒江|nujiang|nj','迪庆|diqing|dq',
'西宁|xining|xn','海东|haidong|hd','海北|haibei|hb','黄南|huangnan|hn','海南|hainan|hn',
'果洛|guoluo|gl','玉树|yushu|ys','海西|haixi|hx','西安|xian|xa','铜川|tongchuan|tc',
'宝鸡|baoji|bj','咸阳|xianyang|xy','渭南|weinan|wn','延安|yanan|ya','汉中|hanzhong|hz',
'榆林|yulin|yl','安康|ankang|ak','商洛|shangluo|sl','南宁|nanning|nn','柳州|liuzhou|lz',
'桂林|guilin|gl','北海|beihai|bh','防城港|fangchenggang|fcg','钦州|qinzhou|qz','贵港|guigang|gg',
'玉林|yulin|yl','百色|baise|bs','贺州|hezhou|hz','河池|hechi|hc','来宾|laibin|lb',
'崇左|chongzuo|cz','拉萨|lasa|ls','那曲|naqu|nq','昌都|changdu|cd','山南|shannan|sn',
'日喀则|rikaze|rkz','阿里|ali|al','林芝|linzhi|lz','银川|yinchuan|yc','石嘴山|shizuishan|szs',
'吴忠|wuzhong|wz','固原|guyuan|gy','中卫|zhongwei|zw','乌鲁木齐|wulumuqi|wlmq','克拉玛依|kelamayi|klmy',
'石河子|shihezi|shz','阿拉尔|alaer|ale','图木舒克|tumushuke|tmsk','五家渠|wujiaqu|wjq','吐鲁番|tulufan|tlf',
'阿克苏|akesu|aks','喀什|kashi|ks','哈密|hami|hm','和田|hetian|ht','阿图什|atushi|ats',
'库尔勒|kuerle|kel','昌吉|changji|cj','阜康|fukang|fk','米泉|miquan|mq','博乐|bole|bl',
'伊宁|yining|yn','奎屯|kuitun|kt','塔城|tacheng|tc','乌苏|wusu|ws','阿勒泰|aletai|alt',
'呼和浩特|huhehaote|hhht','包头|baotou|bt','乌海|wuhai|wh','赤峰|chifeng|cf','通辽|tongliao|tl',
'鄂尔多斯|eerduosi|eeds','呼伦贝尔|hulunbeier|hlbe','巴彦淖尔|bayannaoer|byne','乌兰察布|wulanchabu|wlcb','锡林郭勒盟|xilinguolemeng|xlglm',
'兴安盟|xinganmeng|xam','阿拉善盟|alashanmeng|alsm','澳门|aomen|am','香港|xianggang|xg'];


/* 正则表达式 筛选中文城市名、拼音、首字母 */

Vcity.regEx = /^([\u4E00-\u9FA5\uf900-\ufa2d]+)\|(\w+)\|(\w)\w*$/i;
Vcity.regExChiese = /([\u4E00-\u9FA5\uf900-\ufa2d]+)/;

/* *
 * 格式化城市数组为对象oCity，按照a-h,i-p,q-z,hot热门城市分组：
 * {HOT:{hot:[]},ABCDEFGH:{a:[1,2,3],b:[1,2,3]},IJKLMNOP:{i:[1.2.3],j:[1,2,3]},QRSTUVWXYZ:{}}
 * */

(function () {
    var citys = Vcity.allCity, match, letter,
            regEx = Vcity.regEx,
            reg2 = /^[a-h]$/i, reg3 = /^[i-p]$/i, reg4 = /^[q-z]$/i;
    if (!Vcity.oCity) {
        Vcity.oCity = {hot:{},ABCDEFGH:{}, IJKLMNOP:{}, QRSTUVWXYZ:{}};
        for (var i = 0, n = citys.length; i < n; i++) {
            match = regEx.exec(citys[i]);
            letter = match[3].toUpperCase();
            if (reg2.test(letter)) {
                if (!Vcity.oCity.ABCDEFGH[letter]) Vcity.oCity.ABCDEFGH[letter] = [];
                Vcity.oCity.ABCDEFGH[letter].push(match[1]);
            } else if (reg3.test(letter)) {
                if (!Vcity.oCity.IJKLMNOP[letter]) Vcity.oCity.IJKLMNOP[letter] = [];
                Vcity.oCity.IJKLMNOP[letter].push(match[1]);
            } else if (reg4.test(letter)) {
                if (!Vcity.oCity.QRSTUVWXYZ[letter]) Vcity.oCity.QRSTUVWXYZ[letter] = [];
                Vcity.oCity.QRSTUVWXYZ[letter].push(match[1]);
            }
            /* 热门城市 前16条 */
            if(i<16){
                if(!Vcity.oCity.hot['hot']) Vcity.oCity.hot['hot'] = [];
                Vcity.oCity.hot['hot'].push(match[1]);
            }
        }
    }
})();
/* 城市HTML模板 */
Vcity._template = [
    '<p class="tip">热门城市(支持汉字/拼音)</p>',
    '<ul>',
    '<li class="on">热门城市</li>',
    '<li>ABCDEFGH</li>',
    '<li>IJKLMNOP</li>',
    '<li>QRSTUVWXYZ</li>',
    '</ul>'
];

/* *
 * 城市控件构造函数
 * @CitySelector
 * */

Vcity.CitySelector = function () {
    this.initialize.apply(this, arguments);
};

Vcity.CitySelector.prototype = {

    constructor:Vcity.CitySelector,

    /* 初始化 */

    initialize :function (options) {
        var input = options.input;
        this.input = Vcity._m.$('#'+ input);
        this.inputEvent();
    },

    /* *
     * @createWarp
     * 创建城市BOX HTML 框架
     * */

    createWarp:function(){
        var inputPos = Vcity._m.getPos(this.input);
        var div = this.rootDiv = document.createElement('div');
        var that = this;

        // 设置DIV阻止冒泡
        Vcity._m.on(this.rootDiv,'click',function(event){
            Vcity._m.stopPropagation(event);
        });

        // 设置点击文档隐藏弹出的城市选择框
        Vcity._m.on(document, 'click', function (event) {
            event = Vcity._m.getEvent(event);
            var target = Vcity._m.getTarget(event);
            if(target == that.input) return false;
            //console.log(target.className);
            if (that.cityBox)Vcity._m.addClass('hide', that.cityBox);
            if (that.ul)Vcity._m.addClass('hide', that.ul);
            if(that.myIframe)Vcity._m.addClass('hide',that.myIframe);
        });
        div.className = 'citySelector';
        div.style.position = 'absolute';
        div.style.left = inputPos.left + 'px';
        div.style.top = inputPos.bottom + 'px';
        div.style.zIndex = 999999;

        // 判断是否IE6，如果是IE6需要添加iframe才能遮住SELECT框
        var isIe = (document.all) ? true : false;
        var isIE6 = this.isIE6 = isIe && !window.XMLHttpRequest;
        if(isIE6){
            var myIframe = this.myIframe =  document.createElement('iframe');
            myIframe.frameborder = '0';
            myIframe.src = 'about:blank';
            myIframe.style.position = 'absolute';
            myIframe.style.zIndex = '-1';
            this.rootDiv.appendChild(this.myIframe);
        }

        var childdiv = this.cityBox = document.createElement('div');
        childdiv.className = 'cityBox';
        childdiv.id = 'cityBox';
        childdiv.innerHTML = Vcity._template.join('');
        var hotCity = this.hotCity =  document.createElement('div');
        hotCity.className = 'hotCity';
        childdiv.appendChild(hotCity);
        div.appendChild(childdiv);
        this.createHotCity();
    },

    /* *
     * @createHotCity
     * TAB下面DIV：hot,a-h,i-p,q-z 分类HTML生成，DOM操作
     * {HOT:{hot:[]},ABCDEFGH:{a:[1,2,3],b:[1,2,3]},IJKLMNOP:{},QRSTUVWXYZ:{}}
     **/

    createHotCity:function(){
        var odiv,odl,odt,odd,odda=[],str,key,ckey,sortKey,regEx = Vcity.regEx,
                oCity = Vcity.oCity;
        for(key in oCity){
            odiv = this[key] = document.createElement('div');
            // 先设置全部隐藏hide
            odiv.className = key + ' ' + 'cityTab hide';
            sortKey=[];
            for(ckey in oCity[key]){
                sortKey.push(ckey);
                // ckey按照ABCDEDG顺序排序
                sortKey.sort();
            }
            for(var j=0,k = sortKey.length;j<k;j++){
                odl = document.createElement('dl');
                odt = document.createElement('dt');
                odd = document.createElement('dd');
                odt.innerHTML = sortKey[j] == 'hot'?'&nbsp;':sortKey[j];
                odda = [];
                for(var i=0,n=oCity[key][sortKey[j]].length;i<n;i++){
                    str = '<a href="#">' + oCity[key][sortKey[j]][i] + '</a>';
                    odda.push(str);
                }
                odd.innerHTML = odda.join('');
                odl.appendChild(odt);
                odl.appendChild(odd);
                odiv.appendChild(odl);
            }

            // 移除热门城市的隐藏CSS
            Vcity._m.removeClass('hide',this.hot);
            this.hotCity.appendChild(odiv);
        }
        document.body.appendChild(this.rootDiv);
        /* IE6 */
        this.changeIframe();

        this.tabChange();
        this.linkEvent();
    },

    /* *
     *  tab按字母顺序切换
     *  @ tabChange
     * */

    tabChange:function(){
        var lis = Vcity._m.$('li',this.cityBox);
        var divs = Vcity._m.$('div',this.hotCity);
        var that = this;
        for(var i=0,n=lis.length;i<n;i++){
            lis[i].index = i;
            lis[i].onclick = function(){
                for(var j=0;j<n;j++){
                    Vcity._m.removeClass('on',lis[j]);
                    Vcity._m.addClass('hide',divs[j]);
                }
                Vcity._m.addClass('on',this);
                Vcity._m.removeClass('hide',divs[this.index]);
                /* IE6 改变TAB的时候 改变Iframe 大小*/
                that.changeIframe();
            };
        }
    },

    /* *
     * 城市LINK事件
     *  @linkEvent
     * */

    linkEvent:function(){
        var links = Vcity._m.$('a',this.hotCity);
        var that = this;
        for(var i=0,n=links.length;i<n;i++){
            links[i].onclick = function(){
                that.input.value = this.innerHTML;
                Vcity._m.addClass('hide',that.cityBox);
                /* 点击城市名的时候隐藏myIframe */
                Vcity._m.addClass('hide',that.myIframe);
            }
        }
    },

    /* *
     * INPUT城市输入框事件
     * @inputEvent
     * */

    inputEvent:function(){
        var that = this;
        Vcity._m.on(this.input,'click',function(event){
            event = event || window.event;
            if(!that.cityBox){
                that.createWarp();
            }else if(!!that.cityBox && Vcity._m.hasClass('hide',that.cityBox)){
                // slideul 不存在或者 slideul存在但是是隐藏的时候 两者不能共存
                if(!that.ul || (that.ul && Vcity._m.hasClass('hide',that.ul))){
                    Vcity._m.removeClass('hide',that.cityBox);

                    /* IE6 移除iframe 的hide 样式 */
                    //alert('click');
                    Vcity._m.removeClass('hide',that.myIframe);
                    that.changeIframe();
                }
            }
        });
        Vcity._m.on(this.input,'focus',function(){
            that.input.select();
            if(that.input.value == '城市名') that.input.value = '';
        });
        Vcity._m.on(this.input,'blur',function(){
            if(that.input.value == '') that.input.value = '城市名';
        });
        Vcity._m.on(this.input,'keyup',function(event){
            event = event || window.event;
            var keycode = event.keyCode;
            Vcity._m.addClass('hide',that.cityBox);
            that.createUl();

            /* 移除iframe 的hide 样式 */
            Vcity._m.removeClass('hide',that.myIframe);

            // 下拉菜单显示的时候捕捉按键事件
            if(that.ul && !Vcity._m.hasClass('hide',that.ul) && !that.isEmpty){
                that.KeyboardEvent(event,keycode);
            }
        });
    },

    /* *
     * 生成下拉选择列表
     * @ createUl
     * */

    createUl:function () {
        //console.log('createUL');
        var str;
        var value = Vcity._m.trim(this.input.value);
        // 当value不等于空的时候执行
        if (value !== '') {
            var reg = new RegExp("^" + value + "|\\|" + value, 'gi');
            // 此处需设置中文输入法也可用onpropertychange
            var searchResult = [];
            for (var i = 0, n = Vcity.allCity.length; i < n; i++) {
                if (reg.test(Vcity.allCity[i])) {
                    var match = Vcity.regEx.exec(Vcity.allCity[i]);
                    if (searchResult.length !== 0) {
                        str = '<li><b class="cityname">' + match[1] + '</b><b class="cityspell">' + match[2] + '</b></li>';
                    } else {
                        str = '<li class="on"><b class="cityname">' + match[1] + '</b><b class="cityspell">' + match[2] + '</b></li>';
                    }
                    searchResult.push(str);
                }
            }
            this.isEmpty = false;
            // 如果搜索数据为空
            if (searchResult.length == 0) {
                this.isEmpty = true;
                str = '<li class="empty">对不起，没有找到数据 "<em>' + value + '</em>"</li>';
                searchResult.push(str);
            }
            // 如果slideul不存在则添加ul
            if (!this.ul) {
                var ul = this.ul = document.createElement('ul');
                ul.className = 'cityslide';
                this.rootDiv && this.rootDiv.appendChild(ul);
                // 记录按键次数，方向键
                this.count = 0;
            } else if (this.ul && Vcity._m.hasClass('hide', this.ul)) {
                this.count = 0;
                Vcity._m.removeClass('hide', this.ul);
            }
            this.ul.innerHTML = searchResult.join('');

            /* IE6 */
            this.changeIframe();

            // 绑定Li事件
            this.liEvent();
        }else{
            Vcity._m.addClass('hide',this.ul);
            Vcity._m.removeClass('hide',this.cityBox);

            Vcity._m.removeClass('hide',this.myIframe);

            this.changeIframe();
        }
    },

    /* IE6的改变遮罩SELECT 的 IFRAME尺寸大小 */
    changeIframe:function(){
        if(!this.isIE6)return;
        this.myIframe.style.width = this.rootDiv.offsetWidth + 'px';
        this.myIframe.style.height = this.rootDiv.offsetHeight + 'px';
    },

    /* *
     * 特定键盘事件，上、下、Enter键
     * @ KeyboardEvent
     * */

    KeyboardEvent:function(event,keycode){
        var lis = Vcity._m.$('li',this.ul);
        var len = lis.length;
        switch(keycode){
            case 40: //向下箭头↓
                this.count++;
                if(this.count > len-1) this.count = 0;
                for(var i=0;i<len;i++){
                    Vcity._m.removeClass('on',lis[i]);
                }
                Vcity._m.addClass('on',lis[this.count]);
                break;
            case 38: //向上箭头↑
                this.count--;
                if(this.count<0) this.count = len-1;
                for(i=0;i<len;i++){
                    Vcity._m.removeClass('on',lis[i]);
                }
                Vcity._m.addClass('on',lis[this.count]);
                break;
            case 13: // enter键
                this.input.value = Vcity.regExChiese.exec(lis[this.count].innerHTML)[0];
                Vcity._m.addClass('hide',this.ul);
                Vcity._m.addClass('hide',this.ul);
                /* IE6 */
                Vcity._m.addClass('hide',this.myIframe);
                break;
            default:
                break;
        }
    },

    /* *
     * 下拉列表的li事件
     * @ liEvent
     * */

    liEvent:function(){
        var that = this;
        var lis = Vcity._m.$('li',this.ul);
        for(var i = 0,n = lis.length;i < n;i++){
            Vcity._m.on(lis[i],'click',function(event){
                event = Vcity._m.getEvent(event);
                var target = Vcity._m.getTarget(event);
                that.input.value = Vcity.regExChiese.exec(target.innerHTML)[0];
                Vcity._m.addClass('hide',that.ul);
                /* IE6 下拉菜单点击事件 */
                Vcity._m.addClass('hide',that.myIframe);
            });
            Vcity._m.on(lis[i],'mouseover',function(event){
                event = Vcity._m.getEvent(event);
                var target = Vcity._m.getTarget(event);
                Vcity._m.addClass('on',target);
            });
            Vcity._m.on(lis[i],'mouseout',function(event){
                event = Vcity._m.getEvent(event);
                var target = Vcity._m.getTarget(event);
                Vcity._m.removeClass('on',target);
            })
        }
    }
};

/*    usage 
    <input type="text" class="cityinput" id="citySelect" value="城市名">
    alert(document.getElementById("citySelect").value);
    var test=new Vcity.CitySelector({input:'citySelect'});
*/
