# telegram 机器人

## 申请机器人
通过 @BotFather 进行操作，自行查找操作教程
通过 @userinfobot 或者 @myid_bot 查找个人id （备用）

## 登录vps后通过bot发送信息

```python title='vi SSHLoginAlert.sh'
#!/bin/bash
#This script can send a alert when someone login into vps 
#date:2021-09-02
#name：SSHLoginAlert.sh
#author:FranzKafka

echo "This is a script for ssh login alert"
token=xxxxxxxxxxxxxxxxx
echo "my token is $token"
id=xxxxxx
echo "my id is $id"
message=$(hostname && TZ=UTC-8 date && who && w &&last -1 | awk  'BEGIN{ORS="\t"}{print $1,$15}')
echo "send message is $message,begin...."
curl -v "https://api.telegram.org/bot${token}/sendMessage?chat_id=${id}" --data-binary "&text=${message}"
echo "send alert end"
```
hostname ：主机名，也就是你服务器的名字

TZ=UTC-8 ：设定时区为北京时间

who ：当前登录者的信息，包含用户名与id

w：当前用户所使用的执行的命令信息

last：之前用户的登录信息

```python title='将该脚本移动到/etc/profile.d/这个文件夹下'
chmod 555 SSHLoginAlert.sh
cp SSHLoginAlert.sh /etc/profile.d/

```
此文件夹 /etc/profile.d/ 下的脚本会为系统的每一个用户设置环境信息。当用户登录时，该目录下的脚本会自动执行

## 其他

### 获取群聊id
> 网上找到的原文1

为了获得群聊ID，请执行以下操作：

将电报BOT添加到组中。

获取您的BOT的更新列表：

https://api.telegram.org/bot<YourBOTToken>/getUpdates
例如：

https://api.telegram.org/bot123456789:jbd78sadvbdy63d37gda37bd8/getUpdates
查找“聊天”对象：

{“ update_id”：8393，“ message”：{“ message_id”：3，“ from”：{“ id”：7474，“ first_name”：“ AAA”}，“聊天”：{“ id” :,“标题“：”“}，” date“：25497，” new_chat_participant“：{” id“：71，” first_name“：” NAME“，”用户名“：” YOUR_BOT_NAME“}}}

当您将BOT添加到组中时，这是响应的示例。

使用“聊天”对象的“ id”发送消息。

---

> 网上找到的原文2

假设机器人名称为my_bot。

1-将机器人添加到组中。
转到该组，单击组名，单击“添加成员”，在搜索框中搜索您的机器人，如下所示：@my_bot，选择您的机器人并单击“添加”。

2-向机器人发送虚拟消息。
您可以使用以下示例：（/my_id @my_bot
我尝试了一些消息，但并非所有消息都起作用。上面的示例很好用。也许消息应该以/开头）

3-转到以下网址： https://api.telegram.org/botXXX:YYYY/getUpdates
用您的机器人令牌替换XXX：YYYY

4-查找“聊天”：{“ id”：-zzzzzzzzzzzz，
-zzzzzzzzzzzz是您的聊天ID（带负号）。

5- 测试：您可以测试是否向卷曲的群组发送消息：

curl -X POST "https://api.telegram.org/botXXX:YYYY/sendMessage" -d "chat_id=-zzzzzzzzzz&text=my sample text"

如果您错过了第2步，那么您要查找的组将不会有任何更新。另外，如果有多个组，则可以在响应中查找组名（“ title”：“ group_name ”）。

### 通过终端往群聊或人发消息
``` python title='通过终端往群聊或人发消息'
curl -X POST "https://api.telegram.org/bot<YourBOTToken>" -d "chat_id=<个人id或群组id>&text=<YourMessage>"
```

参考：
> https://coderfan.net/how-to-use-telegram-bot-to-alarm-you-when-someone-login-into-your-vps.html
> https://qastack.cn/programming/32423837/telegram-bot-how-to-get-a-group-chat-id
