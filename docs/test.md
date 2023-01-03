# 2.1 TCP/IP 网络模型有哪几层？

问大家，为什么要有 TCP/IP 网络模型？

对于同一台设备上的进程间通信，有很多种方式，比如有管道、消息队列、共享内存、信号等方式，而对于不同设备上的进程间通信，就需要网络通信，而设备是多样性的，所以要兼容多种多样的设备，就协商出了一套**通用的网络协议**。

这个网络协议是分层的，每一层都有各自的作用和职责，接下来就根据「 TCP/IP 网络模型」分别对每一层进行介绍。

## 应用层

最上层的，也是我们能直接接触到的就是**应用层**（*Application Layer*），我们电脑或手机使用的应用软件都是在应用层实现。那么，当两个不同设备的应用需要通信的时候，应用就把应用数据传给下一层，也就是传输层。

所以，应用层只需要专注于为用户提供应用功能，比如 HTTP、FTP、Telnet、DNS、SMTP等。

应用层是不用去关心数据是如何传输的，就类似于，我们寄快递的时候，只需要把包裹交给快递员，由他负责运输快递，我们不需要关心快递是如何被运输的。

而且应用层是工作在操作系统中的用户态，传输层及以下则工作在内核态。


## 传输层

应用层的数据包会传给传输层，**传输层**（*Transport Layer*）是为应用层提供网络支持的。

![](network/img/https/应用层.png)


在传输层会有两个传输协议，分别是 TCP 和 UDP。

TCP 的全称叫传输控制协议（*Transmission Control Protocol*），大部分应用使用的正是 TCP 传输层协议，比如 HTTP 应用层协议。TCP 相比  UDP 多了很多特性，比如流量控制、超时重传、拥塞控制等，这些都是为了保证数据包能可靠地传输给对方。 

UDP 相对来说就很简单，简单到只负责发送数据包，不保证数据包是否能抵达对方，但它实时性相对更好，传输效率也高。当然，UDP 也可以实现可靠传输，把 TCP 的特性在应用层上实现就可以，不过要实现一个商用的可靠 UDP 传输协议，也不是一件简单的事情。


应用需要传输的数据可能会非常大，如果直接传输就不好控制，因此当传输层的数据包大小超过 MSS（TCP 最大报文段长度 maximum segment size ） ，就要将数据包分块，这样即使中途有一个分块丢失或损坏了，只需要重新发送这一个分块，而不用重新发送整个数据包。在 TCP 协议中，我们把每个分块称为一个 **TCP 段**（*TCP Segment*）。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost4@main/网络/https/TCP段.png)

当设备作为接收方时，传输层则要负责把数据包传给应用，但是一台设备上可能会有很多应用在接收或者传输数据，因此需要用一个编号将应用区分开来，这个编号就是**端口**。

比如 80 端口通常是 Web 服务器用的，22 端口通常是远程登录服务器用的。而对于浏览器（客户端）中的每个标签栏都是一个独立的进程，操作系统会为这些进程分配临时的端口号。

由于传输层的报文中会携带端口号，因此接收方可以识别出该报文是发送给哪个应用。


## 网络层


传输层可能大家刚接触的时候，会认为它负责将数据从一个设备传输到另一个设备，事实上它并不负责。

实际场景中的网络环节是错综复杂的，中间有各种各样的线路和分叉路口，如果一个设备的数据要传输给另一个设备，就需要在各种各样的路径和节点进行选择，而传输层的设计理念是简单、高效、专注，如果传输层还负责这一块功能就有点违背设计原则了。

也就是说，我们不希望传输层协议处理太多的事情，只需要服务好应用即可，让其作为应用间数据传输的媒介，帮助实现应用到应用的通信，而实际的传输功能就交给下一层，也就是**网络层**（*Internet Layer*）（？ IP layer）。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost4@main/网络/https/网络层.png)

网络层最常使用的是 IP 协议（*Internet Protocol*），IP 协议会将传输层的报文作为数据部分，再加上 IP 包头组装成 IP 报文，如果 IP 报文大小超过 MTU（Maximum Transmission Unit 以太网中一般为 1500 字节）就会**再次进行分片**，得到一个即将发送到网络的 IP 报文。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost/计算机网络/键入网址过程/12.jpg)


网络层负责将数据从一个设备传输到另一个设备，世界上那么多设备，又该如何找到对方呢？因此，网络层需要有区分设备的编号。

我们一般用 IP 地址给设备进行编号，对于 IPv4 协议， IP 地址共 32 位，分成了四段（比如，192.168.100.1），每段是 8 位。只有一个单纯的 IP 地址虽然做到了区分设备，但是寻址起来就特别麻烦，全世界那么多台设备，难道一个一个去匹配？这显然不科学。

因此，需要将 IP 地址分成两种意义：

- 一个是**网络号**，负责标识该 IP 地址是属于哪个「子网」的；
- 一个是**主机号**，负责标识同一「子网」下的不同主机；

怎么分的呢？这需要配合**子网掩码**才能算出 IP 地址 的网络号和主机号。

举个例子，比如 10.100.122.0/24，后面的`/24`表示就是 `255.255.255.0` 子网掩码，255.255.255.0 二进制是「11111111-11111111-11111111-00000000」，大家数数一共多少个1？不用数了，是 24 个1，为了简化子网掩码的表示，用/24代替255.255.255.0。

知道了子网掩码，该怎么计算出网络地址和主机地址呢？

将 10.100.122.2 和 255.255.255.0 进行**按位与运算**，就可以得到网络号，如下图：

![img](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C/IP/16.jpg)

将 255.255.255.0 取反后与IP地址进行进行**按位与运算**，就可以得到主机号。

大家可以去搜索下子网掩码计算器，自己改变下「掩码位」的数值，就能体会到子网掩码的作用了。

![子网掩码计算器](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost4/网络/子网掩码计算器.png)

那么在寻址的过程中，先匹配到相同的网络号（表示要找到同一个子网），才会去找对应的主机。

除了寻址能力， IP 协议还有另一个重要的能力就是**路由**。实际场景中，两台设备并不是用一条网线连接起来的，而是通过很多网关、路由器、交换机等众多网络设备连接起来的，那么就会形成很多条网络的路径，因此当数据包到达一个网络节点，就需要通过路由算法决定下一步走哪条路径。

路由器寻址工作中，就是要找到目标地址的子网，找到后进而把数据包转发给对应的网络内。

![IP地址的网络号](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C/IP/17.jpg)

所以，**IP 协议的寻址作用是告诉我们去往下一个目的地该朝哪个方向走，路由则是根据「下一个目的地」选择路径。寻址更像在导航，路由更像在操作方向盘**。


## 网络接口层

生成了 IP 头部之后，接下来要交给**网络接口层**（*Link Layer*）在 IP 头部的前面加上 MAC 头部，并封装成数据帧（Data frame）发送到网络上。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost4@main/网络/https/网络接口层.png)

IP 头部中的接收方 IP 地址表示网络包的目的地，通过这个地址我们就可以判断要将包发到哪里，但在以太网的世界中，这个思路是行不通的。

什么是以太网呢？电脑上的以太网接口，Wi-Fi 接口，以太网交换机、路由器上的千兆，万兆以太网口，还有网线，它们都是以太网的组成部分。以太网就是一种在「局域网」内，把附近的设备连接起来，使它们之间可以进行通讯的技术。

以太网在判断网络包目的地时和 IP 的方式不同，因此必须采用相匹配的方式才能在以太网中将包发往目的地，而 MAC 头部就是干这个用的，所以，在以太网进行通讯要用到 MAC 地址。

MAC 头部是以太网使用的头部，它包含了接收方和发送方的 MAC 地址等信息，我们可以通过 ARP 协议获取对方的 MAC 地址。

所以说，网络接口层主要为网络层提供「链路级别」传输的服务，负责在以太网、WiFi 这样的底层网络上发送原始数据包，工作在网卡这个层次，使用 MAC 地址来标识网络上的设备。

## 总结


综上所述，TCP/IP 网络通常是由上到下分成 4 层，分别是**应用层，传输层，网络层和网络接口层**。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost4@main/网络/tcpip参考模型.drawio.png)

再给大家贴一下每一层的封装格式：

![img](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost3@main/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F/%E6%B5%AE%E7%82%B9/%E5%B0%81%E8%A3%85.png)

网络接口层的传输单位是帧（frame），IP 层的传输单位是包（packet），TCP 层的传输单位是段（segment），HTTP 的传输单位则是消息或报文（message）。但这些名词并没有什么本质的区分，可以统称为数据包。

---
>TCP maximum segment size 是什麼以及是如何決定的
網路傳輸時需要一些標頭檔決定封包如何傳送，所以封包帶的資料愈大愈划算。以 TCP 為例，TCP 和 IP 標頭檔都是 20 bytes，用 40 bytes 的標頭檔只傳 1 byte 就很不划算。TCP 設定封包所帶的資料上限稱為 maximum segment size (MSS)，理論上我們希望它愈大愈好。

以下記錄和 MSS 相關的知識，懶得看的話只要記住一個結論: OS 都處理好了，沒事不要手癢亂改 MSS 的值。

Maximum Transmission Unit (MTU)
在討論 MSS 之前，先看 IP layer 的情況。router 之間傳輸封包大小的上限稱為 MTU。當 router 發現封包大小超出下一站 router 的上限時，它有兩個選擇:

拆成更小的封包送出。
回傳來源用更小的封包大小 (送出 ICMP “packet too big” 訊息)。
IPv4 有支援 1 & 2，但 1 會帶給 router 太多負擔 (memory & CPU)，可能會被用作攻擊手段，所以很多 router 不支援 1。IPv6 只支援 2。

Path MTU Discovery
透過 ICMP 通知 “packet too big” 不斷嘗試找出兩端機器可行的 MTU，稱為 Path MTU Discovery (PMTUD)。

但是有些 router 基於安全理由 (#1)，會濾掉 ICMP 封包，所以 PMTUD 也不可靠。若用了太大的封包，且中間的 router 沒有回傳 ICMP “packet too big”，結果是 TCP handshake成功，但後面都收不到也傳不出資料。

最穩的作法是一開始就不要讓封包超出 MTU 上限。IPv4 規定 router 至少要能處理 576 bytes，IPv6 是1280 bytes。使用最小值固然能避開最壞情況，但是這樣傳輸效率不好。

幸好如今的 Internet 幾乎都用 Ethernet，Ethernet 標準規範至少有 1500 bytes，所以可以安心地假設 MTU = 1500。

Linux 上可以用 ping 作 PMTUD，下面是計算本機到 8.8.8.8 (Google DNS) 的 PMTU:

$ ping -c 1 -M do -s 2000 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 2000(2028) bytes of data.
ping: local error: Message too long, mtu=1500
我用 adb shell 連上 Android phone 用一樣的指令，在 Wifi 和 4G 得到一樣的結果:

#Wifi
elsa:/ $ ip route
192.168.1.0/24 dev wlan0  proto kernel  scope link  src 192.168.1.103
elsa:/ $ ping -c 1 -M do -s 2000 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 2000(2028) bytes of data.
ping: local error: Message too long, mtu=1500
#4G
elsa:/ $ ip route
10.47.188.192/26 dev rmnet_data0  proto kernel  scope link  src 10.47.188.223
elsa:/ $ ping -c 1 -M do -s 2000 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 2000(2028) bytes of data.
ping: local error: Message too long, mtu=1500
不確定行動網路的 MTU 是否都 ≥ 1500。即使不是，TCP 也不會有問題 (後述)。

TCP SYN 與 MSS
了解 IP layer 的情況後，再來看 TCP 的情況。

TCP 會設 IP 的Don’t Fragment flag，這樣 router 覺得封包太大的時候，會回傳 ICMP “packet too big”，避開 router不處理 IP fragmentation 的問題。如前所述，我們不能完全依賴這個。TCP 在 three-way handshake 的時候還會透過 SYN 封包帶上 MSS，告訴另一邊不要送超出 MSS 的封包過來。OS 會自動用下一站的 MTU — 40 作為 MSS (TCP 和 IP 標頭檔各 20 bytes)，所以無論是直接用 Ethernet 或行動網路，都不會有問題。對 Ethernet 來說，MSS 就是 1500 — 40 = 1460。

MSS clamping
某些情況下中間 router 的 MTU 會比 1500 小，常見的情況有:

使用 PPPoE。
使用 VPN (#2)。
IPv6 tunnel 通過 IPv4 網路。
以 PPPoE 為例，會多 8 ~ 12 bytes 的標頭檔，所以 MSS 必須再少 8 ~ 12 bytes。要求全部 client 更改 OS 的 MSS 設定並不實際，所以現行的作法是 PPPoE 的 server 會偷改 SYN 封包裡的 MSS [#3]，讓它不要超出上限，這個行為稱為 MSS clamping。也就是說 client 以為它用 MSS = 1460，但 PPPoE server 在經手的時候改成 MSS = 1452 (假設 PPP 標頭是 8 bytes)。

不合規定 (MTU≥1500) 的 router 負責作 TCP clamping，相當合理。於是天下太平，不會有人用超出 MTU 上限 ，也就不用擔心某些 router 濾掉 ICMP 的問題了。

Linux 設定 MSS 的方法
可以透過 ip route 設定不同目標的 advmss，這樣 MSS 不會超過 advmss。程式裡也可透過 setsockopt(..., TCP_MAXSEG) 設定，但通常沒必要。

我在 Ubuntu 16.04 用 tcpdump 看 SYN 的封包，發現預設值已是最佳值了。用以下的指令觀察 SYN 帶的 MSS:

sudo tcpdump -s0 -p -ni INTERFACE '(ip and ip[20+13] & tcp-syn != 0)'
連本機的 MSS = 65495 ( 65535 — 40 )，已是上限:

23:52:45.009601 IP 192.168.1.109.38728 > 192.168.1.109.8000: Flags [S], seq 2523441450, win 43690, options [mss 65495,sackOK,TS val 27165590 ecr 0,nop,wscale 7], length 0
23:52:45.009629 IP 192.168.1.109.8000 > 192.168.1.109.38728: Flags [S.], seq 1592261220, ack 2523441451, win 43690, options [mss 65495,sackOK,TS val 27165590 ecr 27165590,nop,wscale 7], length 0
VM 連 VM 的 MSS = 1460:

23:52:00.297788 IP 192.168.1.110.52397 > 192.168.1.109.8000: Flags [S], seq 1208990698, win 29200, options [mss 1460,sackOK,TS val 4294911018 ecr 0,nop,wscale 7], length 0
23:52:00.297833 IP 192.168.1.109.8000 > 192.168.1.110.52397: Flags [S.], seq 2916193787, ack 1208990699, win 28960, options [mss 1460,sackOK,TS val 27154412 ecr 4294911018,nop,wscale 7], length 0
Linux 計算 MSS 的方法
計算的方式頗複雜的，分成傳送用的 MSS 和接收用的 MSS。接收用的 MSS 是估算另一端的傳送用的 MSS，會影響 delayed ACK 的發送時機。關於這點，有閒研究清楚再來寫篇 blog。以下只討論傳送用的 MSS。

綜合前述的知識，我們知道使用者設的 MSS、advmss、PMTU、另一端傳來SYN 帶的 MSS 都會影響真正使用的 MSS。除此之外，TCP 的 window 大小、變動大小的標頭等也有影響。MSS 的值其實會不斷地改變。還有很多細節沒搞懂，就加減看吧。這裡備忘幾個相關函式:

tcp_advertise_mss()
tcp_current_mss()
tcp_sync_mss()
《用 SystemTap 找出 TCP 如何決定 MSS 的值》有稍微進一步的說明。

參考資料
看了拉里拉雜的資料，這幾篇最為精華:

Path MTU discovery in practice
Broken packets: IP fragmentation is flawed
MTU Discovery and MSS Clamping
備註
#1 不懂為啥要擋這個，這篇認為這是腦殘的行為 XD。
#2 不熟 VPN，但應該是 layer 2 or 3 的 VPN，不是 layer 7 的。
#3 《修改 MSS 解決 Linux PPPOE NAT 後部份網頁無法瀏覽問題》有相關細節，用 iptables的 --clamp-mss-to-pmtu。
Tcp
Network

---
最新的图解文章都在公众号首发，别忘记关注哦！！如果你想加入百人技术交流群，扫码下方二维码回复「加群」。

![](https://cdn.xiaolincoding.com/gh/xiaolincoder/ImageHost2/%E5%85%B6%E4%BB%96/%E5%85%AC%E4%BC%97%E5%8F%B7%E4%BB%8B%E7%BB%8D.png)

