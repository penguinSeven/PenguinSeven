# 安装

## 入门指南

### 1. 全局安装 gulp：

    $ npm install --global gulp
### 2. 作为项目的开发依赖（devDependencies）安装：

    $ npm install --save-dev gulp
### 3. 在项目根目录下创建一个名为 gulpfile.js 的文件：

    var gulp = require('gulp');
    
    gulp.task('default', function() {
      // 将你的默认的任务代码放在这
    });
    
### 4. 运行 gulp：

    $ gulp