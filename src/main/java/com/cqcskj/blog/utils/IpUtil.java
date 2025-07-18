package com.cqcskj.blog.utils;

import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.util.Enumeration;
@Component
public class IpUtil {

    /**
     * 获取本地非回环IP地址
     * @return 本地IP地址，如果未找到则返回null
     */
    public static String getLocalIp() {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface ni = interfaces.nextElement();
                if (ni.isLoopback() || !ni.isUp()) {
                    continue;
                }
                Enumeration<InetAddress> addresses = ni.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    InetAddress addr = addresses.nextElement();
                    if (addr instanceof Inet4Address) {
                        return addr.getHostAddress();
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取外部网络IP地址（通过查询公网IP服务）
     * @return 外部网络IP地址，如果获取失败则返回null
     */
    public static String getExternalIp() {
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(new URL("https://api.ipify.org").openStream()))) {
            return br.readLine();
        } catch (IOException e) {
            System.err.println("获取外部IP失败: " + e.getMessage());
            return null;
        }
    }
}