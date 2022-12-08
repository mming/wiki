# acme.sh使用
环境：centos7

## 安装acme
```
wget -qO- get.acme.sh | bash 
source ~/.bashrc
cd ~/.acme.sh/
```
### 设置时区
```
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
### 设置默认获取证书机构
```python title='设置默认证书分发机构为letsencrypt.org'
acme.sh --set-default-ca --server letsencrypt
```

## dns方式获取证书
//
参考网址 https://github.com/acmesh-official/acme.sh/wiki/dnsapi
Using the global API key
First you need to login to your Cloudflare account to get your API key. Each token generated is not stored on cloudflare account and will have expiry if not set correctly. You will get this in API keys section.
https://dash.cloudflare.com/profile 
//

### 测试令牌是否可行
测试此令牌
要确认您的令牌是否工作正常，请复制下面的 CURL 命令并将其粘贴到终端 Shell 中进行测试。
```
curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer 这里是你自己的值" \
     -H "Content-Type:application/json"
```
上面第一步创建的令牌，即为token
CF_Token="这里是你自己的值“

分别获取账户ID和区域ID
CF_Account_ID="这里是你自己的值"
CF_Zone_ID="这里是你自己的值"   //此项非必须

```python title='终端输入命令'
export CF_Token="这里是你自己的值"
export CF_Account_ID="这里是你自己的值"
export CF_Zone_ID="这里是你自己的值"
```

### 申请证书 （用ecc模式吧
```
acme.sh --issue -d 这里是你的域名 -d 这里是你的域名2 --dns dns_cf -k ec-256
```
> 关于定时任务：编辑当前用户的定时任务表: crontab -e
> 查看当前用户的定时任务: crontab -l

### 安装证书
/root/.acme.sh/acme.sh --installcert -d 这里是你的域名 -d 这里是你的域名 --fullchain-file /自定义路径/cert.crt --key-file /自定义路径/private.key --ecc

### 设置crontab将acme自动续期的证书安装到自定义的目录里
创建 renew.sh脚本，并使用crontab定时跑脚本
```python title='renew.sh'
/root/.acme.sh/acme.sh --installcert -d 这里是你的域名 -d 这里是你的域名 --fullchain-file /自定义路径/cert.crt --key-file /自定义路径/private.key --ecc
echo "Certificates Renewed"

chmod +r /自定义路径private.key
echo "Read Permission Granted for Private Key"

docker restart nginx
echo "nginx Restarted"
```

## docker安装
```python title='安装 Docker '
curl -fsSL https://get.docker.com | sh
or wget -qO- get.docker.com | bash
docker pull nginx

docker pull containrrr/watchtower
```
### 每天凌晨2:00轮询检查更新
```
docker run -d \
    --name watchtower \
    --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower -c \
    --schedule "0 0 2 * * *"
```

### 如果已经启动的项目，则使用update更新：
```
docker update --restart=always 【dockername】
```
---
## 附录
```手动更新证书：
acme.sh --renew -d example.com --force
```

```查看证书列表：
acme.sh --list
```

```停止renew
acme.sh --remove -d example.com
```

常见问题
-bash: acme.sh: command not found
我暂时只遇到了该问题，解决办法是使用 acme 的绝对地址或者在acme.sh前加./
/root/.acme.sh/acme.sh  --issue  -d example.com  --dns dns_cf  -d *.example.com    #方法1
./acme.sh  --issue  -d example.com  --dns dns_cf  -d *.example.com                 #方法2

## 附录2 firewall

```开启端口
[root@centos7 ~]# firewall-cmd --zone=public --add-port=80/tcp --permanent
```

```查询端口号80 是否开启：
[root@centos7 ~]# firewall-cmd --query-port=80/tcp
```

```重启防火墙：
[root@centos7 ~]# firewall-cmd --reload
```

```查询有哪些端口是开启的:
[root@centos7 ~]# firewall-cmd --list-port
```
命令含义：
--zone #作用域
--add-port=80/tcp #添加端口，格式为：端口/通讯协议
--permanent #永久生效，没有此参数重启后失效

```关闭firewall：
systemctl stop firewalld.service #停止firewall

systemctl disable firewalld.service #禁止firewall开机启动
```