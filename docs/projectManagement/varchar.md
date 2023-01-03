# MySQL的varchar(10)能存多少个汉字？
问题
MySQL的varchar(10)能存多少个汉字？
如果是数字或英文，可以存10个，如果是汉字呢，能存多少个？

实践
查看MySQL版本号：
````
select version();
select @@version;
```
本机MySQL版本为5.6.16。

创建测试表：
```
create table test_table (
  id bigint(20) not null,
  product_code varchar(10) not null,
  primary key (id)
) engine=innodb default charset=utf8mb4;
```
先用数字来测试下，写入10个数字：
```
insert into test_table(id,product_code) values(1,'1234567890');
```
写入成功，查询数据：
```
select id,product_code,length(product_code), char_length(product_code) from test_table;
```
查询结果：
```
id	product_code	length(product_code)	char_length(product_code)
1	1234567890	10	10
```
其中，length()返回的字节数为10，char_length()返回的字符数也为10。

写入11个数字试试：
```
insert into test_table(id,product_code) values(2,'12345678901');
```
写入报错，错误提示为：
```
[22001][1406]Data truncation: Data too long for column 'product_code' at row ...
```
因为超过10个数字了，因此写入失败。

接下里用汉字试试，写入10个汉字：
```
insert into test_table(id,product_code) values(3,'天青色等烟雨而我在等');
```
写入成功，查询数据：
```
select id,product_code,length(product_code), char_length(product_code) from test_table;
```
查询结果：
```
id	product_code	length(product_code)	char_length(product_code)
1	1234567890	10	10
3	天青色等烟雨而我在等	30	10
```
其中，汉字的length()返回的字节数是30，char_length()返回的字符数为10，
可见，1个汉字占3个字节，MySQL把汉字当作字符处理，varchar(10)可存储的汉字数为10。

写入11个汉字试试：
```
insert into test_table(id,product_code) values(4,'天青色等烟雨而我在等你');
```
写入报错，错误提示为：
```
[22001][1406]Data truncation: Data too long for column 'product_code' at row ...
```
1个汉字占1个字符，11个汉字超过10个字符，因此写入失败。

总结
当MySQL版本为5.6时：

- varchar(10)表示存储的字符数为10，1个汉字占1个字符(3个字节)
- varchar(10)可存储10个汉字
参考
mysql varchar(50)到底能存多少个汉字 https://blog.csdn.net/u012491783/article/details/78339269
一篇文章看懂mysql中varchar能存多少汉字、数字，以及varchar(100)和varchar(10)的区别 https://www.cnblogs.com/zhuyeshen/p/11642211.html