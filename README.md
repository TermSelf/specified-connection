# 指定連線 (Specified Connection)
透過DOS指令`nslookup`、`route`達成 OpenVPN 指定連線的批次檔

## ver 2.4
僅支持OpenVPN
自動獲取IP  
預設閘道=IP+1

![](https://imgur.com/8SMQEKA.png)

## 支援作業系統
* Windows 8
* Windows 10

## 使用說明
* OpenVPN 連線程式

  從[官方網站](https://openvpn.net/community-downloads/)下載並安裝

* 設定手動路由模式

  開啟 OpenVPN 專用的 `.ovpn` 連線設定檔  
  於任意空白處(沒有#的位置)加入指令`route-nopull`儲存後即可連線

* 批次檔

  輸入數字鍵`1~3`進行操作  
  `q`退出程式，但不會清洗路由表

  虛擬網卡切換功能：  
  `O`切換成 TAP-Windows Adapter V9 (預設)  
  `P`切換成 TAP-Windows Adapter V9 #2

* 多個連線方法

  C:\Program Files\TAP-Windows\bin  
  執行`addtap.bat`可增加虛擬網卡數量

## 支援列表
[WEB]DMM.com  
[WEB]Baidupan (百度網盤)  
[WEB]Google Play  
[UWP][WEB][BETA]Netflix  
