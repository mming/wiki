#!/bin/bash
#自动生成站点并放到nginx目录
#date:20221201
#name：SSHLoginAlert.sh
#author:FranzKafka

echo "begin build"
#sed -i 's/<\/article>/<hr><span id="busuanzi_container_page_pv"><font size="3" color="grey">本文总阅读量<span id="busuanzi_value_page_pv"><\/span>次<\/font><\/span><br\/><\/article>/g' mkdocs-material/material/base.html


mkdocs build

echo "cp files to nginx www"

cp -r /home/mming/wiki/site/* /home/mming/mywww

echo "done! go go go"
