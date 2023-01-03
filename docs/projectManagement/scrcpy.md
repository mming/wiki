# scrcpy安装
https://github.com/Genymobile/scrcpy

The application is available in Homebrew. Just install it:

```
brew install scrcpy
```
You need adb, accessible from your PATH. If you don't have it yet:
```
brew install android-platform-tools
```

# Run
Plug an Android device into your computer, and execute:
```
scrcpy
```
It accepts command-line arguments, listed by:
```
scrcpy --help
```
# Features
查看当前有几台手机连接
```
adb devices
```    
List of devices attached
A7Q0218223002753	device #手机1
R28M31YAQQM	device #手机2

```
scrcpy --window-title '手机1'  -s A7Q0218223002753
```
```
scrcpy --window-title '手机2'  -s R28M31YAQQM
```

## 启动时报错
dyld[46627]: Library not loaded: /opt/homebrew/opt/rav1e/lib/librav1e.0.5.dylib

解决方法
```
brew reinstall rav1e
```
> 参考：https://github.com/Genymobile/scrcpy/issues/3578