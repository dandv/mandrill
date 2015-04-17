mandrill    = Npm.require 'mandrill-api/mandrill'

conf        = share.Config
client      = new mandrill.Mandrill(conf.mandrill.apiKey)

@Mandrill =
    users: Meteor.wrapAsync (method, options, cb) ->
        client.users[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    messages: Meteor.wrapAsync (method, options, cb) ->
        client.messages[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    tags: Meteor.wrapAsync (method, options, cb) ->
        client.tags[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    rejects: Meteor.wrapAsync (method, options, cb) ->
        client.rejects[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    whitelists: Meteor.wrapAsync (method, options, cb) ->
        client.whitelists[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    senders: Meteor.wrapAsync (method, options, cb) ->
        client.senders[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    urls: Meteor.wrapAsync (method, options, cb) ->
        client.urls[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    templates: Meteor.wrapAsync (method, options, cb) ->
        client.templates[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    webhooks: Meteor.wrapAsync (method, options, cb) ->
        client.webhooks[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    subaccounts: Meteor.wrapAsync (method, options, cb) ->
        client.subaccounts[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    inbound: Meteor.wrapAsync (method, options, cb) ->
        client.inbound[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    exports: Meteor.wrapAsync (method, options, cb) ->
        client.exports[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    ips: Meteor.wrapAsync (method, options, cb) ->
        client.ips[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err

    metadata: Meteor.wrapAsync (method, options, cb) ->
        client.metadata[method] options, (result) ->
            cb null, result
        , (err) ->
            cb new Error JSON.stringify err
