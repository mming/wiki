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
```
自动部署到github gitpages个人页面 {github用户名}.github.io
```
mkdocs gh-deploy --config-file ../{文件夹}/mkdocs.yml --remote-branch main
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