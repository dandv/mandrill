getMandrillConfig = ->
    apiKey = process.env.MANDRILL_API_KEY

    if !apiKey
        throw new Error "Missing environment variable: MANDRILL_API_KEY"

    config =
        apiKey: apiKey

share.Config =
    mandrill: getMandrillConfig()
