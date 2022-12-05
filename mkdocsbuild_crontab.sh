#!/bin/bash
#自动生成站点并放到nginx目录
#date:20221201
#name：SSHLoginAlert.sh
#author:FranzKafka

echo "begin build"

cd /home/mming/wiki && /home/mming/venvs/dev_env/bin/python -m mkdocs build

echo "cp files to nginx www"

cp -r /home/mming/wiki/site/* /home/mming/mywww

echo "gh-deploy 放到https://mming.github.io/wiki/ 项目，个人主页在与此项目平级的mming.github.io文件夹里面的脚本"
/home/mming/venvs/dev_env/bin/python -m mkdocs gh-deploy