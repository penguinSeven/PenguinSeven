(window.webpackJsonp=window.webpackJsonp||[]).push([[61],{396:function(t,s,a){"use strict";a.r(s);var e=a(25),n=Object(e.a)({},(function(){var t=this,s=t._self._c;return s("ContentSlotsDistributor",{attrs:{"slot-key":t.$parent.slotKey}},[s("h1",{attrs:{id:"orange"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#orange"}},[t._v("#")]),t._v(" Orange")]),t._v(" "),s("h2",{attrs:{id:"版本介绍"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#版本介绍"}},[t._v("#")]),t._v(" 版本介绍")]),t._v(" "),s("blockquote",[s("p",[t._v("系统版本：Ubuntu 16.04.7 LTS")]),t._v(" "),s("p",[t._v("OpenResty版本：1.21.4.1")]),t._v(" "),s("p",[t._v("Lua版本：5.1.5")]),t._v(" "),s("p",[t._v("luarocks版本：3.9.1")]),t._v(" "),s("p",[t._v("Orange版本：0.8.1")])]),t._v(" "),s("h2",{attrs:{id:"安装"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#安装"}},[t._v("#")]),t._v(" 安装")]),t._v(" "),s("ul",[s("li",[t._v("其他依赖")])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# install openresty and some compilation tools")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("sudo")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("apt-get")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("install")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("-y")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("curl")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("git")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" libssl-dev "),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("\\")]),t._v("\n    check libpcre3 libpcre3-dev libjemalloc-dev "),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("\\")]),t._v("\n    libjemalloc1 build-essential libtool automake autoconf pkg-config cmake\n")])])]),s("ul",[s("li",[t._v("安装"),s("code",[t._v("Lua")])])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[t._v("curl")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("-R")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("-O")]),t._v(" http://www.lua.org/ftp/lua-5.1.5.tar.gz\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("tar")]),t._v(" zxf lua-5.1.5.tar.gz\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("cd")]),t._v(" lua-5.1.5\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" linux "),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("test")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("install")]),t._v("\n")])])]),s("ul",[s("li",[t._v("安装"),s("code",[t._v("OpenResty")])])]),t._v(" "),s("blockquote",[s("p",[t._v("下载地址：http://openresty.org/cn/download.html")])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 下载安装包")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("wget")]),t._v(" https://openresty.org/download/openresty-1.21.4.1.tar.gz\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 解压")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("tar")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("-xzvf")]),t._v(" openresty-1.21.4.1.tar.gz\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 编译安装")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("cd")]),t._v(" openresty-VERSION\n./configure --with-http_stub_status_module\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token operator"}},[t._v("&&")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("install")]),t._v("\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 配置环境变量")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("echo")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token string"}},[t._v("'export PATH=/usr/local/openresty/bin:$PATH'")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token operator"}},[t._v(">>")]),t._v(" /etc/profile\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("source")]),t._v(" /etc/profile\n\n")])])]),s("ul",[s("li",[t._v("安装"),s("code",[t._v("luarocks")])])]),t._v(" "),s("blockquote",[s("p",[t._v("下载地址： https://luarocks.github.io/luarocks/releases/")])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[t._v("\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 下载安装包")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("wget")]),t._v(" https://luarocks.github.io/luarocks/releases/luarocks-3.9.1.tar.gz\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 解压")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("tar")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("-zxvf")]),t._v(" luarocks-3.9.1.tar.gz\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 初始化配置")]),t._v("\n./configure\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 编译安装，make && make install 和 make bootstrap 之间选择，推荐 make bootstrap")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" bootstrap\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 查看是否安装成功")]),t._v("\nluarocks "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[t._v("--version")]),t._v("\n")])])]),s("ul",[s("li",[t._v("安装 "),s("code",[t._v("Lor Framework")])])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[t._v("git")]),t._v(" clone https://github.com/sumory/lor.git\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("cd")]),t._v(" lor\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("sudo")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("install")]),t._v("\n")])])]),s("ul",[s("li",[t._v("下载"),s("code",[t._v("Orange")])])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[t._v("git")]),t._v(" clone https://github.com/orlabs/orange.git\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("cd")]),t._v(" orange\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[t._v("# 该方式不推荐，属于全局部署，但项目可以正常允许")]),t._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("sudo")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token function"}},[t._v("make")]),t._v(" dev\n")])])]),s("h2",{attrs:{id:"参考文档"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#参考文档"}},[t._v("#")]),t._v(" 参考文档")]),t._v(" "),s("blockquote",[s("p",[t._v("OpenResty安装：http://openresty.org/cn/installation.html")]),t._v(" "),s("p",[t._v("Orange安装: http://orange.sumory.com/install/")]),t._v(" "),s("p",[t._v("Luarocks安装： https://github.com/luarocks/luarocks/wiki/Download")]),t._v(" "),s("p",[t._v("Lua安装： https://www.runoob.com/lua/lua-environment.html")])]),t._v(" "),s("h2",{attrs:{id:"项目介绍"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#项目介绍"}},[t._v("#")]),t._v(" 项目介绍")]),t._v(" "),s("h2",{attrs:{id:"常见问题"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#常见问题"}},[t._v("#")]),t._v(" 常见问题")]),t._v(" "),s("ul",[s("li",[s("code",[t._v("CentOS 8")]),t._v("中，"),s("code",[t._v("openssl")]),t._v("库中的一些库比较新，"),s("code",[t._v("luarocks")]),t._v("源上提供的"),s("code",[t._v("luacrypto")]),t._v("是一个旧版本，并不能很好使用"),s("code",[t._v("openssl")]),t._v("库文件")])]),t._v(" "),s("div",{staticClass:"language-shell extra-class"},[s("pre",{pre:!0,attrs:{class:"language-shell"}},[s("code",[t._v("src/lcrypto.c: In "),s("span",{pre:!0,attrs:{class:"token keyword"}},[t._v("function")]),t._v(" ‘digest_pnew’:\nsrc/lcrypto.c:81:61: error: invalid application of ‘sizeof’ to incomplete "),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[t._v("type")]),t._v(" ‘EVP_MD_CTX "),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("{")]),t._v("aka struct evp_md_ctx_st"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("}")]),t._v("’\n     EVP_MD_CTX *c "),s("span",{pre:!0,attrs:{class:"token operator"}},[t._v("=")]),t._v(" "),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),t._v("EVP_MD_CTX *"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(")")]),t._v("lua_newuserdata"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),t._v("L, sizeof"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("(")]),t._v("EVP_MD_CTX"),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v("))")]),s("span",{pre:!0,attrs:{class:"token punctuation"}},[t._v(";")]),t._v("\n                                                             ^~~~~~~~~~\n")])])]),s("blockquote",[s("p",[t._v("解决办法，修改 "),s("code",[t._v("rockspec/orange-master-0.rockspec")]),t._v("文件中依赖")])]),t._v(" "),s("div",{staticClass:"language- extra-class"},[s("pre",{pre:!0,attrs:{class:"language-text"}},[s("code",[t._v('dependencies = {\n   ...\n    "luacrypto = 0.3.2-2",\n   ...\n}\n')])])]),s("p",[t._v("改为")]),t._v(" "),s("div",{staticClass:"language- extra-class"},[s("pre",{pre:!0,attrs:{class:"language-text"}},[s("code",[t._v('dependencies = {\n  ...\n    "luacrypto2 = 0.3.2-1",\n  ...\n}\n')])])])])}),[],!1,null,null,null);s.default=n.exports}}]);