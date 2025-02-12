(window.webpackJsonp=window.webpackJsonp||[]).push([[33],{367:function(a,e,s){"use strict";s.r(e);var t=s(25),r=Object(t.a)({},(function(){var a=this,e=a._self._c;return e("ContentSlotsDistributor",{attrs:{"slot-key":a.$parent.slotKey}},[e("h1",{attrs:{id:"ffmpeg-音视频处理"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#ffmpeg-音视频处理"}},[a._v("#")]),a._v(" FFMPEG 音视频处理")]),a._v(" "),e("p",[a._v("http://elkpi.com/topics/ffmpeg-f-hls.html")]),a._v(" "),e("h2",{attrs:{id:"常用测试源"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#常用测试源"}},[a._v("#")]),a._v(" 常用测试源")]),a._v(" "),e("div",{staticClass:"language-cmd extra-class"},[e("pre",{pre:!0,attrs:{class:"language-text"}},[e("code",[a._v("// 香港\nrtmp://live.hkstv.hk.lxdns.com/live/hks\n\n// 香港\nhttp://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8\n\n\n// 亚太第一卫视 \nrtmp://v1.one-tv.com/live/mpegts.stream\n\n// apple 测试\nhttp://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear2/prog_index.m3u8\n\n// 大熊兔（点播）：\nrtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov\n\n// CCTV5+高清\nhttp://ivi.bupt.edu.cn/hls/cctv5phd.m3u8\n\n")])])]),e("h2",{attrs:{id:"常用命令"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#常用命令"}},[a._v("#")]),a._v(" 常用命令:")]),a._v(" "),e("h3",{attrs:{id:"flac-转mp3-动态流输出-需指定响应头"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#flac-转mp3-动态流输出-需指定响应头"}},[a._v("#")]),a._v(" flac 转MP3，动态流输出, 需指定响应头")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token string"}},[a._v("'/data/wwwroot/cloudreve/public/uploads/20180309/1/1_aQ2p6suw.flac'")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-map")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(":0 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-v")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ab")]),a._v(" 128k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" mp3 -  \n")])])]),e("h3",{attrs:{id:"将视频流推送到流媒体服务器"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#将视频流推送到流媒体服务器"}},[a._v("#")]),a._v(" 将视频流推送到流媒体服务器")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" rtmp://live.hkstv.hk.lxdns.com/live/hks "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-c:a")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-c:v")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" flv rtmp://192.168.17.229:5080/oflaDemo/2\n")])])]),e("h3",{attrs:{id:"视频文件转mp4"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#视频文件转mp4"}},[a._v("#")]),a._v(" 视频文件转MP4")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[e("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 视频编码转H264,音频编码转aac，文件格式转MP4")]),a._v("\nffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$threads")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$old_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-preset:v")]),a._v(" ultrafast "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-tune")]),a._v(" zerolatency "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:v")]),a._v(" h264 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:a")]),a._v(" aac "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-strict")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-2")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-y")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$new_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v(";")]),a._v("\n\n"),e("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 文件格式转MP4")]),a._v("\nffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$threads")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$old_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-vcodec")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-acodec")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-y")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$new_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v(";")]),a._v("\n\n"),e("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# 音频编码转aac，文件格式转MP4")]),a._v("\nffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$threads")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$old_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-vcodec")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-acodec")]),a._v(" aac "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-strict")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-2")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-y")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$new_video")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v(";")]),a._v("\n\n"),e("span",{pre:!0,attrs:{class:"token comment"}},[a._v("# copy ")]),a._v("\nffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$input")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-c:a")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-c:v")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" flv "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("{")]),e("span",{pre:!0,attrs:{class:"token variable"}},[a._v("$out")]),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("}")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v(";")]),a._v("\n")])])]),e("h3",{attrs:{id:"修改文件创建时间"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#修改文件创建时间"}},[a._v("#")]),a._v(" 修改文件创建时间")]),a._v(" "),e("div",{staticClass:"language-php extra-class"},[e("pre",{pre:!0,attrs:{class:"language-php"}},[e("code",[a._v("ffmpeg"),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v(".")]),a._v("exe "),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v("-")]),a._v("i "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("6.")]),a._v("mp4 "),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v("-")]),a._v("metadata creation_time"),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v("=")]),e("span",{pre:!0,attrs:{class:"token string double-quoted-string"}},[a._v('"2013-06-22 15:00:00"')]),a._v(" "),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v("-")]),a._v("acodec copy "),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v("-")]),a._v("vcodec copy output"),e("span",{pre:!0,attrs:{class:"token operator"}},[a._v(".")]),a._v("mp4\n")])])]),e("h3",{attrs:{id:"转成mp4"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#转成mp4"}},[a._v("#")]),a._v(" 转成mp4")]),a._v(" "),e("p",[a._v("转码mp4（资源占用很高，允许15个转码 300M*15 = 45000M）")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("/home/webserver/server/ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("8")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" /root/Desktop/name.mp4 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-r")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("25")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-map")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:v")]),a._v(" h264 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-b")]),a._v(" 500k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-maxrate")]),a._v(" 50k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-s")]),a._v(" 1280x720 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:a")]),a._v(" aac "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-strict")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-2")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ar")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("44100")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ab")]),a._v(" 96k "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-y")]),a._v(" output.mp4\n")])])]),e("h3",{attrs:{id:"ssegment点播"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#ssegment点播"}},[a._v("#")]),a._v(" ssegment点播")]),a._v(" "),e("p",[a._v("点播切片（资源低，无需限制，可以多线程统一处理已转码视频）")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("/home/webserver/server/ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("8")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" output.mp4 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-map")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:v")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-bsf:v")]),a._v(" h264_mp4toannexb "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:a")]),a._v(" copy "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" ssegment "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_format")]),a._v(" mpegts "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_list")]),a._v(" video_1.m3u8 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_time")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("15")]),a._v(" video_1_%04d.ts\n")])])]),e("h3",{attrs:{id:"ssegment直播-没找到参数只保留一个文件"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#ssegment直播-没找到参数只保留一个文件"}},[a._v("#")]),a._v(" ssegment直播（没找到参数只保留一个文件）")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("/home/webserver/server/ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("8")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-re")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" /root/Desktop/name.mp4 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-profile:v")]),a._v(" baseline "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-level")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("3.0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-tune")]),a._v(" zerolatency "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-r")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("25")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-map")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:v")]),a._v(" h264 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-b")]),a._v(" 500k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-maxrate")]),a._v(" 50k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-s")]),a._v(" 1280x720 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:a")]),a._v(" aac "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-strict")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-2")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ar")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("44100")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ab")]),a._v(" 96k "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" ssegment "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_format")]),a._v(" mpegts "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_list_flags")]),a._v(" +live "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_list")]),a._v(" video_1.m3u8 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_time")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("5")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_list_size")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("1")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-segment_size")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("1")]),a._v(" video_1_%04d.ts\n")])])]),e("h3",{attrs:{id:"hls转播"}},[e("a",{staticClass:"header-anchor",attrs:{href:"#hls转播"}},[a._v("#")]),a._v(" hls转播")]),a._v(" "),e("p",[a._v("转播（资源占用较低，允许40个转播120M*40 = 4800M内存）")]),a._v(" "),e("div",{staticClass:"language-bash extra-class"},[e("pre",{pre:!0,attrs:{class:"language-bash"}},[e("code",[a._v("/home/webserver/server/ffmpeg "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-threads")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("8")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-re")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-i")]),a._v(" /root/Desktop/name.mp4 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-profile:v")]),a._v(" baseline "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-level")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("3.0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-tune")]),a._v(" zerolatency "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-r")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("25")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-map")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("0")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:v")]),a._v(" h264 "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-b")]),a._v(" 500k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-maxrate")]),a._v(" 50k "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-s")]),a._v(" 1280x720 "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-codec:a")]),a._v(" aac "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-strict")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-2")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ar")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("44100")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-ab")]),a._v(" 96k "),e("span",{pre:!0,attrs:{class:"token punctuation"}},[a._v("\\")]),a._v("\n"),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-f")]),a._v(" hls "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-hls_list_size")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("1")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-hls_time")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("5")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-hls_wrap")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("1")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token parameter variable"}},[a._v("-start_number")]),a._v(" "),e("span",{pre:!0,attrs:{class:"token number"}},[a._v("1")]),a._v(" video_1.m3u8\n")])])])])}),[],!1,null,null,null);e.default=r.exports}}]);