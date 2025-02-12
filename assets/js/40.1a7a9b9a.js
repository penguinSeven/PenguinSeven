(window.webpackJsonp=window.webpackJsonp||[]).push([[40],{372:function(a,s,t){"use strict";t.r(s);var e=t(25),n=Object(e.a)({},(function(){var a=this,s=a._self._c;return s("ContentSlotsDistributor",{attrs:{"slot-key":a.$parent.slotKey}},[s("h2",{attrs:{id:"java"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#java"}},[a._v("#")]),a._v(" Java")]),a._v(" "),s("h3",{attrs:{id:"安装jdk1-8"}},[s("a",{staticClass:"header-anchor",attrs:{href:"#安装jdk1-8"}},[a._v("#")]),a._v(" 安装jdk1.8")]),a._v(" "),s("ul",[s("li",[a._v("下载jdk http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html")])]),a._v(" "),s("div",{staticClass:"language-bash extra-class"},[s("pre",{pre:!0,attrs:{class:"language-bash"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[a._v("wget")]),a._v(" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 解压")]),a._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[a._v("tar")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-zxvf")]),a._v(" jdk-8u151-linux-x64.tar.gz\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 移动目录")]),a._v("\n"),s("span",{pre:!0,attrs:{class:"token function"}},[a._v("mv")]),a._v(" jdk /usr/java\n")])])]),s("ul",[s("li",[a._v("修改 "),s("code",[a._v("/etc/profile")])])]),a._v(" "),s("div",{staticClass:"language-bash extra-class"},[s("pre",{pre:!0,attrs:{class:"language-bash"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[a._v("vi")]),a._v(" /etc/profile\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 添加在最后")]),a._v("\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[a._v("export")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token assign-left variable"}},[a._v("JAVA_HOME")]),s("span",{pre:!0,attrs:{class:"token operator"}},[a._v("=")]),a._v("/usr/java\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[a._v("export")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token assign-left variable"}},[a._v("JRE_HOME")]),s("span",{pre:!0,attrs:{class:"token operator"}},[a._v("=")]),s("span",{pre:!0,attrs:{class:"token variable"}},[a._v("${JAVA_HOME}")]),a._v("/jre\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[a._v("export")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token assign-left variable"}},[a._v("CLASSPATH")]),s("span",{pre:!0,attrs:{class:"token operator"}},[a._v("=")]),a._v(".:"),s("span",{pre:!0,attrs:{class:"token variable"}},[a._v("${JAVA_HOME}")]),a._v("/lib:"),s("span",{pre:!0,attrs:{class:"token variable"}},[a._v("${JRE_HOME}")]),a._v("/lib\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[a._v("export")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token assign-left variable"}},[s("span",{pre:!0,attrs:{class:"token environment constant"}},[a._v("PATH")])]),s("span",{pre:!0,attrs:{class:"token operator"}},[a._v("=")]),s("span",{pre:!0,attrs:{class:"token variable"}},[a._v("${JAVA_HOME}")]),a._v("/bin:"),s("span",{pre:!0,attrs:{class:"token environment constant"}},[a._v("$PATH")]),a._v("\n\n"),s("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 立即生效")]),a._v("\n"),s("span",{pre:!0,attrs:{class:"token builtin class-name"}},[a._v("source")]),a._v(" /etc/profile\n\n")])])]),s("ul",[s("li",[a._v("监测是否安装成功")])]),a._v(" "),s("div",{staticClass:"language-bash extra-class"},[s("pre",{pre:!0,attrs:{class:"language-bash"}},[s("code",[s("span",{pre:!0,attrs:{class:"token function"}},[a._v("java")]),a._v(" "),s("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-version")]),a._v("\n")])])])])}),[],!1,null,null,null);s.default=n.exports}}]);