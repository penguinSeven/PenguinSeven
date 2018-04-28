??
cls
@echo off
rem -- http://www.upupw.net
rem -- webmaster@upupw.net
setlocal enableextensions
if exist "%CD%\upcore\upc.cmd" pushd . && goto cfg
goto :eof

:cfg
title  UPUPW��ɫ������ƽ̨
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
title  UPUPW NGINX PHP7.0ϵ����ʽ��
color 0A
mode con cols=80 lines=29 >nul 2>nul
goto menu

:start_Nginx
echo.
echo   Nginx��PHPfpm������������...
if not exist %CD%\%nginx_dir%\logs\*.pid goto start_N
echo   Nginx�����Ѿ����������ظ��������ɷ���������kk���ٴο�����
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
echo   PHPfpm����δ��������
echo   1��VC++��NET2.0��3.5���п�δ��װ   2��%phpfpm_port%�˿ڱ�ռ��
echo.
%pause%
goto menu
:start_FPM_OK
echo   PHPfpm���������ɹ�!
%CD%\%nginx_dir%\winsw.exe install >nul 2>nul
%net% start %nginx_vc% >nul 2>nul
if exist %CD%\%nginx_dir%\logs\*.pid goto start_N_OK
echo.
echo   ����Nginxʧ�ܣ����ܵ�ԭ�����£�
echo   1��%nginx_port%�˿ڱ�ռ��   2��vhosts.conf�����ļ�����
echo   3�����±��༭��   4������·���������Ļ�ո�
echo   ���������鿴Nginx\logs\nginx.log�ļ�[error]��Ŀ
echo.
%pause%
goto menu
:start_N_OK
echo   Nginx���������ɹ�!
echo.
goto :eof

:stop_Nginx
echo.
echo   Nginx��PHPfpm��������ֹͣ...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
  echo  # ȱ�� %taskkill%, �޷�����. & %pause% & goto menu
)
%net% stop %nginx_vc% >nul 2>nul
%taskkill% /fi "SERVICES eq %nginx_vc%" /f /t >nul 2>nul
%taskkill% /fi "SERVICES eq %cgi_vc%" /f /t >nul 2>nul
%CD%\%nginx_dir%\winsw.exe uninstall >nul 2>nul
%CD%\%phpfpm%\winsw.exe uninstall >nul 2>nul
%taskkill% /im phpfpm.exe /f /t>nul 2>nul
%taskkill% /im php-cgi.exe /f /t>nul 2>nul
del /f/s/q %CD%\%nginx_dir%\logs\*.pid /q>nul 2>nul
echo   Nginx��PHPfpm�����Ѿ�ֹͣ!
goto :eof

:restart_Nginx
echo.
echo   Nginx�����������¼���...
if exist %CD%\%nginx_dir%\logs\*.pid goto restart_N
echo   Nginx����δ�������ܼ������ã��ɷ���������s2��������Ч��
echo.
%pause%
goto menu
:restart_N
%php% upcfg(); || %pause% && goto menu
%net% stop %nginx_vc% >nul 2>nul
%net% start %nginx_vc% >nul 2>nul
echo   Nginx���ü�����ϣ�
echo.
goto :eof

:restart_PHPfpm
%php% upcfg(); || %pause% && goto menu
echo   PHPfpm�����������¼���...
echo.
taskkill /fi "SERVICES eq %cgi_vc%" /f /t >nul 2>nul
taskkill /im php-cgi.exe /f /t>nul 2>nul
%net% start %cgi_vc% >nul 2>nul
echo   PHPfpm���ü�����ϣ�
echo.
goto :eof

:sa_updaemon
echo.
echo   Nginx�ػ�������������...
%CD%\%guard_dir%\winsw.exe install >nul 2>nul
%net% start %updaemon_vc% >nul 2>nul
tasklist|findstr /i updaemon.exe >nul 2>nul && goto start_U_OK || goto start_U_ERROR
:start_U_ERROR
echo.
echo   Nginx�ػ�����δ��������
echo   ����.NET2.0/3.5�Ƿ�װ�򱻷���������á�
echo.
goto :eof
:start_U_OK
echo   Nginx�ػ����������ɹ�!
echo.
goto :eof

:sd_updaemon
tasklist|findstr /i updaemon.exe >nul 2>nul && goto stop_U_OK || goto stop_U_NO
:stop_U_OK
echo.
echo   Nginx�ػ���������ֹͣ...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
echo   # ȱ�� %taskkill%, �޷�����. & %pause% & goto menu
)
%taskkill% /fi "SERVICES eq %updaemon_vc%" /f /t >nul 2>nul
%taskkill% /im updaemon.exe /f /t>nul 2>nul
%CD%\%guard_dir%\winsw.exe uninstall >nul 2>nul
echo   Nginx�ػ������Ѿ�ֹͣ!
goto :eof
:stop_U_NO
goto :eof

:start_MySQL
echo   ���ݿ������������...
%CD%\%database_dir%\bin\%database_exe% --install %database_vc% --defaults-file="%CD%\%database_dir%\my.ini" >nul 2>nul
%net% start %database_vc% >nul 2>nul
tasklist|findstr /i mysqld.exe >nul 2>nul && goto start_M_OK || goto start_M_ERROR
:start_M_ERROR
echo.
echo   �������ݿ�ʧ�ܣ����ܵ�ԭ�����£�
echo   1��%database_port%�˿ڱ�ռ��   2��ʣ���ڴ治��200MB
echo   3��my.ini���ó���   4�����ݱ�ȱʧ�����
echo   ���������鿴���ݿ�dataĿ¼%COMPUTERNAME%.err�ļ�[error]��Ŀ
echo.
%pause%
goto menu
:start_M_OK
echo   ���ݿ���������ɹ�!
echo.
goto :eof

:stop_MySQL
echo.
echo   ���ݿ��������ֹͣ...
%net% stop %database_vc% >nul 2>nul
%CD%\%database_dir%\bin\%database_exe% --remove %database_vc% >nul 2>nul
echo   ���ݿ�����Ѿ�ֹͣ!
goto :eof

:start_redis
echo   Redis������������...
%CD%\%redis_dir%\redis-server.exe --service-install %CD%\%redis_conf% --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-start --service-name %redis_vc% >nul 2>nul
tasklist|findstr /i redis-server.exe >nul 2>nul && goto start_C_OK || goto start_C_ERROR
:start_C_ERROR
echo.
echo   Redis����δ��������
echo   ����%redis_port%�˿�ռ�û򱻷��������ֹ��
goto :eof
:start_C_OK
echo   Redis���������ɹ�!
goto :eof

:stop_redis
echo.
echo   Redis��������ֹͣ...
%CD%\%redis_dir%\redis-server.exe --service-stop --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-uninstall --service-name %redis_vc% >nul 2>nul
echo   Redis�����Ѿ�ֹͣ!
goto :eof

:restart_redis
echo.
echo   Redis������������...
%CD%\%redis_dir%\redis-server.exe --service-stop --service-name %redis_vc% >nul 2>nul
%CD%\%redis_dir%\redis-server.exe --service-start --service-name %redis_vc% >nul 2>nul
echo   Redis�����Ѿ�����!
goto :eof

:start_upupw
echo.
echo   ����һ������UPUPWȫ������...
call :start_Nginx
call :start_MySQL
call :start_redis
echo.
%pause%
goto menu

:stop_upupw
echo.
echo   ����һ��ֹͣUPUPWȫ������...
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
echo   # δ�ҵ� %1 !
%pause%
goto :eof

:menu
mode con cols=80 lines=29 >nul 2>nul
cls
echo.
echo     �X�T�T�T�T�T�T�T�T UPUPW NGINX�� PHP7.0ϵ����ʽ��1512.1 �T�T�T�T�T�T�T�[
echo     �U                                                                    �U
echo     �U                                                                    �U
echo     �U            1 - ��� ��������        5 - ��� ������������          �U
echo     �U            2 - ɾ�� ��������        6 - ɾ�� ������������          �U
echo     �U            3 - �޸� ��������        7 - ���� ���ݿ�����            �U
echo     �U            4 - ��� �˿�״̬        8 - ���� ���ݿ�������          �U
echo     �U                                                                    �U
echo     �U           09 - ���� ����˿�       14 - ���� MySQL/MariaDB         �U
echo     �U           10 - ���� Nginx����      15 - ���� PHP�������           �U
echo     �U           11 - ��� ������������   16 - ���� ��ȫ��������          �U
echo     �U           12 - ���� ���ݻ�ԭ     17 - ���� ��������              �U
echo     �U           13 - FTP����˹���       18 - ������������ѡ��           �U
echo     �U           up - ����°汾          qa - ����֧���뽻��             �U
echo     �U                                                                    �U
echo     �U           s1 - ����ȫ������        s5 - �ر�ȫ������               �U
echo     �U           s2 - ����Nginx����       s6 - �ر�Nginx����              �U
echo     �U           s3 - �������ݿ����      s7 - �ر����ݿ����             �U
echo     �U           s4 - ����Redis����       s8 - �ر�Redis����              �U
echo     �U           rr - ����Nginx����       kk - ǿ��ж�ط������           �U
echo     �U           ex - ���Ʒ�����չ����    uc - �߼�����������           �U
echo     �U                                                                    �U
echo     �^�T�T�T�T�T�T�T�T�T �κ�λ������ q  ���������� �T�T�T�T�T�T�T�T�T�T�T�a
echo.
set input=
set /p input=-^>��ѡ��:
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
echo   p1 - ���� Nginx�˿�       p2 - ���� ���ݿ�˿�
echo.
set input=
set /p input=-^>��ѡ��:
cls
echo.
if /i "%input%"=="p1" goto nginx_port
if /i "%input%"=="p2" goto mysql_port
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto port

:nginx_port
echo   ��Nginx�˿��޸�Ϊ��80�˿�ʱ��Ҫ��HTTP://����:�˿ڵ���ʽ���ʣ�
echo.
set nport=
set /p nport=-^>�����µ�Nginx�˿�(1-65535) ĿǰΪ%nginx_port%:
if /i "%nport%"=="" goto menu
if /i "%nport%"=="q" goto menu
%php% "$p = env('nport'); if ($p !== ''.ceil($p) || 1 > $p || $p > 65535) exit(1);" || goto nginx_port
%php% "nginx_port(env('nport'));" || %pause% && goto menu
set nginx_port=%nport%
if "%1"=="noRestart" goto end
call :restart_Nginx
echo.
echo   Nginx���޸�Ϊ %nport% �˿ڣ�
echo.
%pause%
goto menu

:mysql_port
echo   �����ݿ�˿��޸�Ϊ��3306�˿�ʱִ��PHP����װ�����������޸ĺ�Ķ˿ںţ�
echo.
set nport=
set /p nport=-^>�����µ����ݿ�˿�(1-65535) ĿǰΪ%database_port%:
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
echo   ���ݿ����޸�Ϊ %nport% �˿ڣ�
echo.
%pause%
goto menu

:vhost_add
mode con cols=80 lines=45 >nul 2>nul
cls
echo   ���������б�:(���б���ʾ��ȫ��ֱ�Ӳ鿴���޸�Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   �����������������ͱ�ʶ. �� test.com �� blog.test.com
echo.
set hName=
set /p hName=-^>������һ��������:
if /i "%hName%"=="" goto vhost_add
if /i "%hName%"=="q" goto menu
echo.
echo   �󶨶��������������"�ո�"������test.com www.test.com *.test.com(֧�ַ�����)
echo.
set hAlias=
set /p hAlias=-^>��������(��ѡ):
if /i "%hAlias%"=="" goto vhost_add_htdocs
if /i "%hAlias%"=="q" goto menu
:vhost_add_htdocs
echo.
echo   ָ����վĿ¼(��X:\websites\site1). ������Ĭ�Ͻ����� upupw/vhosts/%hName%
echo.
set htdocs=
set /p htdocs=-^>��վĿ¼(��ѡ):
if /i "%htdocs%"=="q" goto menu
if /i "%htdocs%"=="" goto vhost_add_2
%php% "$d = rpl('/', '\\\\', $_ENV['htdocs']); if (is_dir($d)) exit(0); if (file_exists($d)) exit(1); if (!@mkdir($d, 0, 1)) exit(2);" || echo   ·������ȷ�򴴽�Ŀ¼ʧ��! && %pause% && goto vhost_add_htdocs
:vhost_add_2
echo.
echo   %hName%��������������ϣ�
%php% "vhost_add(env('hName'), env('htdocs'), env('nginx_port'), env('hAlias'), env('p'));" && call :restart_Nginx && call :restart_PHPfpm && goto vhost_add_3
:vhost_add_3
set /p sure=-^>ȫ�����!�Ƿ������鿴%hName%��Ĭ��ҳ��?(y/n)
if /i "%sure%"=="n" goto vhost_add
if /i "%sure%"=="y" goto vhost_add_4
if /i "%sure%"=="q" goto menu
:vhost_add_4
if exist %CD%\%nginx_dir%\logs\*.pid start http://%hName%:%nginx_port%
goto vhost_add

:vhost_del
mode con cols=80 lines=45 >nul 2>nul
echo   ���������б�:(���б���ʾ��ȫ��ֱ�Ӳ鿴���޸�Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   Ҫɾ����������, ��������Ż�������.
echo.
set hName=
set /p hName=-^>��ѡ��Ҫɾ������������:
if /i "%hName%"=="" goto menu
if /i "%hName%"=="q" goto menu
%php% "vhost_del(env('hName'));" && call :restart_Nginx
echo.
%pause%
goto vhost_del

:vProxy_add
mode con cols=80 lines=45 >nul 2>nul
echo   ���һ����������������������ַ�򺬶˿ںŵ�IP��ַ
echo.
echo   ���е����������б�
%php% "showvhs();" || %pause% && goto menu
:vProxy_add_hN
echo.
echo   ����µ�������. �� test.com �� blog.test.com
echo.
set hName=
set /p hName=-^>������һ��������:
if /i "%hName%"=="" goto vProxy_add
if /i "%hName%"=="q" goto menu
%php% "if (regrpl('[\w\d\.\-]+', '', env('hName'))) exit(1);" && goto vProxy_add_hA
echo   ������ֻ���� "a-z0-9.-" ���!
%pause% && goto vProxy_add_hN
:vProxy_add_hA
echo.
echo   �󶨶�������. �� www.test.com �� *.test.com(������); ������ÿո����
echo.
set hAlias=
set /p hAlias=-^>��������(��ѡ):
if /i "%hAlias%"=="" goto vProxy_add_hP
if /i "%hAlias%"=="q" goto menu
%php% "if (regrpl('[\w\d\.\- *]+', '', env('hAlias'))) exit(1);" && goto vProxy_add_hP
echo   ��������ֻ���� "a-z0-9.-* " ���!
%pause% && goto proxy_add_hA
:vProxy_add_hP
echo.
echo   ����Ŀ��. �� test.com:8080, 192.168.1.3:81 �� www.example.com
echo.
set hPass=
set /p hPass=-^>����Ŀ��:
if /i "%hPass%"=="" goto vProxy_add_hP
if /i "%hPass%"=="q" goto menu
%php% "if (regrpl('[a-z0-9\.\-_:\/]+', '', env('hPass'))) exit(1);" && goto vProxy_add_go
echo   Ŀ���ַֻ���� "a-z0-9.-_:/" ���!
%pause% && goto vProxy_add_hP
:vProxy_add_go
%php% "vProxy_add(env('hName'), env('hAlias'), env('hPass'));"
call :restart_Nginx
echo.
echo   %hName%�����������������ϣ�
echo.
%pause%
goto vProxy_add

:vProxy_dis
echo   ������ɾ�����д���������¼!
echo.
set /p sure=-^>ȷ��? (y/n)
if /i "%sure%"=="n" goto menu
if /i "%sure%"=="y" goto un_proxy_1
if /i "%sure%"=="q" goto menu
:un_proxy_1
%php% "vProxy_dis();" || %pause% && goto menu
call :restart_Nginx
echo.
echo   ������������ɾ����ϣ�
echo.
%pause%
goto menu

:vhost_mod
mode con cols=80 lines=45 >nul 2>nul
echo   ���������б�:(���б���ʾ��ȫ��ֱ�Ӳ鿴���޸�Nginx\conf\vhosts.conf)
%php% "showvhs();" || %pause% && goto menu
echo.
echo   Ҫ�޸���������, ��������Ż�������.
echo.
set hName=
set /p hName=-^>��ѡ��Ҫ�޸ĵ���������:
if /i "%hName%"=="" goto menu
if /i "%hName%"=="q" goto menu
%php% "vhost_mod(env('hName'), env('hAlias'));" || %pause% && goto menu
echo.
echo   �������µĶ�������, ԭ�����ݽ�������! ��������Կո���������ղ����޸�.
echo.
set hAlias=
set /p hAlias=-^>������Ҫ�󶨵�����:
if /i "%hAlias%"=="q" goto menu
%php% "vhost_mod(env('hName'), env('hAlias'));" || %pause% && goto menu
call :restart_Nginx
echo.
echo   %hName%���������޸���ϣ�
echo.
%pause%
goto vhost_mod

:nginx_package
cls
echo.
echo     ========= Nginx����ģ�鿪��״̬���� ����ģ��Ĭ����ȫ��[����] ==========
echo.
echo            k1 - ���� Gzip��ҳѹ������    g1 - �ر� Gzip��ҳѹ������
echo            k2 - ���� keepalive������     g2 - �ر� keepalive������
echo.
echo     ========= Nginx����ģ�鿪��״̬���� ����ģ��Ĭ����ȫ��[�ر�] ==========
echo.
echo            k3 - ���� Nginx��־����       g3 - �ر� Nginx��־����
echo            k4 - ���� Expiresҳ�滺��     g4 - �ر� Expiresҳ�滺��
echo.
echo     ======================== ����SS �鿴Nginx״̬ =========================
echo.
set /p input=-^>��ѡ��:
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
echo   ���������뷵�أ�
echo.
%pause%
goto nginx_package

:k_Gzip
%php% "frpl($nginx_conf, '(gzip)[ \t].*;.*(\r\n)', '$1  on;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Gzip��ҳѹ������ģ�鿪���ɹ���
echo.
%pause%
goto nginx_package
:g_Gzip
%php% "frpl($nginx_conf, '(gzip)[ \t].*;.*(\r\n)', '$1  off;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Gzip��ҳѹ������ģ��رճɹ���
echo.
%pause%
goto nginx_package

:k_alive
%php% "frpl($nginx_conf, '(keepalive_timeout).*;.*(\r\n)', '$1   5;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx keepalive�����ӿ����ɹ���
echo.
%pause%
goto nginx_package
:g_alive
%php% "frpl($nginx_conf, '(keepalive_timeout).*;.*(\r\n)', '$1   0;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx keepalive�����ӹرճɹ���
echo.
%pause%
goto nginx_package

:k_logs
%php% "frpl($nginx_conf, '(access_log).*;.*(\r\n)', '$1  logs/$server_name.log main;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx��־���濪���ɹ���
echo.
%pause%
goto nginx_package
:g_logs
%php% "frpl($nginx_conf, '(access_log).*;.*(\r\n)', '$1  off;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginx��־����رճɹ���
echo.
%pause%
goto nginx_package

:k_Expires
%php% "frpl($vhosts_conf, '^.*[#]*(include).*expires.*(\r\n)', '		$1 expires.conf;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Expiresҳ�滺��ģ�鿪���ɹ���
echo.
%pause%
goto nginx_package
:g_Expires
%php% "frpl($vhosts_conf, '^.*(include.*expires.*\r\n)', '		#$1');" || %pause% && goto menu
call :restart_Nginx
echo   Expiresҳ�滺��ģ��رճɹ���
echo.
%pause%
goto nginx_package

:nginx_status
start http://127.0.0.1:%nginx_port%/status
goto menu

:php_package
cls
echo.
echo     ============= PHP�����������״̬һ �������Ĭ����[����] ===============
echo.
echo          k1   - ���� Opcache���ٻ���        g1  - �ر� Opcache���ٻ���
echo          k2   - ���� Redis���ݻ���          g2  - �ر� Redis���ݻ���
echo          k3   - ���� exif                   g3  - �ر� exif
echo          k4   - ���� openssl                g4  - �ر� openssl
echo.
echo     ============= PHP�����������״̬һ �������Ĭ����[�ر�] ===============
echo.
echo          k5   - ���� Xdebug                 g5  - �ر� Xdebug
echo.
echo     ========================================================================
echo.
echo   �˹�����s1����ȫ��������ٲ��������Ĺ��������������������裡
echo.
set /p input=-^>��ѡ��:
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
echo   ���������뷵�أ�
echo.
%pause%
goto php_package

:k_Opcache
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*opcache.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_opcache.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Opcache������������ɹ���
echo.
%pause%
goto php_package
:g_Opcache
%php% "frpl($php_ini, '^(zend_extension.*=.*opcache.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   Opcache��������رճɹ���
echo.
%pause%
goto php_package

:k_redis
%php% "frpl($php_ini, '^[;]*(extension=).*redis.*(\r\n)', '$1php_redis.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Redis��������ɹ���
echo.
%pause%
goto php_package
:g_redis
%php% "frpl($php_ini, '^(extension=.*redis.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   Redis����رճɹ���
echo.
%pause%
goto php_package

:k_exif
%php% "frpl($php_ini, '^[;]*(extension=).*exif.*(\r\n)', '$1php_exif.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   exif��������ɹ���
echo.
%pause%
goto php_package
:g_exif
%php% "frpl($php_ini, '^(extension=.*exif.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   exif����رճɹ���
echo.
%pause%
goto php_package

:k_openssl
%php% "frpl($php_ini, '^[;]*(extension=).*openssl.*(\r\n)', '$1php_openssl.dll$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   openssl��������ɹ���
echo.
%pause%
goto php_package
:g_openssl
%php% "frpl($php_ini, '^(extension=.*openssl.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   openssl����رճɹ���
echo.
%pause%
goto php_package

:k_xdebug
%php% "frpl($php_ini, '^(zend_extension.*=.*opcache.*\r\n)', ';$1');" || %pause% && goto menu
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*xdebug.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_xdebug.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Xdebug��������ɹ���
echo.
%pause%
goto php_package
:g_xdebug
%php% "frpl($php_ini, '^(zend_extension.*=.*xdebug.*\r\n)', ';$1');" || %pause% && goto menu
%php% "frpl($php_ini, '^[;]*(zend_extension.*=).*opcache.*(\r\n)', '$1`X:\upupw\PHP7\ext\php_opcache.dll`$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Xdebug����رճɹ���
echo.
%pause%
goto php_package

:safe_pz
cls
echo.
echo     ===================== UPUPW��ȫ������������ѡ�� ========================
echo    ^|                                                                        ^|
echo    ^|    k1 - ���� ע�빥������         g1 -(Ĭ��) �ر� ע�빥������         ^|
echo    ^|    k2 - ���� ����վĿ¼����       g2 -(Ĭ��) �ر� ����վĿ¼����       ^|
echo    ^|    k3 - ���� Nginxͷ����Ϣ        g3 -(Ĭ��) ��ʾ Nginxͷ����Ϣ        ^|
echo    ^|    k4 - ���� PHPͷ����Ϣ          g4 -(Ĭ��) ��ʾ PHPͷ����Ϣ          ^|
echo    ^|    k5 - ���� δ����������       g5 -(Ĭ��) ���� ������������         ^|
echo    ^|    k6 - ���� PHP����ȫ����ִ��    g6 -(Ĭ��) ���� PHP���п�ִ�к���    ^|
echo    ^|    k7 - ���� ��������phpmyadmin   g7 -(Ĭ��) ���� ��������phpmyadmin   ^|
echo    ^|                                                                        ^|
echo     ===================== UPUPW�����ػ���������ѡ�� ========================
echo    ^|                                                                        ^|
echo    ^|       d1 - ���� ���ʱ����        d2 - ���� ����Ŀ����ַ             ^|
echo    ^|       sa - ���� K�ػ�����           sd - �ر� K�ػ�����                ^|
echo    ^|                                                                        ^|
echo     ========================================================================
echo.
echo   ��ȫ����������s1����ȫ��������ٲ��������Ĺ��������������������裡
echo.
set input=
set /p input=-^>��ѡ��:
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
echo   ע�빥�����������ɹ���
echo.
%pause%
goto safe_pz
:g_zhuru
%php% "frpl($php_ini, '^(auto_prepend_file.*=.*protect.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   ע�빥�������رճɹ���
echo.
%pause%
goto safe_pz

:k_cross
%php% "frpl($php_ini, '^.*[;](user_ini.filename.*uini.*\r\n)', '$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   ����վĿ¼���ƿ����ɹ���
echo.
%pause%
goto safe_pz
:g_cross
%php% "frpl($php_ini, '^.*(user_ini.filename.*uini.*\r\n)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   ����վĿ¼���ƹرճɹ���
echo.
%pause%
goto safe_pz

:k_nheader
%php% "frpl($nginx_conf, '(server_tokens)[ \t].*;.*(\r\n)', '$1  off;$2');"  || %pause% && goto menu
call :restart_Nginx
echo   Nginxͷ����Ϣ�ɹ����أ�
echo.
%pause%
goto safe_pz
:g_nheader
%php% "frpl($nginx_conf, '(server_tokens)[ \t].*;.*(\r\n)', '$1  on;$2');" || %pause% && goto menu
call :restart_Nginx
echo   Nginxͷ����Ϣ�ɹ���ʾ��
echo.
%pause%
goto safe_pz

:k_pheader
%php% "frpl($php_ini, '(expose_php.*=).*O.*(\r\n)', '$1Off$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   PHPͷ����Ϣ�ɹ����أ�
echo.
%pause%
goto safe_pz
:g_pheader
%php% "frpl($php_ini, '(expose_php.*=).*O.*(\r\n)', '$1On$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   PHPͷ����Ϣ�ɹ���ʾ��
echo.
%pause%
goto safe_pz

:k_saferesolve
%php% "frpl($nginx_conf, '^.*[#]*(include )saferesolve.conf;(\r\n)', '$1saferesolve.conf;$2');" || %pause% && goto menu
call :restart_Nginx
echo   �ѳɹ�����δ����������Ĭ��������
echo.
%pause%
goto safe_pz
:g_saferesolve
%php% "frpl($nginx_conf, '^(include saferesolve.conf;\r\n)', '#$1');" || %pause% && goto menu
call :restart_Nginx
echo   �ѿ������н�����������������Ĭ��������
echo.
%pause%
goto safe_pz

:k_hanshu
%php% "frpl($php_ini, '^.*[;](disable_functions.*=)', '$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   �ѽ���PHP����ȫ����ִ�У�
echo.
%pause%
goto safe_pz
:g_hanshu
%php% "frpl($php_ini, '^.*(disable_functions.*=)', ';$1');" || %pause% && goto menu
call :restart_PHPfpm
echo   ������PHP���п�ִ�к�����
echo.
%pause%
goto safe_pz

:k_phpmyadmin
if not exist %CD%\phpmyadmin\up-pmd.conf (
copy /y %CD%\upcore\up-pmd.c %CD%\phpmyadmin\up-pmd.conf >nul 2>nul
)
call :restart_Nginx
echo   �ѽ�����������phpmyadmin��
echo.
%pause%
goto safe_pz
:g_phpmyadmin
if exist %CD%\phpmyadmin\up-pmd.conf (
del /f/s/q %CD%\phpmyadmin\up-pmd.conf /q>nul 2>nul
)
call :restart_Nginx
echo   ��������������phpmyadmin��
echo.
%pause%
goto safe_pz

:upd_d1
cls
call %CD%\upcore\upd_config.cmd
echo.
echo   �����ػ����̼��͵ȴ����,����ʱ��ΪĿǰ���õ�%upd_timeout%X2��
echo.
set timeout=
set /p timeout=-^>������:
if /i "%timeout%"=="" goto upd_d1
if /i "%timeout%"=="q" goto safe_pz
%php% "frpl($upd_conf, '(set upd_timeout=).*[^\r\n]', 'set upd_timeout=%timeout%');" || %pause% && goto menu
call :sd_updaemon
call :sa_updaemon
echo   �ػ����̼��͵ȴ�����Ѹ���Ϊ%timeout%X2�룡
echo.
%pause%
goto safe_pz
:upd_d2
cls
call %CD%\upcore\upd_config.cmd
echo.
echo   �����ػ����̼��Ŀ��,��ǰΪ%upd_url%
echo.
set url=
set /p url=-^>������������վ��ַ: http://
if /i "%url%"=="" goto upd_d2
if /i "%url%"=="q" goto safe_pz
%php% "frpl($upd_conf, '(set upd_url=).*[^\r\n]', 'set upd_url=http://%url%');" || %pause% && goto menu
call :sd_updaemon
call :sa_updaemon
echo   �ػ����̼��Ŀ���Ѹ���Ϊ%url%
echo.
%pause%
goto safe_pz

:reset_mydpwd
cls
echo.
echo   [ e1 ] ǿ���޸�root����     [ e2 ] �޸������û�����
echo.
set input=
set /p input=-^>��ѡ�����蹦��:
if /i "%input%"=="e1"  goto reset_1
if /i "%input%"=="e2"  goto reset_2
if /i "%input%"==""    goto reset_mydpwd
if /i "%input%"=="q"   goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto reset_mydpwd
:reset_1
echo.
set rootps=
set /p rootps=-^>��������root����:
if /i "%rootps%"=="" goto reset_mydpwd
if /i "%rootps%"=="q" goto menu
echo.
echo   ���Ժ�......
echo.
call :stop_MySQL >nul 2>nul
start %CD%\upcore\rootps.cmd >nul 2>nul
%CD%\%database_dir%\bin\mysql.exe -uroot -e "update mysql.user set Password=password('%rootps%') where User='root';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -uroot -e "flush privileges;" 2>nul
taskkill /im mysqld.exe /f /t >nul 2>nul
call :start_MySQL >nul 2>nul
echo   root�û��������޸���ɣ�
echo.
%pause%
goto menu
:reset_2
echo.
echo   ���ݿ�Ĭ�ϸ߼�����Աroot,����root,�緢���쳣����phpmyadmin�ȹ����޸ģ�
echo.
echo   �˴����޸����ݿ������û��������룬��ȷ�����ݿ�����ѿ����ٽ������²�����
echo.
set uname=
set /p uname=-^>���ݿ��û���:
if /i "%uname%"=="" goto reset_mydpwd
if /i "%uname%"=="q" goto menu
echo.
goto pwd
:pwd
set pwd=
set /p pwd=-^>ԭ%uname%����:
if /i "%pwd%"=="" goto reset_mydpwd
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto pwdadmin
if %errorlevel%==1045 (
echo.
echo   ���벻��ȷ, ����������.
echo.
goto pwd
)
if %errorlevel%==2002 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
:pwdadmin
echo.
set newpwd=
set /p newpwd=-^>��%uname%����:
if /i "%newpwd%"=="" goto reset_mydpwd
if /i "%newpwd%"=="q" goto menu
echo.
%CD%\%database_dir%\bin\mysqladmin.exe -u"%uname%" -p"%pwd%" password "%newpwd%" >nul 2>nul
echo   %uname%�û��������޸���ɣ�
echo.
%pause%
goto menu

:myd_upgrade
cls
echo.
mode con cols=80 lines=45 >nul 2>nul
echo   �˹����������ݿ�汾�����仯ʱ�������ݿ�dataĿ¼�����Ե���ǰ�汾.
echo.
set uname=
set /p uname=-^>���ݿⳬ������Ա�û���:
if /i "%uname%"=="" goto myd_upgrade
if /i "%uname%"=="q" goto menu
echo.
goto pwd_upgrade
:pwd_upgrade
set pwd=
set /p pwd=-^>%uname%����:
if /i "%pwd%"=="" goto myd_upgrade
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto myd_upgrade_exe
if %errorlevel%==1045 (
echo.
echo   ���벻��ȷ, ����������.
echo.
goto pwd_upgrade
)
if %errorlevel%==2002 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
:myd_upgrade_exe
cls
%CD%\%database_dir%\bin\mysql_upgrade.exe --user="%uname%" --password="%pwd%" --force 2>nul
echo   �븴�������ִ�н��, mysql.���ݱ�ȫ��OK�������ɹ�!
echo.
%pause%
goto menu

:m_database
cls
echo.
set uname=
set /p uname=-^>���ݿⳬ������Ա�û���:
if /i "%uname%"=="" goto m_database
if /i "%uname%"=="q" goto menu
echo.
goto pwd_m
:pwd_m
set pwd=
set /p pwd=-^>%uname%����:
if /i "%pwd%"=="" goto m_database
if /i "%pwd%"=="q" goto menu
%php% "chk_mysql('%database_port%', env('uname'), env('pwd'));" && goto m_database_lie
if %errorlevel%==1045 (
echo.
echo   ���벻��ȷ, ����������.
echo.
goto pwd_m
)
if %errorlevel%==2002 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
if %errorlevel%==2003 (
echo.
echo   �����������ݿ�ʧ��,��ȷ�����ݿ���������.
echo.
%pause% & goto menu
)
:m_database_lie
mode con cols=80 lines=29 >nul 2>nul
cls
set Ymd=%date:~,4%%date:~5,2%%date:~8,2%
echo.
echo   �˴�ΪUPUPW����Ŀ¼���ݿ�ִ�����,���뵼������ɿ��ٴ�����G��С������.
echo.
echo   [ m1 ]��� ���ݿ��б�
echo   [ m2 ]���� ���ݿ�
echo   [ m3 ]ɾ�� ���ݿ�
echo.
echo   [ m4 ]��� �û��б�
echo   [ m5 ]���� �û�
echo   [ m6 ]ɾ�� �û�
echo.
echo   [ m7 ]���� �������ݿ�
echo   [ m8 ]���� �������ݿ�
echo.
echo   [ m9 ]���� ȫ�����ݿ�
echo   [ m10]���� ȫ�����ݿ�
echo.
set input=
set /p input=-^>��ѡ�����蹦��:
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
echo   ���������뷵�أ�
echo.
%pause%
goto m_database_lie
:mdata_1
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo.
%pause%
goto m_database_lie
:mdata_2
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>������Ҫ���������ݿ���:
if /i "%db_name%"==""    goto mdata_2
if /i "%db_name%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Create database %db_name%;" 2>nul
echo.
echo   ���ݿ�%db_name%�Ѵ������!
echo.
%pause%
goto mdata_2
:mdata_3
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>������Ҫɾ�������ݿ���:
if /i "%db_name%"=="information_schema"   echo.&echo   �ڲ�����ⲻ��ɾ��&echo.&%pause%&goto mdata_3
if /i "%db_name%"=="mysql"                echo.&echo   �ڲ�����ⲻ��ɾ��&echo.&%pause%&goto mdata_3
if /i "%db_name%"=="performance_schema"   echo.&echo   �ڲ�����ⲻ��ɾ��&echo.&%pause%&goto mdata_3
if /i "%db_name%"==""    goto mdata_3
if /i "%db_name%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Drop database %db_name%;" 2>nul
echo.
echo   ���ݿ�%db_name%��ɾ�����!
echo.
%pause%
goto mdata_3
:mdata_4
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �û���  ��������ַ  MD5����
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
%pause%
goto m_database_lie
:mdata_5
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �û���  ��������ַ  MD5����
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
set user_name=
set /p user_name=-^>������Ҫ�������û���:
if /i "%user_name%"==""    goto mdata_5
if /i "%user_name%"=="q"   goto m_database_lie
echo.
set user_pw=
set /p user_pw=-^>������Ҫ�������û�����:
if /i "%user_pw%"==""    goto mdata_5
if /i "%user_pw%"=="q"   goto m_database_lie
echo.
set user_host=
set /p user_host=-^>������������������ַ(һ��Ϊlocalhost):
if /i "%user_host%"==""    goto mdata_5
if /i "%user_host%"=="q"   goto m_database_lie
echo.
set user_db=
set /p user_db=-^>������Ҫ��Ȩ�����ݿ���:
if /i "%user_db%"==""    goto mdata_5
if /i "%user_db%"=="q"   goto m_database_lie
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "insert into mysql.user(Host,User,Password) values('%user_host%','%user_name%',password('%user_pw%'));" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "grant all privileges on %user_db%.* to %user_name%@%user_host% identified by '%user_pw%';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
echo.
echo   �û�%user_name%�Ѵ������!
echo.
%pause%
goto mdata_5
:mdata_6
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �û���  ��������ַ  MD5����
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "select user,host,password from mysql.user;" 2>nul
echo.
set user_name=
set /p user_name=-^>������Ҫɾ�����û���:
if /i "%user_name%"=="%uname%" echo.&echo   ����ɾ�������ʻ�&echo.&%pause%&goto mdata_6
if /i "%user_name%"==""        goto mdata_6
if /i "%user_name%"=="q"       goto m_database_lie
echo.
set user_host=
set /p user_host=-^>������������������ַ(һ��Ϊlocalhost):
if /i "%user_host%"==""    goto mdata_6
if /i "%user_host%"=="q"   goto m_database_lie
echo.
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Drop user '%user_name%'@'%user_host%';" 2>nul
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "flush privileges;" 2>nul
echo.
echo   �û�%user_name%��ɾ�����!
echo.
%pause%
goto mdata_6
:mdata_7
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set db_name=
set /p db_name=-^>������Ҫ���������ݿ���:
if /i "%db_name%"==""    goto mdata_7
if /i "%db_name%"=="q"   goto m_database_lie
if not exist %CD%\Backup\Export\%Ymd% (
md %CD%\Backup\Export\%Ymd%
)
echo.
echo   ���ڵ���%db_name%���ݿ⣬����ʱ�������ݿ��С���������Ժ�...
%CD%\%database_dir%\bin\mysqldump.exe --single-transaction -u"%uname%" -p"%pwd%" --skip-lock-tables "%db_name%" > %CD%\Backup\Export\%Ymd%\%db_name%.sql 2>nul
echo.
echo   ���ݿ�%db_name%�ѵ�����%CD%\Backup\Export\%Ymd%\%db_name%.sql
echo.
set input=
set /p input=�Ƿ�Ҫ�����鿴����Ŀ¼? (y/n):
if /i not "%input%"=="y" goto mdata_7
explorer %CD%\Backup\Export\%Ymd%
goto mdata_7
:mdata_8
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo   ��ע��:���Ŀ�����ݿ������ݽ��ᱻ����
echo.
set db_name=
set /p db_name=-^>������Ҫ�����Ŀ�����ݿ���:
if /i "%db_name%"==""    goto mdata_8
if /i "%db_name%"=="q"   goto m_database_lie
echo.
echo   �뿽��SQL�ļ���%CD%\Backup\Import�ļ�����
echo.
set db_dir=
set /p db_dir=-^>���������SQL��׺���ļ�����:
if /i "%db_dir%"==""    goto mdata_8
if /i "%db_dir%"=="q"   goto m_database_lie
echo.
echo   ���ڵ���%db_dir%��%db_name%���ݿ⣬���Ժ�...
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" "%db_name%" < %CD%\Backup\Import\%db_dir% 2>nul
echo.
echo   %db_dir%�ѵ��뵽%db_name%���ݿ⣡
echo.
%pause%
goto mdata_8
:mdata_9
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
set input=
set /p input=�Ƿ�Ҫ������������ȫ�����ݿ�? (y/n):
if /i not "%input%"=="y" goto m_database_lie
if not exist %CD%\Backup\Export\All_database_%Ymd% (
md %CD%\Backup\Export\All_database_%Ymd%
)
echo.
echo   ���ڵ���ȫ�����ݿ⣬����ʱ�������ݿ��С���������Ժ�...
for /f "delims=" %%i in ('dir /b /ad "%CD%\%database_dir%\data"') do (
%CD%\%database_dir%\bin\mysqldump.exe --single-transaction -u"%uname%" -p"%pwd%" --skip-lock-tables %%i > %CD%\Backup\Export\All_database_%Ymd%\%%i.sql
) 2>nul
echo.
echo   ���ݿ���ȫ��������%CD%\Backup\Export\All_database_%Ymd%
echo.
set input=
set /p input=�Ƿ�Ҫ�����鿴����Ŀ¼? (y/n):
if /i not "%input%"=="y" goto mdata_9
if /i "%input%"=="q" goto m_database_lie
explorer %CD%\Backup\Export\All_database_%Ymd%
goto m_database_lie
:mdata_10
mode con cols=80 lines=45 >nul 2>nul
cls
echo   �ڲ������Ϊ[information_schema] [mysql] [performance_schema]
%CD%\%database_dir%\bin\mysqlshow.exe -u"%uname%" -p"%pwd%" 2>nul
echo   ��ע��:�����������ݽ��ᴴ��ͬ�����ݿ�,������ݿ��Ѵ��ڽ��ᱻ����
echo.
echo   �뿽������SQL���ݿ���ļ��е�%CD%\Backup\Import�ļ�����
echo.
set db_dir=
set /p db_dir=-^>���������SQL���ݵ��ļ�������:
if /i "%db_dir%"==""    goto mdata_10
if /i "%db_dir%"=="q"   goto m_database_lie
echo.
echo   ���ڵ���%db_dir%�ļ����а�����ȫ�����ݣ����Ժ�...
for /f "delims=" %%i in ('dir /b /l "%CD%\Backup\Import\%db_dir%"') do (
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" -e "Create database if not exists %%~ni;"
%CD%\%database_dir%\bin\mysql.exe -u"%uname%" -p"%pwd%" %%~ni < %CD%\Backup\Import\%db_dir%\%%~ni.sql
) 2>nul
echo.
echo   %db_dir%�ļ����а�����ȫ�������ѳɹ����룡
echo.
%pause%
goto mdata_10

:chk_port
cls
if not exist %Sys32%\tasklist.exe goto chk_port_1
if not exist %Sys32%\netstat.exe goto chk_port_2
echo   ��������%nginx_port%�˿ڱ�Nginxռ�ã�%database_port%�˿ڱ�MySQL/MariaDBռ��
echo   --------------------------------------------------------------------------
%php% "chk_port('%nginx_port%');"
if not errorlevel 1 echo   ָ���� Nginx �˿� %nginx_port% ��ʱδ��ռ��.
echo.
%php% "chk_port('%phpfpm_port%');"
if not errorlevel 1 echo   ָ���� PHPfpm �˿� %phpfpm_port% ��ʱδ��ռ��.
echo.
%php% "chk_port('%database_port%');"
if not errorlevel 1 echo   ָ���� ���ݿ� �˿� %database_port% ��ʱδ��ռ��.
echo.
%php% "chk_port('%redis_port%');"
if not errorlevel 1 echo   ָ���� Redis �˿� %redis_port% ��ʱδ��ռ��.
echo.
%php% "chk_port('%ftp_port%');"
if not errorlevel 1 echo   ָ���� FTP �˿� %ftp_port% ��ʱδ��ռ��.
echo   --------------------------------------------------------------------------
echo   �������80�˿ڱ�PID 4ռ�������IIS�˿ڻ�ֱ������k���ռ�ã�����q����������
echo.
set input=
set /p input=-^>
if /i "%input%"=="k" goto k_iis
if /i "%input%"=="" goto chk_port
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
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
echo   # ȱ�� %Sys32%\tasklist.exe, �޷�����. & %pause% & goto menu
:chk_port_2
echo   # ȱ�� %Sys32%\netstat.exe, �޷�����. & %pause% & goto menu

:force_stop
echo.
echo   �˹��ܿɽ���UPUPW�����ص�ȫ������ͽ���,�����ڴ����ֲ����ȫɾ��UPUPWǰ��׼��.
echo.
echo   �˲�������ɾ����������ֻ�������ͽ���,�Ƿ������(y/n)
echo.
set input=
set /p input=-^>��ѡ��:
echo.
if /i "%input%"=="y" goto force_stop_yes
if /i "%input%"=="n" goto force_stop_no
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto force_stop
:force_stop_no
goto menu
:force_stop_yes
echo   �������UPUPW�����ط���ͽ��̣����Ժ�... ...
set taskkill=%Sys32%\taskkill.exe
if not exist %taskkill% (
echo   # ȱ�� %taskkill%, �޷�����. & %pause% & goto menu
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
echo   UPUPW�����ط���ͽ���ȫ��������ϣ�
echo.
%pause%
goto menu

:cfg_bak
cls
echo.
echo   ���ݻ�ԭ���������ļ���
echo.
echo   Nginx������  :  %nginx_dir%\conf\nginx.conf
echo   ������������ :  %vhosts_conf%
echo   PHP����      :  %php_dir%\php.ini
echo   ���ݿ�����   :  %database_dir%\my.ini
echo.
echo   ���ݻ�ԭѡ�
echo.
echo   B - ��������    R - ��ԭ����    D - ɾ������
echo.
set input=
set /p input=-^>��ѡ��:
cls
echo.
if /i "%input%"=="B" goto cfg_bak_B
if /i "%input%"=="R" goto cfg_bak_R
if /i "%input%"=="D" goto cfg_bak_D
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto goto cfg_bak

:cfg_bak_B
set input=
set /p input= ��������:
if /i "%input%"=="" goto cfg_bak_B
if /i "%input%"=="q" goto cfg_bak
%php% "cfg_bak('backup '.env('input'));"
echo.
%pause%
goto cfg_bak

:cfg_bak_R
%php% "cfg_bak('show');" || %pause% && goto menu
echo.
echo   ��ԭ֮ǰ��ȷ���Ƿ���Ҫ���������ý��б���!
echo.
set n=
set /p n=-^>��ԭ���˱������:
if /i "%n%"=="" echo  δѡ��������������� �뷵�أ� && %pause% && goto cfg_bak
if /i "%n%"=="q" goto cfg_bak
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_bak_R
%php% "cfg_bak('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= �����ѻ�ԭ, ������������? (y/N):
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
set /p n=-^>ɾ������ŵı���:
if /i "%n%"=="" echo  δѡ��������������� �뷵�أ� && %pause% && goto cfg_bak
if /i "%n%"=="q" goto cfg_bak
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_bak_D
%php% "cfg_bak('delete '.env('n'));"
echo.
%pause%
goto cfg_bak

:Performance
cls
echo.
echo   x1 - ���� PHP����       x2 - ���� ���ݿ�����
echo.
set input=
set /p input=-^>��ѡ��:
cls
echo.
if /i "%input%"=="x1" goto php_engine
if /i "%input%"=="x2" goto cfg_xnsp
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto Performance

:cfg_xnsp
cls
echo.
echo   ע:���������ü���Խ��Խ����������������ݴ�Сѡ�����÷����ʵ��䷴��
echo.
echo   0�����ã�������-1/2�߳�  �ڴ�-512M  ���ݿ�-256M  �շ�����-100/5000PV
echo   1�����ã�������-2/8�߳�  �ڴ�-1/4G  ���ݿ�-1/2G  �շ�����-5000/50000PV
echo   2�����ã�������8/16�߳�  �ڴ�-4/8G  ���ݿ�-2/4G  �շ�����-50000/100000PV
echo   3�����ã�������16/64�߳� �ڴ�-8/64G ���ݿ�-4/16G �շ�����-100000/500000PV
echo.
%php% "cfg_xnsp('show');" || %pause% && goto menu
echo.
echo   �˹�����Ҫs1����ȫ��������ٽ��в�����
echo.
echo   ѡ��ǰ��ȷ���Ƿ���Ҫ���������ý��б���!
echo.
set n=
set /p n=-^>��ѡ��:
cls
echo.
if /i "%n%"=="" echo    δѡ��������������� �뷵�أ� && %pause% && goto cfg_xnsp
if /i "%n%"=="q" goto Performance
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_xnsp
%php% "cfg_xnsp('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= �����������������, ������������? (y/n):
if /i not "%input%"=="y" goto cfg_xnsp
call :stop_MySQL
echo.
call :start_MySQL
echo.
goto cfg_xnsp

:php_engine
cls
echo.
echo     ============== PHP���������������� �������������ѡ������ ==============
echo    ^|                                                                        ^|
echo    ^|               p1 -CPU 4�߳� -�ڴ� 2G����                               ^|
echo    ^|               p2 -CPU 8�߳� -�ڴ� 4G����                               ^|
echo    ^|               p3 -CPU16�߳� -�ڴ� 8G����                               ^|
echo    ^|               p4 -CPU32�߳� -�ڴ�16G����                               ^|
echo    ^|               pp -��ԭͨ��Ĭ������                                     ^|
echo    ^|               px -����php-cgi���̽���߷�����ʱ�����502����           ^|
echo    ^|                                                                        ^|
echo     ====С����վ�㽨�鱣��Ĭ�Ͻ�ʡ��Դ��������վ���������������ѡ������====
echo.
echo   �˹�����Ҫs1����ȫ��������ٽ��в�����
echo.
set /p input=-^>��ѡ��:
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
echo   δѡ��������������� �뷵�أ�
echo.
%pause%
goto php_engine

:p_1
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 12 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   4�߳�PHP������������ɹ���
echo.
%pause%
goto php_engine

:p_2
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 16 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   8�߳�PHP������������ɹ���
echo.
%pause%
goto php_engine

:p_3
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 24 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   16�߳�PHP������������ɹ���
echo.
%pause%
goto php_engine

:p_4
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 32 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   32�߳�PHP������������ɹ���
echo.
%pause%
goto php_engine

:p_p
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 8 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   Ĭ�����滹ԭ�ɹ���
echo.
%pause%
goto php_engine

:p_x
%php% "frpl($winsw_p, '(<startargument>).*-n.*(<\/startargument>)', '$1\"X:/upupw/PHP7/php-cgi.exe -c X:/upupw/PHP7/php.ini\" -n 20 -i 127.0.0.1 -p 9070$2');" || %pause% && goto menu
call :restart_PHPfpm
echo   �߷��������ֵ�502�����޸���ϣ���ˢ����ҳ�����ɣ�
echo.
%pause%
goto php_engine

:cfg_sckf
cls
echo.
echo   ��ѡ�������򿪷���������
echo.
%php% "cfg_sckf('show');" || %pause% && goto menu
echo.
echo   �˹�����Ҫs1����ȫ��������ٽ��в�����
echo.
echo   ѡ��ǰ��ȷ���Ƿ���Ҫ���������ý��б���!
echo.
set n=
set /p n=-^>��ѡ��:
cls
echo.
if /i "%n%"=="" echo    δѡ��������������� �뷵�أ� && %pause% && goto cfg_sckf
if /i "%n%"=="q" goto menu
%php% "$p = env('n'); if ($p !== ''.ceil($p) || 0 > $p) exit(1);" || goto cfg_sckf
%php% "cfg_sckf('restore '.env('n'));" || %pause% && goto menu
echo.
set input=
set /p input= ���û������趨, ������������? (y/n):
if /i not "%input%"=="y" goto cfg_sckf
if /i "%input%"=="q" goto menu
echo.
call :restart_PHPfpm
%pause%
goto cfg_sckf

:fz_ftp
cls
echo.
echo     ======================= FileZilla FTP ����˹��� =======================
echo    ^|                                                                        ^|
echo    ^|                  f1 - ���� FTP����                                     ^|
echo    ^|                  f2 - �ر� FTP����                                     ^|
echo    ^|                  f3 - �� FileZilla����̨                             ^|
echo    ^|                  f4 - ж�� FTPϵͳ����                                 ^|
echo    ^|                                                                        ^|
echo     =============== ������f1����FTP������ٴ�FileZilla����̨ =============
echo.
set input=
set /p input=-^>��ѡ��:
cls
echo.
if /i "%input%"=="f1" call :ftp_f1
if /i "%input%"=="f2" call :ftp_f2
if /i "%input%"=="f3" call :ftp_f3
if /i "%input%"=="f4" call :ftp_f4
if /i "%input%"=="q" goto menu
echo.
echo   ���������뷵�أ�
echo.
%pause%
goto fz_ftp

:ftp_f1
start %CD%\%fz_dir%\%fz_exe%
echo   FTP�������ɹ���
echo.
%pause%
goto fz_ftp

:ftp_f2
start %CD%\%fz_dir%\%fz_exe%
echo   FTP����رճɹ���
echo.
%pause%
goto fz_ftp

:ftp_f3
start %CD%\%fz_dir%\FileZilla_Server_Interface.exe
echo   FTP��ϵͳ�������ɹ���
echo.
%pause%
goto fz_ftp

:ftp_f4
%CD%\%fz_dir%\%fz_exe% /uninstall
echo   FTPϵͳ����ж�سɹ���
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