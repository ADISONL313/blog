// src/services/WebSocketService.js
import { ref, reactive, onMounted, onUnmounted } from 'vue';

export const useWebSocket = (userId: any) => {
    const socket = ref<WebSocket | null>(null);
    const messages = ref<any[]>([]);
    const isConnected = ref(false);
    let reconnectCount = 0;
    const MAX_RECONNECT_COUNT = 5;

    // 连接 WebSocket
    const connect = () => {
        if (reconnectCount >= MAX_RECONNECT_COUNT) {
            console.error('达到最大重连次数，停止重连');
            return;
        }
        socket.value = new WebSocket(`ws://localhost:8080/ws/notification?userId=${userId}`);

        socket.value.onopen = () => {
            isConnected.value = true;
            reconnectCount = 0;
            console.log('WebSocket 连接成功');
        };

        socket.value.onclose = () => {
            isConnected.value = false;
            console.log('WebSocket 连接已关闭');
            // 自动重连逻辑
            reconnectCount++;
            setTimeout(() => connect(), 3000);
        };

        socket.value.onmessage = (event) => {
            try {
                const message = JSON.parse(event.data);
                console.log('接收到的消息:', message); // 添加日志
                messages.value.push(message);
            } catch (error) {
                console.error('解析消息时出错:', error);
            }
        };
        socket.value.onerror = (error) => {
            console.error('WebSocket 错误:', error);
        };
    };

    // 断开连接
    const disconnect = () => {
        if (socket.value) {
            socket.value.close();
            socket.value = null;
        }
    };

    // 生命周期钩子
    onMounted(() => {
        if (userId) connect();
    });

    onUnmounted(() => {
        disconnect();
    });

    return {
        messages,
        isConnected,
        connect,
        disconnect
    };
};