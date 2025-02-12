(window.webpackJsonp=window.webpackJsonp||[]).push([[101],{442:function(t,s,e){"use strict";e.r(s);var a=e(25),n=Object(a.a)({},(function(){var t=this,s=t._self._c;return s("ContentSlotsDistributor",{attrs:{"slot-key":t.$parent.slotKey}},[s("h1",{attrs:{id:"redis"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#redis"}},[t._v("#")]),t._v(" Redis")]),t._v(" "),s("h2",{attrs:{id:"关于bind"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#关于bind"}},[t._v("#")]),t._v(" 关于bind")]),t._v(" "),s("p",[t._v("翻看网上的文章，此处多翻译为“指定redis只接收来自于该IP地址的请求，如果不进行设置，那么将处理所有请求，在生产环境中最好设置该项”。这种解释会totally搞糊涂初学者，甚至是错误的。该处的英文原文为")]),t._v(" "),s("div",{staticClass:"language-smartyconfig extra-class"},[s("pre",{pre:!0,attrs:{class:"language-text"}},[s("code",[t._v("  # If you want you can bind a single interface, if the bind option is not \n  # specified all the interfaces will listen for incoming connections. \n  # bind 127.0.0.1\n")])])]),s("p",[t._v("该处说明bind的是interface，也就是说是网络接口。服务器可以有一个网络接口(通俗的说网卡)，或者多个。打个比方说机器上有两个网卡，分别为192.168.205.5 和192.168.205.6，如果bind 192.168.205.5，那么只有该网卡地址接受外部请求，如果不绑定，则两个网卡口都接受请求。")]),t._v(" "),s("p",[t._v("OK，不知道讲清楚没有，在举一个例子。在我上面的实验过程中，我是将bind项注释掉了，实际上我还有一种解决方案。由于我redis服务器的地址是 192.168.1.4 。如果我不注释bind项，还有什么办法呢？我可以做如下配置:")]),t._v(" "),s("div",{staticClass:"language-smartyconfig extra-class"},[s("pre",{pre:!0,attrs:{class:"language-text"}},[s("code",[t._v("# bind 192.168.1.4\n")])])]),s("p",[t._v("这里很多人会误以为绑定的ip应该是请求来源的ip。其实不然，这里应该绑定的是你redis服务器本身接受请求的ip")]),t._v(" "),s("blockquote",[s("p",[t._v("来源：CSDN\n原文：https://blog.csdn.net/hel12he/article/details/46911159")])]),t._v(" "),s("h2",{attrs:{id:"redis-set方法详解"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#redis-set方法详解"}},[t._v("#")]),t._v(" redis.set方法详解")]),t._v(" "),s("div",{staticClass:"language-bash extra-class"},[s("pre",{pre:!0,attrs:{class:"language-bash"}},[s("code",[t._v("String set"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),t._v("String key, String value, String nxxx, String expx, long "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("time")]),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(")")]),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(";")]),t._v("\n")])])]),s("p",[t._v("该方法是： 存储数据到缓存中，并制定过期时间和当Key存在时是否覆盖。")]),t._v(" "),s("p",[s("code",[t._v("nxxx：")]),t._v(" 只能取"),s("code",[t._v("NX")]),t._v("或者"),s("code",[t._v("XX")]),t._v("，如果取"),s("code",[t._v("NX")]),t._v("，则只有当key不存在是才进行set，如果取"),s("code",[t._v("XX")]),t._v("，则只有当key已经存在时才进行set")]),t._v(" "),s("p",[s("code",[t._v("expx：")]),t._v(" 只能取EX或者PX，代表数据过期时间的单位，EX代表秒，PX代表毫秒。")]),t._v(" "),s("p",[s("code",[t._v("time：")]),t._v(" 过期时间，单位是expx所代表的单位。")]),t._v(" "),s("p",[t._v("判断redis是否存在方法：")]),t._v(" "),s("div",{staticClass:"language-bash extra-class"},[s("pre",{pre:!0,attrs:{class:"language-bash"}},[s("code",[s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 的是否为-2，如果是-2,则不存在键。为-1键存在。")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token number"}},[t._v("1")]),t._v(": jedis.get"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),s("span",{pre:!0,attrs:{class:"token string"}},[t._v('"ts1"')]),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(")")]),t._v(" \n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 值为true,存在，否则不存在。")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token number"}},[t._v("2")]),t._v("：jedis.exists"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),s("span",{pre:!0,attrs:{class:"token string"}},[t._v('"ts1"')]),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(")")]),t._v(" \n")])])])])}),[],!1,null,null,null);s.default=n.exports}}]);