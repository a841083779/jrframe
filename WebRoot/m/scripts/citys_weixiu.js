// JavaScript Document
cities = new Object();
cities['北京']=new Array('北京');
cities['天津']=new Array('天津');
cities['上海']=new Array('上海');
cities['重庆']=new Array('重庆');
cities['安徽']=new Array('合肥', '芜湖', '蚌埠', '淮南', '马鞍山', '淮北', '铜陵', '安庆', '黄山', '滁州', '阜阳', '宿州', '巢湖', '六安', '亳州', '池州','宣城');
cities['福建']=new Array('福州', '厦门', '莆田', '三明', '泉州', '漳州', '南平', '龙岩', '宁德');
cities['甘肃']=new Array('兰州', '嘉峪关', '金昌', '白银', '天水', '武威', '张掖', '平凉', '酒泉', '庆阳', '定西', '陇南', '临夏', '甘南');
cities['广东']=new Array('广州', '韶关','深圳',  '珠海', '汕头', '佛山', '江门', '湛江', '茂名', '肇庆', '惠州', '梅州', '汕尾', '河源', '阳江', '清远', '东莞', '中山', '潮州', '揭阳', '云浮');
cities['广西']=new Array('南宁', '柳州','桂林', '梧州', '北海', '防城港', '钦州', '贵港', '玉林', '百色', '贺州', '河池', '来宾', '崇左');
cities['贵州']=new Array('贵阳', '六盘水', '遵义', '安顺', '铜仁', '黔西南', '毕节', '黔东南', '黔南');
cities['海南']=new Array('海口', '三亚','其他');
cities['河北']=new Array('石家庄', '唐山', '秦皇岛', '邯郸', '邢台', '保定', '张家口', '承德', '沧州', '廊坊', '衡水');
cities['黑龙江']=new Array('哈尔滨', '齐齐哈尔', '鸡西','鹤岗', '双鸭山', '大庆', '伊春', '佳木斯', '七台河', '牡丹江', '黑河','绥化', '大兴安岭');
cities['河南']=new Array('郑州', '开封', '洛阳', '平顶山', '安阳', '鹤壁', '新乡', '焦作', '濮阳', '许昌', '漯河', '三门峡', '南阳', '商丘', '信阳','周口', '驻马店', '济源');
cities['湖北']=new Array('武汉', '黄石', '十堰', '宜昌', '襄阳', '鄂州', '荆门', '孝感', '荆州', '黄冈', '咸宁', '随州', '恩施土家族苗族自治州','仙桃','潜江','天门','神农架');
cities['湖南']=new Array('长沙', '株洲', '湘潭', '衡阳', '邵阳', '岳阳', '常德', '张家界', '益阳', '郴州', '永州', '怀化', '娄底', '湘西土家族苗族自治州');
cities['内蒙古']=new Array('呼和浩特', '包头', '乌海', '赤峰', '通辽', '鄂尔多斯', '呼伦贝尔', '兴安盟', '锡林郭勒盟', '乌兰察布盟', '巴彦淖尔盟', '阿拉善盟');
cities['江苏']=new Array('南京', '无锡', '徐州', '常州', '苏州', '南通', '连云港', '淮安', '盐城', '扬州', '镇江', '泰州', '宿迁');
cities['江西']=new Array('南昌', '景德镇', '萍乡', '九江', '新余', '鹰潭', '赣州', '吉安', '宜春', '抚州', '上饶');
cities['吉林']=new Array('长春', '吉林', '四平', '辽源', '通化', '白山', '松原', '白城', '延边朝鲜族自治州');
cities['辽宁']=new Array('沈阳', '大连', '鞍山', '抚顺', '本溪', '丹东', '锦州', '营口', '阜新', '辽阳', '盘锦', '铁岭', '朝阳', '葫芦岛');
cities['宁夏']=new Array('银川', '石嘴山', '吴忠', '固原', '中卫');
cities['青海']=new Array('西宁', '海东', '海北', '黄南', '海南', '果洛', '玉树', '海西');
cities['山西']=new Array('太原', '大同', '阳泉', '长治', '晋城', '朔州', '晋中', '运城', '忻州', '临汾', '吕梁');
cities['山东']=new Array('济南', '青岛', '淄博', '枣庄', '东营', '烟台', '潍坊', '济宁', '泰安', '威海', '日照', '莱芜', '临沂', '德州', '聊城', '滨州', '菏泽');
cities['四川']=new Array('成都', '自贡', '攀枝花', '泸州', '德阳', '绵阳', '广元', '遂宁', '内江', '乐山', '南充', '眉山', '宜宾', '广安', '达州', '雅安', '巴中', '资阳', '阿坝', '甘孜', '凉山');
cities['西藏']=new Array('拉萨', '昌都', '山南', '日喀则', '那曲', '阿里', '林芝');
cities['新疆']=new Array('乌鲁木齐', '克拉玛依', '吐鲁番', '哈密', '昌吉', '博尔塔拉', '巴音郭楞', '阿克苏', '克孜勒苏', '喀什', '和田','伊犁', '塔城', '阿勒泰', '石河子');
cities['云南']=new Array('昆明', '曲靖', '玉溪',  '保山', '昭通', '楚雄', '红河', '文山', '思茅', '西双版纳', '大理', '德宏', '丽江', '怒江', '迪庆','临沧');
cities['浙江']=new Array('杭州', '宁波', '温州', '嘉兴', '湖州', '绍兴', '金华', '衢州', '舟山', '台州', '丽水');
cities['陕西']=new Array('西安', '铜川', '宝鸡', '咸阳', '渭南', '延安', '汉中', '榆林', '安康', '商洛');

function set_city(province,provincevalue,city,cityvalue)
{
//alert(province+"-"+provincevalue+"-"+city+"-"+cityvalue);
     var pv, cv;
     var i, ii;

     pv=provincevalue;

     cv=cityvalue;

     city.length=1;
if(pv=='0') return;

if(typeof(cities[pv])=='undefined') return;

     for(i=0; i<cities[pv].length; i++)
     {
        ii = i+1;

        city.options[ii] = new Option();
        city.options[ii].text = codefans_net_CC2PY(cities[pv][i]).substring(0,1)+'-'+cities[pv][i];
        city.options[ii].value = cities[pv][i];
     }
	city.value=cityvalue;
} 