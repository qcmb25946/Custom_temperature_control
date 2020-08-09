##########################################################################################
#
# Magisk Module Template Config Script
# by TheBestLuke
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure the settings in this file (config.sh)
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Configs
##########################################################################################

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
SKIPMOUNT=false
#是否安装模块后自动关闭，改为faslse，安装后不会自动勾选启用

# Set to true if you need to load system.prop
PROPFILE=false
#是否使用common/system.prop文件

# Set to true if you need post-fs-data script
POSTFSDATA=true
#是否使用post-fs-data脚本执行文件

# Set to true if you need late_start service script
LATESTARTSERVICE=true
#是否在开机时候允许允许common/service.sh中脚本

##########################################################################################
# Installation Message
##########################################################################################

# 在安装模块时显示什么内容

print_modname() {
  ui_print "************************************************ "
  ui_print "全新自定义温控v1.5 "
  ui_print "千城墨白                "
  ui_print "************************************************ "
}

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

# This is an example
REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here, it will override the example above
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="

"
#添加您要修改的的APP/文件夹目录
#例如：修复状态栏，找到状态栏目录为  /system/priv-app/MiuiSystemUI/MiuiSystemUI.apk     
#转化加入:/system/priv-app/MiuiSystemUI
#（可以搭配高级设置获取APP目录）

##########################################################################################
# Permissions
##########################################################################################
# 释放文件，普通shell命令
on_install() {
  ui_print "- Repacking Files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
 }
# 这里的意思是将模块里的/system整个内容覆盖到手机内的/system
set_permissions() {
  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Here are some examples for the set_perm functions:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0       0       0644
  
  # The following is default permissions, DO NOT remove
  set_perm_recursive  $MODPATH  0  0  0755  0644
  set_perm  $MODPATH/system/bin/CTC.sh  0  0  0755
  set_perm  $MODPATH/system/bin/PTC.sh  0  0  0755
  set_perm  $MODPATH/system/bin/CAPOCAF.sh  0  0  0755
  set_perm  $MODPATH/system/bin/log.sh  0  0  0755
  set_perm  $MODPATH/sbin/TC/设置参数.sh  0  0  0755
  #设置权限，基本不要去动
}

##########################################################################################
# Custom Functions
##########################################################################################

# This file (config.sh) will be sourced by the main flash script after util_functions.sh
# If you need custom logic, please add them here as functions, and call these functions in
# update-binary. Refrain from adding code directly into update-binary, as it will make it
# difficult for you to migrate your modules to newer template versions.
# Make update-binary as clean as possible, try to only do function calls in it.