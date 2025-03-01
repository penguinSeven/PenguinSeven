??
cls
@echo off
rem -- http://www.upupw.net
rem -- webmaster@upupw.net
setlocal enableextensions
if exist "%CD%\upcore\upc.cmd" pushd . && goto cfg
goto :eof

:cfg
title  UPUPW绿色服务器平台
color 0A
mode con cols=80 lines=29 >nul 2>nul
call "%CD%\upcore\upc.cmd"
if "%php%"=="" exit /b
if "%1"=="exec" if not "%2"=="" cmd /c "%2 %3 %4 %5 %6" && goto :eof
if not "%1"=="" (
  call :%1 %2
  goto :eof
)

prompt -$g
title  UPUPW NGINX PHP7.0系列正式版
color 0A
mode con cols=80 lines=29 >nul 2>nul
goto menu

:start_Nginx
echo.
echo   Nginx和PHPfpm服务正在启动...
if not exist %CD%\%nginx_dir%\logs\*.pid goto start_N
echo   Nginx服务已经运行无需重复操作，可返回主界面kk后再次开启。
echo.
%pause%
goto menu
:start_N
%php% upcfg(); || %pause% && goto menu
%CD%\%phpfpm%\winsw.exe install >nul 2>nul
%net% start %cgi_vc% >nul 2>nul
tasklist|findstr /i phpfpm.exe >nul 2>nul && goto start_FPM_OK || goto start_FPM_ERROR
:start_FPM_ERROR
echo.
echo   PHPfpm服务未能启动！
echo   1、VC++和NET2.0或3.5运行库未安装   2、%phpfpm_port%端口被占用
echo.
%pause%
goto menu
:start_FPM_OK
echo   PHPfpm服务启动成功!
%CD%\%nginx_dir%\winsw.exe install >nul 2>nul
%net% start %nginx_vc% >nul 2>nul
if exist %CD%\%nginx_dir%\logs\*.pid goto start_N_OK
echo.
echo   启动Nginx失败！可能的原因如下：
echo   1、%nginx_port%端口被占用   2、vhosts.conf配置文件错误
echo   3、记事本编辑过   4、程序路径含有中文或空格
echo   具体错误请查看Nginx\logs\nginx.log文件[error]条目
echo.
%pause%
goto menu
:start_N_OK
echo   Nginx服务启动成功!
echo.
goto :eof

:stop_Nginx
echo.
echo   Nginx和PHPfpm服务正在停止...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
  echo  # 缺少 %taskkill%, 无法进行. & %pause% & goto menu
)
%net% stop %nginx_vc% >nul 2>nul
%taskkill% /fi "SERVICES eq %nginx_vc%" /f /t >nul 2>nul
%taskkill% /fi "SERVICES eq %cgi_vc%" /f /t >nul 2>nul
%CD%\%nginx_dir%\winsw.exe uninstall >nul 2>nul
%CD%\%phpfpm%\winsw.exe uninstall >nul 2>nul
%taskkill% /im phpfpm.exe /f /t>nul 2>nul
%taskkill% /im php-cgi.exe /f /t>nul 2>nul
del /f/s/q %CD%\%nginx_dir%\logs\*.pid /q>nul 2>nul
echo   Nginx和PHPfpm服务已经停止!
goto :eof

:restart_Nginx
echo.
echo   Nginx配置正在重新加载...
if exist %CD%\%nginx_dir%\logs\*.pid goto restart_N
echo   Nginx服务未启动不能加载配置，可返回主界面s2启动后生效。
echo.
%pause%
goto menu
:restart_N
%php% upcfg(); || %pause% && goto menu
%net% stop %nginx_vc% >nul 2>nul
%net% start %nginx_vc% >nul 2>nul
echo   Nginx配置加载完毕！
echo.
goto :eof

:restart_PHPfpm
%php% upcfg(); || %pause% && goto menu
echo   PHPfpm配置正在重新加载...
echo.
taskkill /fi "SERVICES eq %cgi_vc%" /f /t >nul 2>nul
taskkill /im php-cgi.exe /f /t>nul 2>nul
%net% start %cgi_vc% >nul 2>nul
echo   PHPfpm配置加载完毕！
echo.
goto :eof

:sa_updaemon
echo.
echo   Nginx守护进程正在启动...
%CD%\%guard_dir%\winsw.exe install >nul 2>nul
%net% start %updaemon_vc% >nul 2>nul
tasklist|findstr /i updaemon.exe >nul 2>nul && goto start_U_OK || goto start_U_ERROR
:start_U_ERROR
echo.
echo   Nginx守护进程未能启动！
echo   请检查.NET2.0/3.5是否安装或被防护软件禁用。
echo.
goto :eof
:start_U_OK
echo   Nginx守护进程启动成功!
echo.
goto :eof

:sd_updaemon
tasklist|findstr /i updaemon.exe >nul 2>nul && goto stop_U_OK || goto stop_U_NO
:stop_U_OK
echo.
echo   Nginx守护进程正在停止...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
echo   # 缺少 %taskkill%, 无法进行. & %pause% & goto menu
)
%taskkill% /fi "SERVICES eq %updaemon_vc%" /f /t >nul 2>nul
%taskkill% /im updaemon.exe /f /t>nul 2>nul
%CD%\%guard_dir%\winsw.exe uninstall >nul 2>nul
echo   Nginx守护进程已经停止!
goto :eof
:stop_U_NO
goto :eof

:start_MySQL
echo   数据库服务正在启动...
%CD%\%database_dir%\bin\%database_exe% --install %database_vc% --defaults-file="%CD%\%database_dir%\my.ini" >nul 2>nul
%net% start %database_vc% >nul 2>nul
tasklist|findstr /i mysqld.exe >nul 2>nul && goto start_M_OK || goto start_M_ERROR
:start_M_ERROR
echo.
echo   启动数据库失败！可能的原因如下：
echo   1、%database_port%端口被占用   2、剩余内存不足200MB
echo   3、my.ini配置出错   4、数据表缺失或出错
echo   具体错误请查看数据库data目录%COMPUTERNAME%.err文件[error]条目
echo.
%pause%
goto menu
:start_M_OK
echo   数据库服务启动成功!
echo.
goto :eof

:stop_MySQL
echo.
echo   数据库服务正在停止...
%net% stop %database_vc% >nul 2>nul
%CD%\%database_dir%\bin\%database_exe% --remove %database_vc% >nul 2>nul
echo   数据库服务已经停止!
goto :eof

:start_redis
echo   Redis服务正在启动...
%CD%\%redis_dir%\redis-server.exe --service-install %CD%\%redis_conf% --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-start --service-name %redis_vc% >nul 2>nul
tasklist|findstr /i redis-server.exe >nul 2>nul && goto start_C_OK || goto start_C_ERROR
:start_C_ERROR
echo.
echo   Redis服务未能启动！
echo   请检查%redis_port%端口占用或被防护软件禁止。
goto :eof
:start_C_OK
echo   Redis服务启动成功!
goto :eof

:stop_redis
echo.
echo   Redis服务正在停止...
%CD%\%redis_dir%\redis-server.exe --service-stop --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-uninstall --service-name %redis_vc% >nul 2>nul
echo   Redis服务已经停止!
goto :eof

:restart_redis
echo.
echo   Redis服务正在重启...
%CD%\%redis_dir%\redis-server.exe --service-stop --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-start --service-name %redis_vc% >nul 2>nul
echo   Redis服务已经重启!
goto :eof

:start_upupw
echo.
echo   正在一键启动UPUPW全部服务...
call :start_Nginx
call :start_MySQL
call :start_redis
echo.
%pause%
goto menu

:stop_upupw
echo.
echo   正在一键停止UPUPW全部服务...
call :sd_updaemon
call :stop_Nginx
call :stop_MySQL
call :stop_redis
echo.
%pause%
goto menu

:execmd
if exist %1 call %1 && goto :eof
if exist %upcore%\%1 call %upcore%\%1 && goto :eof
echo   # 未找到 %1 !
%pause%
goto :eof

:menu
mode con cols=80 lines=29 >nul 2>nul
cls
echo.
echo     ╔════════ UPUPW NGINX版 PHP7.0系列正式版1512.1 ═══════╗
echo     ║                                                                    ║
echo     ║                                                                    ║
echo     ║            1 - 添加 虚拟主机        5 - 添加 代理虚拟主机          ║
echo     ║            2 - 删除 虚拟主机        6 - 删除 代理虚拟主机          ║
echo     ║            3 - 修改 虚拟主机        7 - 重设 数据库密码            ║
echo     ║            4 - 检测 端口状态        8 - 升级 数据库新特性          ║
echo     ║                                                                    ║
echo     ║           09 - 更改 服务端口       14 - 管理 MySQL/MariaDB         ║
echo     ║           10 - 设置 Nginx功能      15 - 设置 PHP功能组件           ║
echo     ║           11 - 添加 本地域名解析   16 - 配置 安全防护功能          ║
echo     ║           12 - 配置 备份或还原     17 - 适配 主机性能              ║
echo     ║           13 - FTP服务端管理       18 - 生产开发环境选项           ║
echo     ║           up - 检查新版本          qa - 技术支持与交流             ║
echo     ║                                                                    ║
echo     ║           s1 - 开启全部服务        s5 - 关闭全部服务               ║
echo     ║           s2 - 开启Nginx服务       s6 - 关闭Nginx服务              ║
echo     ║           s3 - 开启数据库服务      s7 - 关闭数据库服务             ║
echo     ║           s4 - 开启Redis服务       s8 - 关闭Redis服务              ║
echo     ║           rr - 重启Nginx服务       kk - 强制卸载服务进程           ║
echo     ║           ex - 定制服务扩展窗口    uc - 高级服务清理工具           ║
echo     ║                                                                    ║
echo     ╚═════════ 任何位置输入 q  返回主界面 ═══════════╝
echo.
set input=
set /p input=-^>请选择:
cls
if /i "%input%"=="s1"  call :start_upupw
if /i "%input%"=="s2"  call :start_Nginx
if /i "%input%"=="s3"  call :start_MySQL
if /i "%input%"=="s4"  call :start_redis
if /i "%input%"=="s5"  call :stop_upupw
if /i "%input%"=="s6"  call :stop_Nginx
if /i "%input%"=="s7"  call :stop_MySQL
if /i "%input%"=="s8"  call :stop_redis
if /i "%input%"=="rr"  call :restart_Nginx
if /i "%input%"=="re"  call :restart_redis
if /i "%input%"=="rp"  call :restart_PHPfpm
if /i "%input%"=="1" goto vhost_add
if /i "%input%"=="2" goto vhost_del
if /i "%input%"=="3" goto vhost_mod
if /i "%input%"=="4" goto chk_port
if /i "%input%"=="5" goto vProxy_add
if /i "%input%"=="6" goto vProxy_dis
if /i "%input%"=="7" goto reset_mydpwd
if /i "%input%"=="8" goto myd_upgrade
if /i "%input%"=="09" goto port
if /i "%input%"=="10" goto nginx_package
if /i "%input%"=="11" goto up_hosts
if /i "%input%"=="12" goto cfg_bak
if /i "%input%"=="13" goto fz_ftp
if /i "%input%"=="14" goto m_database
if /i "%input%"=="15" goto php_package
if /i "%input%"=="16" goto safe_pz
if /i "%input%"=="17" goto Performance
if /i "%input%"=="18" goto cfg_sckf
if /i "%input%"=="kk" goto force_stop
if /i "%input%"=="up" goto upupw_update
if /i "%input%"=="qa" goto upupw_qa
if /i "%input%"=="ex" goto ex
if /i "%input%"=="uc" goto upupw_uc
if /i "%input%"=="q"  goto menu
if /i "%input%"==""  goto menu
echo.
%pause%
goto menu

:upupw_update
start http://www.upupw.net/Nginx/
goto menu

:upupw_qa
start http://php.upupw.net/
goto menu

:port
cls
echo.
echo   p1 - 更改 Nginx端口       p2 - 更改 数据库端口
echo.
set input=
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="p1" goto nginx_port
if /i "%input%"=="p2" goto mysql_port
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto port

:nginx_port
echo   当Nginx端口修改为非80端口时需要用HTTP://域名:端口的形式访问！
echo.
set nport=
set /p nport=-^>输入新的Nginx端口(1-65535) 目前为%nginx_port%:
if /i "%nport%"=="" goto menu
if /i "%nport%"=="q" goto menu
%php% "$p = env('nport'); if ($p !== ''.ceil($p) || 1 > $p || $p > 65535) exit(1);" || goto nginx_port
%php% "nginx_port(env('nport'));" || %pause% && goto menu
set nginx_port=%nport%
if "%1"=="noRestart" goto end
call :restart_Nginx
echo.
echo   Nginx已修改为 %nport% 端口！
echo.
%pause%
goto menu

:mysql_port
echo   当数据库端口修改为非3306端口时执行PHP程序安装操作请填入修改后的端口号！
echo.
set nport=
set /p nport=-^>输入新的数据库端口(1-65535) 目前为%database_port%:
if /i "%nport%"=="" goto menu
if /i "%nport%"=="q" goto menu
%php% "$p = env('nport'); if ($p !== ''.ceil($p) || 1 > $p || $p > 65535) exit(1);" || goto mysql_port
%php% "mysql_port(env('nport'));" || %pause% && goto menu
set database_port=%nport%
if "%1"=="noRestart" goto end
call :stop_MySQL
echo.
call :start_MySQL
echo.
echo   数据库已修改为 %nport% 端口！
echo.
%pause%
goto menu

:vhost_add
mode con cols=80 lines=45 >nul 2>nul
cls
echo   虚拟主机列表:(如列表显示不全请直接查看或修改Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   虚拟主机的主域名和标识. 例 test.com 或 blog.test.com
echo.
set hName=
set /p hName=-^>请输入一个主域名:
if /i "%hName%"=="" goto vhost_add
if /i "%hName%"=="q" goto menu
echo.
echo   绑定额外域名多个请用"空格"隔开如test.com www.test.com *.test.com(支持泛解析)
echo.
set hAlias=
set /p hAlias=-^>额外域名(可选):
if /i "%hAlias%"=="" goto vhost_add_htdocs
if /i "%hAlias%"=="q" goto menu
:vhost_add_htdocs
echo.
echo   指定网站目录(例X:\websites\site1). 留空则默认建立在 upupw/vhosts/%hName%
echo.
set htdocs=
set /p htdocs=-^>网站目录(可选):
if /i "%htdocs%"=="q" goto menu
if /i "%htdocs%"=="" goto vhost_add_2
%php% "$d = rpl('/', '\\\\', $_ENV['htdocs']); if (is_dir($d)) exit(0); if (file_exists($d)) exit(1); if (!@mkdir($d, 0, 1)) exit(2);" || echo   路径不正确或创建目录失败! && %pause% && goto vhost_add_htdocs
:vhost_add_2
echo.
echo   %hName%虚拟主机创建完毕！
%php% "vhost_add(env('hName'), env('htdocs'), env('nginx_port'), env('hAlias'), env('p'));" && call :restart_Nginx && call :restart_PHPfpm && goto vhost_add_3
:vhost_add_3
set /p sure=-^>全部完成!是否立即查看%hName%的默认页面?(y/n)
if /i "%sure%"=="n" goto vhost_add
if /i "%sure%"=="y" goto vhost_add_4
if /i "%sure%"=="q" goto menu
:vhost_add_4
if exist %CD%\%nginx_dir%\logs\*.pid start http://%hName%:%nginx_port%
goto vhost_add

:vhost_del
mode con cols=80 lines=45 >nul 2>nul
echo   虚拟主机列表:(如列表显示不全请直接查看或修改Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   要删除虚拟主机, 请输入序号或主域名.
echo.
set hName=
set /p hName=-^>请选择要删除的虚拟主机:
if /i "%hName%"=="" goto menu
if /i "%hName%"=="q" goto menu
%php% "vhost_del(env('hName'));" && call :restart_Nginx
echo.
%pause%
goto vhost_del

:vProxy_add
mode con cols=80 lines=45 >nul 2>nul
echo   添加一个虚拟主机，代理到其他网址或含端口号的IP地址
echo.
echo   现有的虚拟主机列表：
%php% "showvhs();" || %pause% && goto menu
:vProxy_add_hN
echo.
echo   添加新的主域名. 如 test.com 或 blog.test.com
echo.
set hName=
set /p hName=-^>请输入一个主域名:
if /i "%hName%"=="" goto vProxy_add
if /i "%hName%"=="q" goto menu
%php% "if (regrpl('[\w\d\.\-]+', '', env('hName'))) exit(1);" && goto vProxy_add_hA
echo   主域名只能由 "a-z0-9.-" 组成!
%pause% && goto vProxy_add_hN
:vProxy_add_hA
echo.
echo   绑定额外域名. 如 www.test.com 或 *.test.com(泛解析); 多个请用空格隔开
echo.
set hAlias=
set /p hAlias=-^>额外域名(可选):
if /i "%hAlias%"=="" goto vProxy_add_hP
if /i "%hAlias%"=="q" goto menu
%php% "if (regrpl('[\w\d\.\- *]+', '', env('hAlias'))) exit(1);" && goto vProxy_add_hP
echo   额外域名只能由 "a-z0-9.-* " 组成!
%pause% && goto proxy_add_hA
:vProxy_add_hP
echo.
echo   代理目标. 如 test.com:8080, 192.168.1.3:81 或 www.example.com
echo.
set hPass=
set /p hPass=-^>代理目标:
if /i "%hPass%"=="" goto vProxy_add_hP
if /i "%hPass%"=="q" goto menu
%php% "if (regrpl('[a-z0-9\.\-_:\/]+', '', env('hPass'))) exit(1);" && goto vProxy_add_go
echo   目标地址只能由 "a-z0-9.-_:/" 组成!
%pause% && goto vProxy_add_hP
:vProxy_add_go
%php% "vProxy_add(env('hName'), env('hAlias'), env('hPass'));"
call :restart_Nginx
echo.
echo   %hName%代理虚拟主机添加完毕！
echo.
%pause%
goto vProxy_add

:vProxy_dis
echo   继续将删除所有代理主机记录!
echo.
set /p sure=-^>确认? (y/n)
if /i "%sure%"=="n" goto menu
if /i "%sure%"=="y" goto un_proxy_1
if /i "%sure%"=="q" goto menu
:un_proxy_1
%php% "vProxy_dis();" || %pause% && goto menu
call :restart_Nginx
echo.
echo   代理虚拟主机删除完毕！
echo.
%pause%
goto menu

:vhost_mod
mode con cols=80 lines=45 >nul 2>nul
echo   虚拟主机列表:(如列表显示不全请直接查看或修改Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   要修改虚拟主机, 请输入序号或主域名.
echo.
set hName=
set /p hName=-^>请选择要修改的虚拟主机:
if /i "%hName%"=="" goto menu
if /i "%hName%"=="q" goto menu
%php% "vhost_mod(env('hName'), env('hAlias'));" || %pause% && goto menu
echo.
echo   请输入新的额外域名, 原有数据将被覆盖! 多个域名以空格隔开，留空不做修改.
echo.
set hAlias=
set /p hAlias=-^>请输入要绑定的域名:
if /i "%hAlias%"=="q" goto menu
%php% "vhost_mod(env('hName'), env('hAlias'));" || %pause% && goto menu
call :restart_Nginx
echo.
echo   %hName%虚拟主机修改完毕！
echo.
%pause%
goto vhost_mod

:nginx_package
cls
echo.
echo     ========= Nginx功能模块开启状态设置 以下模块默认已全部[开启] ==========
echo.
echo            k1 - 开启 Gzip网页压缩传输    g1 - 关闭 Gzip网页压缩传输
echo            k2 - 开启 keepalive长连接     g2 - 关闭 keepalive长连接
echo.
echo     ========= Nginx功能模块开启状态设置 以下模块默认已全部[关闭] ==========
echo.
echo            k3 - 开启 Nginx日志报告       g3 - 关闭 Nginx日志报告
echo            k4 - 开启 Expires页面缓存     g4 - 关闭 Expires页面缓存
echo.
echo     ======================== 输入SS 查看Nginx状态 =========================
echo.
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="k1" goto k_Gzip
if /i "%input%"=="g1" goto g_Gzip
if /i "%input%"=="k2" goto k_alive
if /i "%input%"=="g2" goto g_alive
if /i "%input%"=="k3" goto k_logs
if /i "%input%"=="g3" goto g_logs
if /i "%input%"=="k4" goto k_Expires
if /i "%input%"=="g4" goto g_Expires
if /i "%input%"=="ss" goto nginx_status
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto nginx_package

:k_Gzip
%php% "frpl($nginx_conf, '(gzip)[ \t].*;.*(\r\n)', '$1  on;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Gzip网页压缩传输模块开启成功！
echo.
%pause%
goto nginx_package
:g_Gzip
%php% "frpl($nginx_conf, '(gzip)[ \t].*;.*(\r\n)', '$1  off;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Gzip网页压缩传输模块关闭成功！
echo.
%pause%
goto nginx_package

:k_alive
%php% "frpl($nginx_conf, '(keepalive_timeout).*;.*(\r\n)', '$1   5;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx keepalive长连接开启成功！
echo.
%pause%
goto nginx_package
:g_alive
%php% "frpl($nginx_conf, '(keepalive_timeout).*;.*(\r\n)', '$1   0;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx keepalive长连接关闭成功！
echo.
%pause%
goto nginx_package

:k_logs
%php% "frpl($nginx_conf, '(access_log).*;.*(\r\n)', '$1  logs/$server_name.log main;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx日志报告开启成功！
echo.
%pause%
goto nginx_package
:g_logs
%php% "frpl($nginx_conf, '(access_log).*;.*(\r\n)', '$1  off;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx日志报告关闭成功！
echo.
%pause%
goto nginx_package

:k_Expires
%php% "frpl($vhosts_conf, '^.*[#]*(include).*expires.*(\r\n)', '		$1 expires.conf;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Expires页面缓存模块开启成功！
echo.
%pause%
goto nginx_package
:g_Expires
%php% "frpl($vhosts_conf, '^.*(include.*expires.*\r\n)', '		#$1');" || %pause% && goto menu
call :restart_Nginx
echo   Expires页面缓存模块关闭成功！
echo.
%pause%
goto nginx_package

:nginx_status
start http://127.0.0.1:%nginx_port%/status
goto menu

:php_package
cls
echo.
echo     ============= PHP功能组件开启状态一 以下组件默认已[开启] ===============
echo.
echo          k1   - 开启 Opcache加速缓存        g1  - 关闭 Opcache加速缓存
echo          k2   - 开启 Redis数据缓存          g2  - 关闭 Redis数据缓存
echo          k3   - 开启 exif                   g3  - 关闭 exif
echo          k4   - 开启 openssl                g4  - 关闭 openssl
echo.
echo     ============= PHP功能组件开启状态一 以下组件默认已[关闭] ===============
echo.
echo          k5   - 开启 Xdebug                 g5  - 关闭 Xdebug
echo.
echo     ========================================================================
echo.
echo   此功能需s1开启全部服务后再操作！更改过生产开发环境后需重设！
echo.
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="k1"  goto k_Opcache
if /i "%input%"=="g1"  goto g_Opcache
if /i "%input%"=="k2"  goto k_redis
if /i "%input%"=="g2"  goto g_redis
if /i "%input%"=="k3"  goto k_exif
if /i "%input%"=="g3"  goto g_exif
if /i "%input%"=="k4"  goto k_openssl
if /i "%input%"=="g4"  goto g_openssl
if /i "%input%"=="k5"  goto k_xdebug
if /i "%input%"=="g5"  goto g_xdebug
if /i "%input%"=="q"   goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto php_package

:k_Opcache
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*opcache.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_opcache.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Opcache加速组件开启成功！
echo.
%pause%
goto php_package
:g_Opcache
%php% "frpl($php_ini, '^(zend_extension.*=.*opcache.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   Opcache加速组件关闭成功！
echo.
%pause%
goto php_package

:k_redis
%php% "frpl($php_ini, '^[;]*(extension=).*redis.*(\r\n)', '$1php_redis.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Redis组件开启成功！
echo.
%pause%
goto php_package
:g_redis
%php% "frpl($php_ini, '^(extension=.*redis.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   Redis组件关闭成功！
echo.
%pause%
goto php_package

:k_exif
%php% "frpl($php_ini, '^[;]*(extension=).*exif.*(\r\n)', '$1php_exif.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   exif组件开启成功！
echo.
%pause%
goto php_package
:g_exif
%php% "frpl($php_ini, '^(extension=.*exif.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   exif组件关闭成功！
echo.
%pause%
goto php_package

:k_openssl
%php% "frpl($php_ini, '^[;]*(extension=).*openssl.*(\r\n)', '$1php_openssl.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   openssl组件开启成功！
echo.
%pause%
goto php_package
:g_openssl
%php% "frpl($php_ini, '^(extension=.*openssl.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   openssl组件关闭成功！
echo.
%pause%
goto php_package

:k_xdebug
%php% "frpl($php_ini, '^(zend_extension.*=.*opcache.*\r\n)', ';$1');" || %pause% && goto menu
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*xdebug.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_xdebug.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Xdebug组件开启成功！
echo.
%pause%
goto php_package
:g_xdebug
%php% "frpl($php_ini, '^(zend_extension.*=.*xdebug.*\r\n)', ';$1');" || %pause% && goto menu
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*opcache.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_opcache.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Xdebug组件关闭成功！
echo.
%pause%
goto php_package

:safe_pz
cls
echo.
echo     ===================== UPUPW安全防护功能配置选项 ========================
echo    ^|                                                                        ^|
echo    ^|    k1 - 开启 注入攻击防护         g1 -(默认) 关闭 注入攻击防护         ^|
echo    ^|    k2 - 开启 防跨站目录限制       g2 -(默认) 关闭 防跨站目录限制       ^|
echo    ^|    k3 - 隐藏 Nginx头部信息        g3 -(默认) 显示 Nginx头部信息        ^|
echo    ^|    k4 - 隐藏 PHP头部信息          g4 -(默认) 显示 PHP头部信息          ^|
echo    ^|    k5 - 禁用 未绑定域名访问       g5 -(默认) 启用 所有域名访问         ^|
echo    ^|    k6 - 禁用 PHP不安全函数执行    g6 -(默认) 启用 PHP所有可执行函数    ^|
echo    ^|    k7 - 禁用 外网访问phpmyadmin   g7 -(默认) 启用 外网访问phpmyadmin   ^|
echo    ^|                                                                        ^|
echo     ===================== UPUPW进程守护功能配置选项 ========================
echo    ^|                                                                        ^|
echo    ^|       d1 - 设置 检测时间间隔        d2 - 设置 侦听目标网址             ^|
echo    ^|       sa - 开启 K守护进程           sd - 关闭 K守护进程                ^|
echo    ^|                                                                        ^|
echo     ========================================================================
echo.
echo   安全防护功能需s1开启全部服务后再操作！更改过生产开发环境后需重设！
echo.
set input=
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="k1" goto k_zhuru
if /i "%input%"=="g1" goto g_zhuru
if /i "%input%"=="k2" goto k_cross
if /i "%input%"=="g2" goto g_cross
if /i "%input%"=="k3" goto k_nheader
if /i "%input%"=="g3" goto g_nheader
if /i "%input%"=="k4" goto k_pheader
if /i "%input%"=="g4" goto g_pheader
if /i "%input%"=="k5" goto k_saferesolve
if /i "%input%"=="g5" goto g_saferesolve
if /i "%input%"=="k6" goto k_hanshu
if /i "%input%"=="g6" goto g_hanshu
if /i "%input%"=="k7" goto k_phpmyadmin
if /i "%input%"=="g7" goto g_phpmyadmin
if /i "%input%"=="d1" goto upd_d1
if /i "%input%"=="d2" goto upd_d2
if /i "%input%"=="sa" call :sa_updaemon
if /i "%input%"=="sd" call :sd_updaemon
if /i "%input%"=="q"  goto menu
echo.
%pause%
goto safe_pz

:k_zhuru
%php% "frpl($php_ini, '^[;]*(auto_prepend_file.*=).*protect.*(\r\n)', '$1\"X:\upupw\Guard\protect.dll\"$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   注入攻击防护开启成功！
echo.
%pause%
goto safe_pz
:g_zhuru
%php% "frpl($php_ini, '^(auto_prepend_file.*=.*protect.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   注入攻击防护关闭成功！
echo.
%pause%
goto safe_pz

:k_cross
%php% "frpl($php_ini, '^.*[;](user_ini.filename.*uini.*\r\n)', '$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   防跨站目录限制开启成功！
echo.
%pause%
goto safe_pz
:g_cross
%php% "frpl($php_ini, '^.*(user_ini.filename.*uini.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   防跨站目录限制关闭成功！
echo.
%pause%
goto safe_pz

:k_nheader
%php% "frpl($nginx_conf, '(server_tokens)[ \t].*;.*(\r\n)', '$1  off;$2');"  || %pause% && goto menu
call :restart_Nginx
echo   Nginx头部信息成功隐藏！
echo.
%pause%
goto safe_pz
:g_nheader
%php% "frpl($nginx_conf, '(server_tokens)[ \t].*;.*(\r\n)', '$1  on;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx头部信息成功显示！
echo.
%pause%
goto safe_pz

:k_pheader
%php% "frpl($php_ini, '(expose_php.*=).*O.*(\r\n)', '$1Off$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   PHP头部信息成功隐藏！
echo.
%pause%
goto safe_pz
:g_pheader
%php% "frpl($php_ini, '(expose_php.*=).*O.*(\r\n)', '$1On$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   PHP头部信息成功显示！
echo.
%pause%
goto safe_pz

:k_saferesolve
%php% "frpl($nginx_conf, '^.*[#]*(include )saferesolve.conf;(\r\n)', '$1saferesolve.conf;$2');" || %pause% && goto menu
call :restart_Nginx
echo   已成功禁用未绑定域名访问默认主机！
echo.
%pause%
goto safe_pz
:g_saferesolve
%php% "frpl($nginx_conf, '^(include saferesolve.conf;\r\n)', '#$1');" || %pause% && goto menu
call :restart_Nginx
echo   已开放所有解析过来的域名访问默认主机！
echo.
%pause%
goto safe_pz

:k_hanshu
%php% "frpl($php_ini, '^.*[;](disable_functions.*=)', '$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   已禁用PHP不安全函数执行！
echo.
%pause%
goto safe_pz
:g_hanshu
%php% "frpl($php_ini, '^.*(disable_functions.*=)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   已启用PHP所有可执行函数！
echo.
%pause%
goto safe_pz

:k_phpmyadmin
if not exist %CD%\phpmyadmin\up-pmd.conf (
copy /y %CD%\upcore\up-pmd.c %CD%\phpmyadmin\up-pmd.conf >nul 2>nul
)
call :restart_Nginx
echo   已禁用外网访问phpmyadmin！
echo.
%pause%
goto safe_pz
:g_phpmyadmin
if exist %CD%\phpmyadmin\up-pmd.conf (
del /f/s/q %CD%\phpmyadmin\up-pmd.conf /q>nul 2>nul
)
call :restart_Nginx
echo   已启用外网访问phpmyadmin！
echo.
%pause%
goto safe_pz

:upd_d1
cls
call %CD%\upcore\upd_config.cmd
echo.
echo   设置守护进程检测和等待间隔,最终时间为目前设置的%upd_timeout%X2秒
echo.
set timeout=
set /p timeout=-^>请设置:
if /i "%timeout%"=="" goto upd_d1
if /i "%timeout%"=="q" goto safe_pz
%php% "frpl($upd_conf, '(set upd_timeout=).*[^\r\n]', 'set upd_timeout=%timeout%');" || %pause% && goto menu
call :sd_updaemon
call :sa_updaemon
echo   守护进程检测和等待间隔已更改为%timeout%X2秒！
echo.
%pause%
goto safe_pz
:upd_d2
cls
call %CD%\upcore\upd_config.cmd
echo.
echo   设置守护进程检测目标,当前为%upd_url%
echo.
set url=
set /p url=-^>请设置您的网站地址: http://
if /i "%url%"=="" goto upd_d2
if /i "%url%"=="q" goto safe_pz
%php% "frpl($upd_conf, '(set upd_url=).*[^\r\n]', 'set upd_url=http://%url%');" || %pause% && goto menu
call :sd_updaemon
call :sa_updaemon
echo   守护进程检测目标已更改为%url%
echo.
%pause%
goto safe_pz

:reset_mydpwd
cls
echo.
echo   [ e1 ] 强制修改root密码     [ e2 ] 修改任意用户密码
echo.
set input=
set /p input=-^>请选择所需功能:
if /i "%input%"=="e1"  goto reset_1
if /i "%input%"=="e2"  goto reset_2
if /i "%input%"==""    goto reset_mydpwd
if /i "%input%"=="q"   goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto reset_mydpwd
:reset_1
echo.
set rootps=
set /p rootps=-^>请输入新root密码:
if /i "%rootps%"=="" goto reset_mydpwd
if /i "%rootps%"=="q" goto menu
echo.
echo   请稍后......
echo.
call :stop_MySQL >nul 2>nul
start %CD%\upcore\rootps.cmd >nul 2>nul
%CD%\%database_dir%\bin\mysql.exe -uroot -e "update mysql.user set Password=password('%rootps%') where User='root';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -uroot -e "flush privileges;" 2>nul
taskkill /im mysqld.exe /f /t >nul 2>nul
call :start_MySQL >nul 2>nul
echo   root用户密码已修改完成！
echo.
%pause%
goto menu
:reset_2
echo.
echo   数据库默认高级管理员root,密码root,如发生异常请用phpmyadmin等工具修改！
echo.
echo   此处可修改数据库任意用户名的密码，请确保数据库服务已开启再进行以下操作！
echo.
set uname=
set /p uname=-^>数据库用户名:
if /i "%uname%"=="" goto reset_mydpwd
if /i "%uname%"=="q" goto menu
echo.
goto pwd
:pwd
set pwd=
set /p pwd=-^>原%uname%密码:
if /i "%pwd%"=="" goto reset_mydpwd
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto pwdadmin
if %errorlevel%==1045 (
echo.
echo   密码不正确, 请重新输入.
echo.
goto pwd
)
if %errorlevel%==2002 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
:pwdadmin
echo.
set newpwd=
set /p newpwd=-^>新%uname%密码:
if /i "%newpwd%"=="" goto reset_mydpwd
if /i "%newpwd%"=="q" goto menu
echo.
%CD%\%database_dir%\bin\mysqladmin.exe -u"%uname%" -p"%pwd%" password "%newpwd%" >nul 2>nul
echo   %uname%用户密码已修改完成！
echo.
%pause%
goto menu

:myd_upgrade
cls
echo.
mode con cols=80 lines=45 >nul 2>nul
echo   此功能用于数据库版本发生变化时升级数据库data目录的特性到当前版本.
echo.
set uname=
set /p uname=-^>数据库超级管理员用户名:
if /i "%uname%"=="" goto myd_upgrade
if /i "%uname%"=="q" goto menu
echo.
goto pwd_upgrade
:pwd_upgrade
set pwd=
set /p pwd=-^>%uname%密码:
if /i "%pwd%"=="" goto myd_upgrade
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto myd_upgrade_exe
if %errorlevel%==1045 (
echo.
echo   密码不正确, 请重新输入.
echo.
goto pwd_upgrade
)
if %errorlevel%==2002 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
:myd_upgrade_exe
cls
%CD%\%database_dir%\bin\mysql_upgrade.exe --user="%uname%" --password="%pwd%" --force 2>nul
echo   请复查上面的执行结果, mysql.数据表全部OK即升级成功!
echo.
%pause%
goto menu

:m_database
cls
echo.
set uname=
set /p uname=-^>数据库超级管理员用户名:
if /i "%uname%"=="" goto m_database
if /i "%uname%"=="q" goto menu
echo.
goto pwd_m
:pwd_m
set pwd=
set /p pwd=-^>%uname%密码:
if /i "%pwd%"=="" goto m_database
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto m_database_lie
if %errorlevel%==1045 (
echo.
echo   密码不正确, 请重新输入.
echo.
goto pwd_m
)
if %errorlevel%==2002 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   尝试连接数据库失败,请确认数据库运行正常.
echo.
%pause% & goto menu
)
:m_database_lie
mode con cols=80 lines=29 >nul 2>nul
cls
set Ymd=%date:~,4%%date:~5,2%%date:~8,2%
echo.
echo   此处为UPUPW程序目录数据库执行面板,导入导出命令可快速处理上G大小的数据.
echo.
echo   [ m1 ]浏览 数据库列表
echo   [ m2 ]创建 数据库
echo   [ m3 ]删除 数据库
echo.
echo   [ m4 ]浏览 用户列表
echo   [ m5 ]创建 用户
echo   [ m6 ]删除 用户
echo.
echo   [ m7 ]导出 单个数据库
echo   [ m8 ]导入 单个数据库
echo.
echo   [ m9 ]导出 全部数据库
echo   [ m10]导入 全部数据库
echo.
set input=
set /p input=-^>请选择所需功能:
if /i "%input%"=="m1"  goto mdata_1
if /i "%input%"=="m2"  goto mdata_2
if /i "%input%"=="m3"  goto mdata_3
if /i "%input%"=="m4"  goto mdata_4
if /i "%input%"=="m5"  goto mdata_5
if /i "%input%"=="m6"  goto mdata_6
if /i "%input%"=="m7"  goto mdata_7
if /i "%input%"=="m8"  goto mdata_8
if /i "%input%"=="m9"  goto mdata_9
if /i "%input%"=="m10" goto mdata_10
if /i "%input%"==""    goto m_database_lie
if /i "%input%"=="q"   goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto m_database_lie
:mdata_1
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo.
%pause%
goto m_database_lie
:mdata_2
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>请输入要创建的数据库名:
if /i "%db_name%"==""    goto mdata_2
if /i "%db_name%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Create database %db_name%;" 2>nul
echo.
echo   数据库%db_name%已创建完毕!
echo.
%pause%
goto mdata_2
:mdata_3
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>请输入要删除的数据库名:
if /i "%db_name%"=="information_schema"   echo.&echo   内部管理库不能删除&echo.&%pause%&goto mdata_3
if /i "%db_name%"=="mysql"                echo.&echo   内部管理库不能删除&echo.&%pause%&goto mdata_3
if /i "%db_name%"=="performance_schema"   echo.&echo   内部管理库不能删除&echo.&%pause%&goto mdata_3
if /i "%db_name%"==""    goto mdata_3
if /i "%db_name%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Drop database %db_name%;" 2>nul
echo.
echo   数据库%db_name%已删除完毕!
echo.
%pause%
goto mdata_3
:mdata_4
mode con cols=80 lines=45 >nul 2>nul
cls
echo   用户名  服务器地址  MD5密码
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
%pause%
goto m_database_lie
:mdata_5
mode con cols=80 lines=45 >nul 2>nul
cls
echo   用户名  服务器地址  MD5密码
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
set user_name=
set /p user_name=-^>请输入要创建的用户名:
if /i "%user_name%"==""    goto mdata_5
if /i "%user_name%"=="q"   goto m_database_lie
echo.
set user_pw=
set /p user_pw=-^>请输入要创建的用户密码:
if /i "%user_pw%"==""    goto mdata_5
if /i "%user_pw%"=="q"   goto m_database_lie
echo.
set user_host=
set /p user_host=-^>请输入所属服务器地址(一般为localhost):
if /i "%user_host%"==""    goto mdata_5
if /i "%user_host%"=="q"   goto m_database_lie
echo.
set user_db=
set /p user_db=-^>请输入要授权的数据库名:
if /i "%user_db%"==""    goto mdata_5
if /i "%user_db%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "insert into mysql.user(Host,User,Password) values('%user_host%','%user_name%',password('%user_pw%'));" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "grant all privileges on %user_db%.* to %user_name%@%user_host% identified by '%user_pw%';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
echo.
echo   用户%user_name%已创建完毕!
echo.
%pause%
goto mdata_5
:mdata_6
mode con cols=80 lines=45 >nul 2>nul
cls
echo   用户名  服务器地址  MD5密码
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
set user_name=
set /p user_name=-^>请输入要删除的用户名:
if /i "%user_name%"=="%uname%" echo.&echo   不能删除自身帐户&echo.&%pause%&goto mdata_6
if /i "%user_name%"==""        goto mdata_6
if /i "%user_name%"=="q"       goto m_database_lie
echo.
set user_host=
set /p user_host=-^>请输入所属服务器地址(一般为localhost):
if /i "%user_host%"==""    goto mdata_6
if /i "%user_host%"=="q"   goto m_database_lie
echo.
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Drop user '%user_name%'@'%user_host%';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
echo.
echo   用户%user_name%已删除完毕!
echo.
%pause%
goto mdata_6
:mdata_7
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>请输入要导出的数据库名:
if /i "%db_name%"==""    goto mdata_7
if /i "%db_name%"=="q"   goto m_database_lie
if not exist %CD%\Backup\Export\%Ymd% (
md %CD%\Backup\Export\%Ymd%
)
echo.
echo   正在导出%db_name%数据库，所需时间由数据库大小决定，请稍候...
%CD%\%database_dir%\bin\mysqldump.exe --single-transaction -u"%uname%" -p"%pwd%" --skip-lock-tables "%db_name%" > %CD%\Backup\Export\%Ymd%\%db_name%.sql 2>nul
echo.
echo   数据库%db_name%已导出到%CD%\Backup\Export\%Ymd%\%db_name%.sql
echo.
set input=
set /p input=是否要立即查看导出目录? (y/n):
if /i not "%input%"=="y" goto mdata_7
explorer %CD%\Backup\Export\%Ymd%
goto mdata_7
:mdata_8
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo   请注意:如果目标数据库有内容将会被覆盖
echo.
set db_name=
set /p db_name=-^>请输入要导入的目标数据库名:
if /i "%db_name%"==""    goto mdata_8
if /i "%db_name%"=="q"   goto m_database_lie
echo.
echo   请拷贝SQL文件到%CD%\Backup\Import文件夹中
echo.
set db_dir=
set /p db_dir=-^>请输入包含SQL后缀的文件名称:
if /i "%db_dir%"==""    goto mdata_8
if /i "%db_dir%"=="q"   goto m_database_lie
echo.
echo   正在导入%db_dir%到%db_name%数据库，请稍候...
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" "%db_name%" < %CD%\Backup\Import\%db_dir% 2>nul
echo.
echo   %db_dir%已导入到%db_name%数据库！
echo.
%pause%
goto mdata_8
:mdata_9
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set input=
set /p input=是否要立即导出以上全部数据库? (y/n):
if /i not "%input%"=="y" goto m_database_lie
if not exist %CD%\Backup\Export\All_database_%Ymd% (
md %CD%\Backup\Export\All_database_%Ymd%
)
echo.
echo   正在导出全部数据库，所需时间由数据库大小决定，请稍候...
for /f "delims=" %%i in ('dir /b /ad "%CD%\%database_dir%\data"') do (
%CD%\%database_dir%\bin\mysqldump.exe --single-transaction -u"%uname%" -p"%pwd%" --skip-lock-tables %%i > %CD%\Backup\Export\All_database_%Ymd%\%%i.sql
) 2>nul
echo.
echo   数据库已全部导出到%CD%\Backup\Export\All_database_%Ymd%
echo.
set input=
set /p input=是否要立即查看导出目录? (y/n):
if /i not "%input%"=="y" goto mdata_9
if /i "%input%"=="q" goto m_database_lie
explorer %CD%\Backup\Export\All_database_%Ymd%
goto m_database_lie
:mdata_10
mode con cols=80 lines=45 >nul 2>nul
cls
echo   内部管理库为[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo   请注意:批量导入数据将会创建同名数据库,如果数据库已存在将会被覆盖
echo.
echo   请拷贝包含SQL数据库的文件夹到%CD%\Backup\Import文件夹中
echo.
set db_dir=
set /p db_dir=-^>请输入包含SQL数据的文件夹名称:
if /i "%db_dir%"==""    goto mdata_10
if /i "%db_dir%"=="q"   goto m_database_lie
echo.
echo   正在导入%db_dir%文件夹中包含的全部数据，请稍候...
for /f "delims=" %%i in ('dir /b /l "%CD%\Backup\Import\%db_dir%"') do (
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Create database if not exists %%~ni;"
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" %%~ni < %CD%\Backup\Import\%db_dir%\%%~ni.sql
) 2>nul
echo.
echo   %db_dir%文件夹中包含的全部数据已成功导入！
echo.
%pause%
goto mdata_10

:chk_port
cls
if not exist %Sys32%\tasklist.exe goto chk_port_1
if not exist %Sys32%\netstat.exe goto chk_port_2
echo   正常开启%nginx_port%端口被Nginx占用，%database_port%端口被MySQL/MariaDB占用
echo   --------------------------------------------------------------------------
%php% "chk_port('%nginx_port%');"
if not errorlevel 1 echo   指定的 Nginx 端口 %nginx_port% 暂时未被占用.
echo.
%php% "chk_port('%phpfpm_port%');"
if not errorlevel 1 echo   指定的 PHPfpm 端口 %phpfpm_port% 暂时未被占用.
echo.
%php% "chk_port('%database_port%');"
if not errorlevel 1 echo   指定的 数据库 端口 %database_port% 暂时未被占用.
echo.
%php% "chk_port('%redis_port%');"
if not errorlevel 1 echo   指定的 Redis 端口 %redis_port% 暂时未被占用.
echo.
%php% "chk_port('%ftp_port%');"
if not errorlevel 1 echo   指定的 FTP 端口 %ftp_port% 暂时未被占用.
echo   --------------------------------------------------------------------------
echo   如果以上80端口被PID 4占用请更换IIS端口或直接输入k解除占用，输入q返回主界面
echo.
set input=
set /p input=-^>
if /i "%input%"=="k" goto k_iis
if /i "%input%"=="" goto chk_port
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto chk_port
:k_iis
echo.
net stop w3svc >nul 2>nul
net stop iisadmin >nul 2>nul
taskkill /fi "SERVICES eq w3svc" /f /t>nul 2>nul
taskkill /fi "SERVICES eq SQL Server Reporting Services (MSSQLSERVER)" /f /t>nul 2>nul
echo.
%pause% & goto chk_port
:chk_port_1
echo   # 缺少 %Sys32%\tasklist.exe, 无法进行. & %pause% & goto menu
:chk_port_2
echo   # 缺少 %Sys32%\netstat.exe, 无法进行. & %pause% & goto menu

:force_stop
echo.
echo   此功能可结束UPUPW所加载的全部服务和进程,常用于打包移植或完全删除UPUPW前的准备.
echo.
echo   此操作不会删除现有内容只清理服务和进程,是否继续？(y/n)
echo.
set input=
set /p input=-^>请选择:
echo.
if /i "%input%"=="y" goto force_stop_yes
if /i "%input%"=="n" goto force_stop_no
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto force_stop
:force_stop_no
goto menu
:force_stop_yes
echo   正在清除UPUPW所加载服务和进程，请稍后... ...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
echo   # 缺少 %taskkill%, 无法进行. & %pause% & goto menu
)
%net% stop %nginx_vc%>nul 2>nul
%net% stop %database_vc%>nul 2>nul
%net% stop %redis_vc%>nul 2>nul
%net% stop %fzftp_vc%>nul 2>nul
%taskkill% /fi "SERVICES eq %nginx_vc%" /f /t>nul 2>nul
%taskkill% /fi "SERVICES eq %cgi_vc%" /f /t>nul 2>nul
%taskkill% /fi "SERVICES eq %database_vc%" /f /t>nul 2>nul
%taskkill% /fi "SERVICES eq %updaemon_vc%" /f /t>nul 2>nul
%taskkill% /fi "SERVICES eq %redis_vc%" /f /t>nul 2>nul
%taskkill% /fi "SERVICES eq %fzftp_vc%" /f /t>nul 2>nul
%CD%\%database_dir%\bin\%database_exe% --remove %database_vc%>nul 2>nul
%CD%\%nginx_dir%\winsw.exe uninstall>nul 2>nul
%CD%\%phpfpm%\winsw.exe uninstall>nul 2>nul
%CD%\%guard_dir%\winsw.exe uninstall>nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-stop --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-uninstall --service-name %redis_vc% >nul 2>nul
%CD%\%fz_dir%\%fz_exe% /uninstall>nul 2>nul
%taskkill% /im phpfpm.exe /f /t>nul 2>nul
%taskkill% /im php-cgi.exe /f /t>nul 2>nul
%taskkill% /im nginx.exe /f /t>nul 2>nul
%taskkill% /im mysqld.exe /f /t>nul 2>nul
%taskkill% /im winsw.exe /f /t>nul 2>nul
%taskkill% /im updaemon.exe /f /t>nul 2>nul
%taskkill% /im redis-server.exe /f /t>nul 2>nul
del /f/s/q %CD%\%database_dir%\data\*.pid %CD%\%nginx_dir%\logs\*.pid /q>nul 2>nul
echo.
echo   UPUPW所加载服务和进程全部清理完毕！
echo.
%pause%
goto menu

:cfg_bak
cls
echo.
echo   备份或还原以下配置文件：
echo.
echo   Nginx主配置  :  %nginx_dir%\conf\nginx.conf
echo   虚拟主机配置 :  %vhosts_conf%
echo   PHP配置      :  %php_dir%\php.ini
echo   数据库配置   :  %database_dir%\my.ini
echo.
echo   备份或还原选项：
echo.
echo   B - 备份配置    R - 还原配置    D - 删除备份
echo.
set input=
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="B" goto cfg_bak_B
if /i "%input%"=="R" goto cfg_bak_R
if /i "%input%"=="D" goto cfg_bak_D
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto goto cfg_bak

:cfg_bak_B
set input=
set /p input= 备份名称:
if /i "%input%"=="" goto cfg_bak_B
if /i "%input%"=="q" goto cfg_bak
%php% "cfg_bak('backup '.env('input'));"
echo.
%pause%
goto cfg_bak

:cfg_bak_R
%php% "cfg_bak('show');" || %pause% && goto menu
echo.
echo   还原之前请确认是否需要对现有配置进行备份!
echo.
set n=
set /p n=-^>还原到此备份序号:
if /i "%n%"=="" echo  未选择操作或输入有误 请返回！ && %pause% && goto cfg_bak
if /i "%n%"=="q" goto cfg_bak
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_bak_R
%php% "cfg_bak('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= 配置已还原, 立即重启服务? (y/N):
if /i not "%input%"=="y" goto cfg_bak
if /i "%input%"=="q" goto menu
call :restart_PHPfpm
call :restart_Nginx
call :stop_MySQL
echo.
call :start_MySQL
echo.
goto cfg_bak

:cfg_bak_D
%php% "cfg_bak('show');" || %pause% && goto menu
echo.
set n=
set /p n=-^>删除此序号的备份:
if /i "%n%"=="" echo  未选择操作或输入有误 请返回！ && %pause% && goto cfg_bak
if /i "%n%"=="q" goto cfg_bak
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_bak_D
%php% "cfg_bak('delete '.env('n'));"
echo.
%pause%
goto cfg_bak

:Performance
cls
echo.
echo   x1 - 适配 PHP性能       x2 - 适配 数据库性能
echo.
set input=
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="x1" goto php_engine
if /i "%input%"=="x2" goto cfg_xnsp
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto Performance

:cfg_xnsp
cls
echo.
echo   注:并不是配置级别越高越好请根据流量和数据大小选择配置否则适得其反！
echo.
echo   0级配置：处理器-1/2线程  内存-512M  数据库-256M  日访问量-100/5000PV
echo   1级配置：处理器-2/8线程  内存-1/4G  数据库-1/2G  日访问量-5000/50000PV
echo   2级配置：处理器8/16线程  内存-4/8G  数据库-2/4G  日访问量-50000/100000PV
echo   3级配置：处理器16/64线程 内存-8/64G 数据库-4/16G 日访问量-100000/500000PV
echo.
%php% "cfg_xnsp('show');" || %pause% && goto menu
echo.
echo   此功能需要s1开启全部服务后再进行操作！
echo.
echo   选择前请确认是否需要对现有配置进行备份!
echo.
set n=
set /p n=-^>请选择:
cls
echo.
if /i "%n%"=="" echo    未选择操作或输入有误 请返回！ && %pause% && goto cfg_xnsp
if /i "%n%"=="q" goto Performance
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_xnsp
%php% "cfg_xnsp('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= 主机性能适配已完成, 立即重启服务? (y/n):
if /i not "%input%"=="y" goto cfg_xnsp
call :stop_MySQL
echo.
call :start_MySQL
echo.
goto cfg_xnsp

:php_engine
cls
echo.
echo     ============== PHP高配引擎性能适配 请根据主机配置选择引擎 ==============
echo    ^|                                                                        ^|
echo    ^|               p1 -CPU 4线程 -内存 2G以上                               ^|
echo    ^|               p2 -CPU 8线程 -内存 4G以上                               ^|
echo    ^|               p3 -CPU16线程 -内存 8G以上                               ^|
echo    ^|               p4 -CPU32线程 -内存16G以上                               ^|
echo    ^|               pp -还原通用默认引擎                                     ^|
echo    ^|               px -增加php-cgi进程解决高访问量时引起的502错误           ^|
echo    ^|                                                                        ^|
echo     ====小流量站点建议保持默认节省资源，大流量站点请根据主机性能选择配置====
echo.
echo   此功能需要s1开启全部服务后再进行操作！
echo.
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="p1" goto p_1
if /i "%input%"=="p2" goto p_2
if /i "%input%"=="p3" goto p_3
if /i "%input%"=="p4" goto p_4
if /i "%input%"=="pp" goto p_p
if /i "%input%"=="px" goto p_x
if /i "%input%"=="q" goto Performance
echo.
echo   未选择操作或输入有误 请返回！
echo.
%pause%
goto php_engine

:p_1
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 12 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   4线程PHP高配引擎适配成功！
echo.
%pause%
goto php_engine

:p_2
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 16 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   8线程PHP高配引擎适配成功！
echo.
%pause%
goto php_engine

:p_3
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 24 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   16线程PHP高配引擎适配成功！
echo.
%pause%
goto php_engine

:p_4
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 32 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   32线程PHP高配引擎适配成功！
echo.
%pause%
goto php_engine

:p_p
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 8 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   默认引擎还原成功！
echo.
%pause%
goto php_engine

:p_x
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 20 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   高访问量出现的502错误修复完毕，快刷新网页看看吧！
echo.
%pause%
goto php_engine

:cfg_sckf
cls
echo.
echo   请选择生产或开发环境配置
echo.
%php% "cfg_sckf('show');" || %pause% && goto menu
echo.
echo   此功能需要s1开启全部服务后再进行操作！
echo.
echo   选择前请确认是否需要对现有配置进行备份!
echo.
set n=
set /p n=-^>请选择:
cls
echo.
if /i "%n%"=="" echo    未选择操作或输入有误 请返回！ && %pause% && goto cfg_sckf
if /i "%n%"=="q" goto menu
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_sckf
%php% "cfg_sckf('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= 配置环境已设定, 立即重启服务? (y/n):
if /i not "%input%"=="y" goto cfg_sckf
if /i "%input%"=="q" goto menu
echo.
call :restart_PHPfpm
%pause%
goto cfg_sckf

:fz_ftp
cls
echo.
echo     ======================= FileZilla FTP 服务端管理 =======================
echo    ^|                                                                        ^|
echo    ^|                  f1 - 开启 FTP服务                                     ^|
echo    ^|                  f2 - 关闭 FTP服务                                     ^|
echo    ^|                  f3 - 打开 FileZilla控制台                             ^|
echo    ^|                  f4 - 卸载 FTP系统服务                                 ^|
echo    ^|                                                                        ^|
echo     =============== 请先用f1开启FTP服务后再打开FileZilla控制台 =============
echo.
set input=
set /p input=-^>请选择:
cls
echo.
if /i "%input%"=="f1" call :ftp_f1
if /i "%input%"=="f2" call :ftp_f2
if /i "%input%"=="f3" call :ftp_f3
if /i "%input%"=="f4" call :ftp_f4
if /i "%input%"=="q" goto menu
echo.
echo   输入有误请返回！
echo.
%pause%
goto fz_ftp

:ftp_f1
start %CD%\%fz_dir%\%fz_exe%
echo   FTP服务开启成功！
echo.
%pause%
goto fz_ftp

:ftp_f2
start %CD%\%fz_dir%\%fz_exe%
echo   FTP服务关闭成功！
echo.
%pause%
goto fz_ftp

:ftp_f3
start %CD%\%fz_dir%\FileZilla_Server_Interface.exe
echo   FTP及系统服务开启成功！
echo.
%pause%
goto fz_ftp

:ftp_f4
%CD%\%fz_dir%\%fz_exe% /uninstall
echo   FTP系统服务卸载成功！
echo.
%pause%
goto fz_ftp

:up_hosts
start %CD%\%upcore_dir%\uphosts.exe
goto menu

:upupw_uc
start %CD%\%upcore_dir%\upservice.exe
goto menu

:ex
call :execmd ex.cmd
goto menu

:end
promp