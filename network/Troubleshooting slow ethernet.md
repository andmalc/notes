---
title: "Your Ethernet adapter is negotiating itself down to 2003 speeds—here's how to fix it"
source: "https://www.howtogeek.com/this-rarely-mentioned-ethernet-setting-can-make-a-fast-pc-feel-painfully-slow/?utm_medium=newsletter&utm_campaign=HTG-202609160645&utm_source=HTG-NL&category=email_newsletter&type=click&typeValue=YW5kbWFsY0BnbWFpbC5jb20&user=YW5kbWFsY0BnbWFpbC5jb20&isEvent=1"
author:
  - "[[Monica J. White]]"
published: 2026-09-14
created: 2026-09-16
description: "Check this hidden Ethernet setting before blaming your router"
tags:
  - "networking"
  -"troubleshooting"
type: "article"
---

Switching to Ethernet was simultaneously [the best and the cheapest network upgrade](https://www.howtogeek.com/i-saved-myself-hours-of-network-troubleshooting-with-a-5-fix/) I've ever gotten. Simply ditching Wi-Fi for a cable is fantastic, and in most cases, it improves your connection tremendously.

But what if one Ethernet-related setting actually makes your PC feel slow? That can happen, and after some digging, I found the culprit.


## Speed & Duplex decides how fast your Ethernet link actually runs

### Auto Negotiation is doing more than you might think

- ![Hand holding a flat Ethernet cable.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/08/hand-holding-a-flat-ethernet-cable.jpg?q=49&fit=contain&w=750&h=422&dpr=2)
	Credit: Andrew Heinzman / How-To Geek

- ![Hand holding a flat Ethernet cable.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/08/hand-holding-a-flat-ethernet-cable.jpg?q=49&fit=contain&w=2100&h=1400&dpr=2)
	Credit: Andrew Heinzman / How-To Geek
- ![A Pixel 10 Pro phone plugged into a router via Ethernet 03-1](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/05/a-pixel-10-pro-phone-plugged-into-a-router-via-ethernet-03-1.jpg?q=49&fit=contain&w=6000&h=3375&dpr=2)
	Credit: Goran Damnjanovic / How-To Geek
- ![UniFi US-48-500W managed PoE network switch with Ethernet cables and SFP ports.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/05/unifi-us-48-500w-managed-poe-network-switch-with-ethernet-cables-and-sfp-ports-1.jpg?q=49&fit=contain&w=2100&h=1400&dpr=2)
	Credit: Patrick Campanale / How-To Geek
- ![An old MacBook laptop stood in the tent position with an Ethernet cable plugged into it.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/02/an-old-macbook-stood-in-the-tent-position-with-an-ethernet-cable-plugged-into-it.jpg?q=49&fit=contain&w=1920&h=1080&dpr=2)
	Credit: Jordan Gloor/How-To Geek
- ![Ethernet cables plugged into a Ubiquiti Flex Mini managed network switch.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2025/12/ethernet-cables-plugged-into-a-ubiquiti-flex-mini-managed-network-switch-3.jpg?q=49&fit=contain&w=1920&h=1080&dpr=2)
	Credit: Jordan Gloor / How-To Geek

![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iOCIgdmlld0JveD0iMCAwIDEyIDgiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTEuMjU5MiAwLjU4NjMwOUMxMC45NDk4IDAuNjc2MTIzIDEwLjM2OCAwLjg5ODU1NSAxMC4xNDE1IDEuMzQzNjJDOS45MjgxOSAxLjc2MjIxIDEwLjA2OSAyLjMzNzU0IDEwLjE5NzUgMi42N0MxMC41MDY3IDIuNTgwMjkgMTEuMDg5OSAyLjM1Nzg2IDExLjMxNjUgMS45MTIzOEMxMS41NDMyIDEuNDY3MzEgMTEuMzczMSAwLjg4MTIwOCAxMS4yNTkyIDAuNTg2MzA5VjAuNTg2MzA5Wk05LjkwMDYxIDMuMjU1OUw5LjgxMjMgMy4wODUyQzkuNzg4OTMgMy4wMzk3MyA5LjI0MjA5IDEuOTYyNzggOS42NzMwMyAxLjExNjg4QzEwLjEwMzYgMC4yNzA3NzggMTEuMzEzNiAwLjA0MzkzMjEgMTEuMzY0OCAwLjAzNDY5NEwxMS41NTc2IDBMMTEuNjQ1OSAwLjE3MDY5OUMxMS42NjkzIDAuMjE2MTcxIDEyLjIxNiAxLjI5MzAyIDExLjc4NDkgMi4xMzkxMkMxMS4zNTQ4IDIuOTg0ODIgMTAuMTQ0NyAzLjIxMTg3IDEwLjA5MzMgMy4yMjExMUw5LjkwMDYxIDMuMjU1OVoiIGZpbGw9IiM5MTkxOTEiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0yLjY0NDc1IDIuNjQ3NzlDMi41NzkxNyAxLjI4MzQzIDEuNDQwMjIgMC4xOTQ4NzggMC4wMzI5NTkgMC4xNjE2MjFWNS4zODI1NkMwLjAzNDAxMTYgNS4zODI1NiAwLjAzNTA2NDIgNS4zODI0NiAwLjAzNjExNjkgNS4zODIzNkMwLjEwMTY5NiA2Ljc0NjcyIDEuMjQwNjQgNy44MzUzNyAyLjY0NzkxIDcuODY4NTJWMi42NDc2OUMyLjY0Njg1IDIuNjQ3NjkgMi42NDU4IDIuNjQ3NzkgMi42NDQ3NSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNS43MTcyNiAyLjY0Nzc5QzUuNjUxNjggMS4yODM0MyA0LjUxMjczIDAuMTk0ODc4IDMuMTA1NDcgMC4xNjE2MjFWNS4zODI1NkMzLjEwNjUyIDUuMzgyNTYgMy4xMDc1NyA1LjM4MjQ2IDMuMTA4NzMgNS4zODIzNkMzLjE3NDIxIDYuNzQ2NzIgNC4zMTMxNSA3LjgzNTM3IDUuNzIwNTIgNy44Njg1MlYyLjY0NzY5QzUuNzE5NDcgMi42NDc2OSA1LjcxODMxIDIuNjQ3NzkgNS43MTcyNiAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNOC43OTAwMSAyLjY0Nzc5QzguNzI0MzMgMS4yODM0MyA3LjU4NTQ5IDAuMTk0ODc4IDYuMTc4MjIgMC4xNjE2MjFWNS4zODI1NkM2LjE3OTI4IDUuMzgyNTYgNi4xODAzMyA1LjM4MjQ2IDYuMTgxMzggNS4zODIzNkM2LjI0Njk2IDYuNzQ2NzIgNy4zODYwMSA3LjgzNTM3IDguNzkzMTcgNy44Njg1MlYyLjY0NzY5QzguNzkyMTIgMi42NDc2OSA4Ljc5MTA2IDIuNjQ3NzkgOC43OTAwMSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+Cjwvc3ZnPgo=)

If you've never heard of Speed & Duplex, I won't blame you, but this is actually a pretty important setting. It controls how your Ethernet adapter talks to the device at the other end of the cable. Most of the time, that'll be your router.

The "speed" part of the name determines whether that link runs at, say, 100Mbps, 1Gbps, or 2.5Gbps. Duplex, on the other hand, decides whether data can travel in both directions at the same time. It shouldn't surprise you that modern Ethernet usually uses full duplex.

The reason I said that if you've never heard of this setting, I won't blame you, is that it's pretty niche. Under normal circumstances, you shouldn't have to choose any of this yourself, and that's because of Auto Negotiation, which lets your PC's network adapter and the router/switch compare what they both support and agree on the best compatible link speed and duplex mode. It's not much unlike what [USB cables](https://www.howtogeek.com/i-thought-all-usb-c-cables-were-equal-until-this-one-broke-my-workflow/) and ports do.

To check this setting for yourself in Windows, go to the Device Manager, then expand network adapters. Right-click your Ethernet adapter, and choose Properties > Advanced. Then, dig for Speed & Duplex or a similarly named setting, and select Auto Negotiation.

![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iOCIgdmlld0JveD0iMCAwIDEyIDgiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTEuMjU5MiAwLjU4NjMwOUMxMC45NDk4IDAuNjc2MTIzIDEwLjM2OCAwLjg5ODU1NSAxMC4xNDE1IDEuMzQzNjJDOS45MjgxOSAxLjc2MjIxIDEwLjA2OSAyLjMzNzU0IDEwLjE5NzUgMi42N0MxMC41MDY3IDIuNTgwMjkgMTEuMDg5OSAyLjM1Nzg2IDExLjMxNjUgMS45MTIzOEMxMS41NDMyIDEuNDY3MzEgMTEuMzczMSAwLjg4MTIwOCAxMS4yNTkyIDAuNTg2MzA5VjAuNTg2MzA5Wk05LjkwMDYxIDMuMjU1OUw5LjgxMjMgMy4wODUyQzkuNzg4OTMgMy4wMzk3MyA5LjI0MjA5IDEuOTYyNzggOS42NzMwMyAxLjExNjg4QzEwLjEwMzYgMC4yNzA3NzggMTEuMzEzNiAwLjA0MzkzMjEgMTEuMzY0OCAwLjAzNDY5NEwxMS41NTc2IDBMMTEuNjQ1OSAwLjE3MDY5OUMxMS42NjkzIDAuMjE2MTcxIDEyLjIxNiAxLjI5MzAyIDExLjc4NDkgMi4xMzkxMkMxMS4zNTQ4IDIuOTg0ODIgMTAuMTQ0NyAzLjIxMTg3IDEwLjA5MzMgMy4yMjExMUw5LjkwMDYxIDMuMjU1OVoiIGZpbGw9IiM5MTkxOTEiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0yLjY0NDc1IDIuNjQ3NzlDMi41NzkxNyAxLjI4MzQzIDEuNDQwMjIgMC4xOTQ4NzggMC4wMzI5NTkgMC4xNjE2MjFWNS4zODI1NkMwLjAzNDAxMTYgNS4zODI1NiAwLjAzNTA2NDIgNS4zODI0NiAwLjAzNjExNjkgNS4zODIzNkMwLjEwMTY5NiA2Ljc0NjcyIDEuMjQwNjQgNy44MzUzNyAyLjY0NzkxIDcuODY4NTJWMi42NDc2OUMyLjY0Njg1IDIuNjQ3NjkgMi42NDU4IDIuNjQ3NzkgMi42NDQ3NSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNS43MTcyNiAyLjY0Nzc5QzUuNjUxNjggMS4yODM0MyA0LjUxMjczIDAuMTk0ODc4IDMuMTA1NDcgMC4xNjE2MjFWNS4zODI1NkMzLjEwNjUyIDUuMzgyNTYgMy4xMDc1NyA1LjM4MjQ2IDMuMTA4NzMgNS4zODIzNkMzLjE3NDIxIDYuNzQ2NzIgNC4zMTMxNSA3LjgzNTM3IDUuNzIwNTIgNy44Njg1MlYyLjY0NzY5QzUuNzE5NDcgMi42NDc2OSA1LjcxODMxIDIuNjQ3NzkgNS43MTcyNiAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNOC43OTAwMSAyLjY0Nzc5QzguNzI0MzMgMS4yODM0MyA3LjU4NTQ5IDAuMTk0ODc4IDYuMTc4MjIgMC4xNjE2MjFWNS4zODI1NkM2LjE3OTI4IDUuMzgyNTYgNi4xODAzMyA1LjM4MjQ2IDYuMTgxMzggNS4zODIzNkM2LjI0Njk2IDYuNzQ2NzIgNy4zODYwMSA3LjgzNTM3IDguNzkzMTcgNy44Njg1MlYyLjY0NzY5QzguNzkyMTIgMi42NDc2OSA4Ljc5MTA2IDIuNjQ3NzkgOC43OTAwMSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+Cjwvc3ZnPgo=)

99% of the time, Auto Negotiation is exactly what you want. This usually isn't the case of needing to tweak something manually, and forcing your connection to 1Gbps or 2.5Gbps doesn't make it faster if the connection (the *entire* connection, hardware and all) isn't prepared to handle it. Worse yet, doing so can actually mess things up instead of helping.

The interesting thing is what happens when Auto Negotiation doesn't land on the speed you expected, and that's why this setting is worth checking. That'll be your first sign to dig deeper.

## A 2.5GbE PC can still end up crawling along

### You don't want to describe your connection as "crawling," right?

![WiFi 7 text on the Huawei WiFi BE3 Pro router at MWC 2024.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/08/53575843030_cc6412bf6f_o.jpg?q=49&fit=crop&w=825&dpr=2)

Credit: Hannah Stryker / How-To Geek

![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIiIGhlaWdodD0iOCIgdmlld0JveD0iMCAwIDEyIDgiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTEuMjU5MiAwLjU4NjMwOUMxMC45NDk4IDAuNjc2MTIzIDEwLjM2OCAwLjg5ODU1NSAxMC4xNDE1IDEuMzQzNjJDOS45MjgxOSAxLjc2MjIxIDEwLjA2OSAyLjMzNzU0IDEwLjE5NzUgMi42N0MxMC41MDY3IDIuNTgwMjkgMTEuMDg5OSAyLjM1Nzg2IDExLjMxNjUgMS45MTIzOEMxMS41NDMyIDEuNDY3MzEgMTEuMzczMSAwLjg4MTIwOCAxMS4yNTkyIDAuNTg2MzA5VjAuNTg2MzA5Wk05LjkwMDYxIDMuMjU1OUw5LjgxMjMgMy4wODUyQzkuNzg4OTMgMy4wMzk3MyA5LjI0MjA5IDEuOTYyNzggOS42NzMwMyAxLjExNjg4QzEwLjEwMzYgMC4yNzA3NzggMTEuMzEzNiAwLjA0MzkzMjEgMTEuMzY0OCAwLjAzNDY5NEwxMS41NTc2IDBMMTEuNjQ1OSAwLjE3MDY5OUMxMS42NjkzIDAuMjE2MTcxIDEyLjIxNiAxLjI5MzAyIDExLjc4NDkgMi4xMzkxMkMxMS4zNTQ4IDIuOTg0ODIgMTAuMTQ0NyAzLjIxMTg3IDEwLjA5MzMgMy4yMjExMUw5LjkwMDYxIDMuMjU1OVoiIGZpbGw9IiM5MTkxOTEiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0yLjY0NDc1IDIuNjQ3NzlDMi41NzkxNyAxLjI4MzQzIDEuNDQwMjIgMC4xOTQ4NzggMC4wMzI5NTkgMC4xNjE2MjFWNS4zODI1NkMwLjAzNDAxMTYgNS4zODI1NiAwLjAzNTA2NDIgNS4zODI0NiAwLjAzNjExNjkgNS4zODIzNkMwLjEwMTY5NiA2Ljc0NjcyIDEuMjQwNjQgNy44MzUzNyAyLjY0NzkxIDcuODY4NTJWMi42NDc2OUMyLjY0Njg1IDIuNjQ3NjkgMi42NDU4IDIuNjQ3NzkgMi42NDQ3NSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNS43MTcyNiAyLjY0Nzc5QzUuNjUxNjggMS4yODM0MyA0LjUxMjczIDAuMTk0ODc4IDMuMTA1NDcgMC4xNjE2MjFWNS4zODI1NkMzLjEwNjUyIDUuMzgyNTYgMy4xMDc1NyA1LjM4MjQ2IDMuMTA4NzMgNS4zODIzNkMzLjE3NDIxIDYuNzQ2NzIgNC4zMTMxNSA3LjgzNTM3IDUuNzIwNTIgNy44Njg1MlYyLjY0NzY5QzUuNzE5NDcgMi42NDc2OSA1LjcxODMxIDIuNjQ3NzkgNS43MTcyNiAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+CjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNOC43OTAwMSAyLjY0Nzc5QzguNzI0MzMgMS4yODM0MyA3LjU4NTQ5IDAuMTk0ODc4IDYuMTc4MjIgMC4xNjE2MjFWNS4zODI1NkM2LjE3OTI4IDUuMzgyNTYgNi4xODAzMyA1LjM4MjQ2IDYuMTgxMzggNS4zODIzNkM2LjI0Njk2IDYuNzQ2NzIgNy4zODYwMSA3LjgzNTM3IDguNzkzMTcgNy44Njg1MlYyLjY0NzY5QzguNzkyMTIgMi42NDc2OSA4Ljc5MTA2IDIuNjQ3NzkgOC43OTAwMSAyLjY0Nzc5IiBmaWxsPSIjOTE5MTkxIi8+Cjwvc3ZnPgo=)

So, what does Auto Negotiation have to do with your connection feeling slow? Quite a lot, because the speed it negotiates is the one your Ethernet connection actually runs at, so if something goes wrong along that whole line, your internet might feel incredibly sluggish.

First, some numbers. A 2.5GbE connection tops out at 312.5MB/s, and 1Gbps has a raw ceiling of 125MB/s. Meanwhile, 100Mbps crawls along at around 12.5MB/s before overhead. So, if something in the link causes your network adapter to negotiate down to 100Mbps, you're missing out on so much internet speed you might as well hop in a time machine back to 2003.

Such a slowdown is going to reverberate throughout your entire connection, unfortunately. Large downloads, streams, gaming—all of that stuff is majorly affected when suddenly the internet speeds you were meant to have just aren't there. Even with a fast PC, most tasks will crawl along at a snail's pace.

There's a fix, of course.


## Don't fix it by forcing the biggest number

### That doesn't actually help

![An Ethernet cable plugged into the back of a desktop PC.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/08/180233.jpg?q=49&fit=crop&w=825&dpr=2)


Given what we now know about Speed & Duplex, your first instinct might be to go in there and force the highest number you possibly can, but I'm here to tell you not to do it.

Auto Negotiation exists specifically for the purpose of two devices agreeing on a configuration that actually works on both ends. If you end up picking something that works on one end but not the other, it's not like one of the devices can force the other to just somehow learn how to negotiate at a higher speed.

Doing this means that at best, you gain a big fat zero, zilch, nothing. At worst, the link can become unstable or fail to come up properly. So, if Auto Negotiation has [landed you at 100Mbps even though you expected gigabit Ethernet](https://www.howtogeek.com/7-reasons-my-gigabit-network-never-reached-gigabit-speeds/) or better, it means it's time to investigate instead of forcing it to do what you'd like to see.

## Check what speed was actually negotiated

### Link speed and internet speed are not one and the same

![A top-down view of an Eero Wi-Fi router and power bank.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/08/a-top-down-view-of-an-eero-wi-fi-router-and-power-bank.jpg?q=49&fit=crop&w=825&dpr=2)

Credit: Andrew Heinzman / How-To Geek


Forcing it isn't the answer, then what is? You just need to check what Auto Negotiation actually gives you. In Windows, you'll find this under Settings > Network & internet > Ethernet if you look for link speed. You can also check your adapter's status in the Control Panel.

If you have a gigabit or 2.5GbE connection but Windows reports a slower link, well, there you go.

One thing to note: Don't confuse that number with your actual internet speed. Link speed only talks about the connection between your PC and the next device on your local network, which is most commonly a router. Your ISP determines how fast you can actually reach the internet, so that factors into the equation, too.

## If Auto Negotiation is disappointing, check the cable

### The setting may just be shining a light on the real problem

![A flat Cat6 Ethernet cable on a black mousepad.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2026/03/ethernet-cable-broken.jpg?q=49&fit=crop&w=825&dpr=2)

Credit: Ismar Hrnjicevic / How-To Geek

On rare occasions, Auto Negotiation may indeed be the problem, in which case you can always force the link to follow a certain speed—but this will only work if all the devices involved, including the cable itself, can support that speed and are working properly. If not, you just got a pretty important hint as to where to look for the troublemaker.

The first thing I'd check is the Ethernet cable itself. Unplug it and reseat both ends. Then, swap it out for a different cable that you know works perfectly well, and make sure it's Cat5e or better.

There's a good reason cables can mess with this at times. Gigabit Ethernet needs all four twisted pairs inside the cable, while 100BASE-TX can get by with only two. A damaged pair can leave you with a connection that technically works, but doesn't perform the way you'd think.

### A fast PC is only as fast as its slowest link

Any PC, aging or otherwise, is [only as fast as its slowest link](https://www.howtogeek.com/i-tested-the-internets-favorite-ways-to-speed-up-an-old-pcthese-made-the-biggest-difference/). If something is bottlenecking your connection, Speed & Duplex may expose it. Tweak the setting as needed, but if you're uncertain about the hardware's capabilities, you might have to start there first.
