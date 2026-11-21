# Android APK 云端自动打包与下载教程（小白版）

> 基于仓库内的 `.github/workflows/build-apk.yml`，全程网页点选即可出包，无需在电脑上安装 Android 开发环境。

## 一、前置条件

1. 代码已推送到 GitHub 远程仓库，且能看到 `android-app/` 与 `.github/workflows/build-apk.yml`。
2. GitHub 账号已登录。

## 二、触发打包（4 步）

1. 打开仓库主页：`https://github.com/你的用户名/你的仓库名`。
2. 点击顶部标签栏的 **Actions**。
3. 左侧工作流列表里点击 **Build Android APK**。
4. 点击右上角 **Run workflow**，在下拉框选中分支（通常 `main` 或 `master`），再点蓝色 **Run workflow** 确认。

页面出现一条新的执行记录并显示旋转圆圈，表示已开始打包。

## 三、下载 APK

1. 等待 **3～10 分钟**：绿色对勾 = 成功，红色叉号 = 失败（点进去看红色步骤报错）。
2. 点击那条绿色的运行记录进入详情页。
3. 拉到页面最下方，找到 **Artifacts** 区域。
4. 点击 **village-link-apk**，再点 **Download**，得到 `village-link-apk.zip`。
5. 解压得到 `app-debug.apk`，传到安卓手机安装（需允许「安装未知来源应用」）。

> Artifacts 默认保留 90 天，打包成功后尽快下载。

## 四、常见问题

| 现象 | 处理 |
|---|---|
| 找不到 Actions 标签 | 工作流文件未推送，确认 `.github/workflows/build-apk.yml` 在远程仓库 |
| Run workflow 按钮是灰的 | 先在旁边下拉框手动选分支 |
| 运行变红 | 点开红色步骤看日志，把报错发出来排查 |
| Artifacts 为空 | 打包中途失败，回到上一步看报错 |
| 想重新打包 | 回到 Actions → Build Android APK → Run workflow |

## 五、工作流做了什么

1. 拉取仓库代码（`actions/checkout`）
2. 安装 JDK 17 与 Gradle 环境
3. 在 `android-app/` 下生成 Gradle wrapper（8.7）
4. 执行 `./gradlew assembleDebug`（依赖 `app/libs` 下 18 个 AAR，已随仓库提交）
5. 上传 `android-app/app/build/outputs/apk/debug/*.apk` 为产物
