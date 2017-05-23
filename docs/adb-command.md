1. 查看当前Activity名
> adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' --color=always

2. 查看当前Activity的启动时间
> adb shell am start -W [packageName]/[packageName.MainActivity]

3. 录制手机屏幕录像
> adb shell screenrecord —bugreport /sdcard/launch.mp4

4. 拉取屏幕录像
> adb pull /sdcard/launch.mp4

5. 获取adb堆栈：
> adb shell dumpsys activity activities

6. Dump应用的授权状态
> adb shell dumpsys package my.package.name

7. 在安装apk的时候全部授权
> adb shell install -g com.package.name

8. 应用运行期间授权或者取消授权
> adb shell pm grant/revoke my.package.name some.permission.name

9. 查看80QBCP6222F3的日志
> adb -s 80QBCP6222F3 logcat -v threadtime -b all

10. 查看APK的签名
> keytool -printcert -file xxx/META_INF/CERT.RSA  
> keytool-list-keystore some_keystore

11. 列出所有包名
> adb shell pm list packages

12. 列出应用所有安装权限
> adb shell pm list permissions -d -g