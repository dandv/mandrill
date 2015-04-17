# mjmasn:mandrill

This Meteor package wraps the ```mandrill-api``` NPM package. As it is a fairly simple wrap of the NPM package, I have only tested the messages.send function but all functions should all work as expected. If you do discover any issues please open a new issue or submit a PR.

## Installation
This package is available at https://atmospherejs.com/mjmasn/mandrill. To install use:

```meteor add mjmasn:mandrill```

## Environment Variables
This package requires ```MANDRILL_API_KEY``` to be set in your environment variables and will throw an error if it is not set. You can obtain an API key by logging in at https://mandrillapp.com/settings/index and clicking 'New API Key'.

## Usage
Usage for this package is slightly different to the NPM package. In plain Node you would do:
```javascript
Mandrill.messages.send(options, function (result) {
    // Success function
}, function (err) {
    // Error function
});
```
In Meteor you do:
```javascript
try {
    var result = Mandrill.messages('send', options);
}
catch (err) {
    // Handle any errors
}
```

So the basic format is ```Mandrill.CATEGORY(METHOD, options)``` where CATEGORY is one of:

```users``` ```messages``` ```tags``` ```rejects``` ```whitelists``` ```senders``` ```urls``` ```templates``` ```webhooks``` ```subaccounts``` ```inbound``` ```exports``` ```ips``` ```metadata```

and METHOD is the method you want to call, for example ```'sendTemplate'```. See the [Mandrill API Documentation](https://mandrillapp.com/api/docs/index.nodejs.html) for the available methods and options.
