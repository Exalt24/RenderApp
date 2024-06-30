module.exports = {
    client: {
        service: {
            name: 'myapp',
            // URL to the GraphQL API
            url: 'http://localhost:5100/graphiql',
        },
        // Files processed by the extension
        includes: [
            'src/**/*.vue',
            'src/**/*.js',
        ],
    },
}