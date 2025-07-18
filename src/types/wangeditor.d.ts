declare module '@wangeditor/editor-for-vue' {
    import { DefineComponent } from 'vue'

    // 编辑器组件类型
    const Editor: DefineComponent<{
        modelValue: string
        mode?: 'default' | 'simple'
        height?: number
        placeholder?: string
        defaultConfig?: Record<string, any>
        onCreated?: (editor: any) => void
        onChange?: (editor: any) => void
        onDestroyed?: () => void
    }, {}, any>

    // 工具栏组件类型
    const Toolbar: DefineComponent<{
        editor?: any
        mode?: 'default' | 'simple'
        config?: Record<string, any>
    }, {}, any>
    export { Toolbar, Editor }
}
