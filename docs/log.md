# 折腾log

好记性不如烂笔头

# docker方式搭建nginx
```
curl -fsSL https://get.docker.com | sh
```
or 
```
wget -qO- get.docker.com | bash
```

# 将项目部署上线同步github gitpages
自动部署到github gitpages项目 {github用户名}.github.io/{项目名}
```
mkdocs gh-deploy
# 默认是部署到Project Pages
```
如果想部署到User Pages，需要{github用户名}.github.io也clone到本地，并在user page仓库的环境中执行下述命令
自动部署到github gitpages个人页面 {github用户名}.github.io
```text
mkdocs gh-deploy --config-file ../{project page的文件夹}/mkdocs.yml --remote-branch main
```

参考文件夹结构：
```text
my-project/
    mkdocs.yml
    docs/
orgname.github.io/
```

# .gitignore 文件

git 上传是忽略不想上传的文件

``` python title = '.gitignore放到git项目根目录'
/benchmarks/
/spell/
/.vault.vim
/.local.vimrc
/.stignore
/.stfolder
/.stversions
.vim
.DS_Store
site
```
!!! info
- <span id="busuanzi_container_page_pv">本文总阅读量<span id="busuanzi_value_page_pv"></span>次</span><br>
- <span id="busuanzi_container_site_uv">本站访客数<span id="busuanzi_value_site_uv"></span>人次</span>
