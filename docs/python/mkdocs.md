# Welcome to MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.

# about mkdocs

MkDocs 是一个用 Python 开发的静态站点生成器工具，它可以非常简单快速的创建项目文档。MkDocs 的文档源码使用 Markdown 编写，配置文件使用 YAML 编写，可以一键编译成静态站点。
pip install mkdocs 后会一同安装如下程序：

```
click              8.0.4
ghp-import         2.1.0
importlib-metadata 4.8.3
Jinja2             3.0.3
Markdown           3.3.7
MarkupSafe         2.0.1
mergedeep          1.3.4
mkdocs             1.3.1
packaging          21.3
pyparsing          3.0.9
python-dateutil    2.8.2
PyYAML             6.0
pyyaml_env_tag     0.1
six                1.16.0
typing_extensions  4.1.1
watchdog           2.1.9
zipp               3.6.0
```

---

# material的一些特性展示

## 支持代码高亮还支持代码标题

```python title='demo.py'
def sayhi():
    return "hi,Python全栈开发"
```

## 代码自由注释
 

``` yaml
theme:
  features:
    - content.code.annotate # (1)
```

1.  :man_raising_hand: I'm a code annotation! I can contain `code`, __formatted
    text__, images, ... basically anything that can be written in Markdown.

## 提示框

??? note "这是 note 类型的提示框"
提示：更多精彩内容记得关注我啊
1
2
3
4

!!! note "这是 note 类型的提示框"
提示：更多精彩内容记得关注我啊

!!! success "这是 success 类型的提示框"
成功！

!!! failure "这是 failure 类型的提示框"
失败！

!!! bug "这是 bug 类型的提示框"
发现一个 bug，请尽快修复！


## table

| Method      | Description                          |
| ----------- | ------------------------------------ |
| `GET`       | :material-check:     Fetch resource  |
| `PUT`       | :material-check-all: Update resource |
| `DELETE`    | :material-close:     Delete resource |
