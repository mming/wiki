# 升级centos7环境中的git

centos 7 默认1.x版本的git，使用vscode remote时，经常提示git版本过低。

## 查看git版本

```
git --version

```

## 删除旧版本git

```
sudo yum remove git

sudo yum remove git-*
```

## 通过yum安装新版本

### 安装End Point 库

```
sudo yum install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm
```

### 安装git

```
sudo yum install git
```

```
$git --version
git version 2.38.1
```

## 其他记录
报错 Cannot find command ‘git‘ - do you have ‘git‘ installed and in your PATH?

https://stackoverflow.com/questions/28483253/importerror-no-module-named-git-after-reformatting-laptop

---
> 20221203