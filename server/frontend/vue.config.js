// vue.config.js
module.exports = {
    chainWebpack: config => {
        config
            .plugin('html')
            .tap(args => {
                args[0].title = 'Client and Server Connection Status'
                args[0].apiUrl = 'http://localhost:8081/'
                return args
            })
    },
    devServer: {
        disableHostCheck: true
    }
}