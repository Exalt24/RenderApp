import { createApp, h } from 'vue'
import App from "../../frontend/components/App.vue"
import ButtonCounter from '../../frontend/components/ButtonCounter.vue'
import { ApolloClient, InMemoryCache } from '@apollo/client/core'
import { createApolloProvider } from '@vue/apollo-option'
import Rails from "@rails/ujs"
Rails.start()

// Cache implementation
const cache = new InMemoryCache()

// Create the apollo client
const apolloClient = new ApolloClient({
  uri: 'http://localhost:5100/graphiql',
  cache,
})

const apolloProvider = createApolloProvider({
  defaultClient: apolloClient,
})


document.addEventListener('DOMContentLoaded', () => {
  const app = createApp({
    render: () => h(App),
  })
  app.use(apolloProvider)
  app.component('ButtonCounter', ButtonCounter)
  app.mount('#app')
})

