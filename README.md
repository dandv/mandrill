# mjmasn:mandrill

This Meteor package wraps the [`mandrill-api` NPM package](https://www.npmjs.com/package/mandrill-api). As it is a fairly simple wrap of the NPM package, only a few functions were tested ([`messages.send`](https://mandrillapp.com/api/docs/messages.nodejs.html#method=send), [`messages.sendTemplate`](https://mandrillapp.com/api/docs/messages.nodejs.html#method=send-template), and [`templates.render`](https://mandrillapp.com/api/docs/templates.nodejs.html#method=render)) but all functions should all work as expected. If you do discover any issues please open a new issue or submit a PR.

## Installation
This package is available at https://atmospherejs.com/mjmasn/mandrill. To install, use:

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

* [`users`](https://mandrillapp.com/api/docs/users.nodejs.html)
* [`messages`](https://mandrillapp.com/api/docs/messages.nodejs.html)
* [`tags`](https://mandrillapp.com/api/docs/tags.nodejs.html)
* [`rejects`](https://mandrillapp.com/api/docs/rejects.nodejs.html)
* [`whitelists`](https://mandrillapp.com/api/docs/whitelists.nodejs.html)
* [`senders`](https://mandrillapp.com/api/docs/senders.nodejs.html)
* [`urls`](https://mandrillapp.com/api/docs/urls.nodejs.html)
* [`templates`](https://mandrillapp.com/api/docs/templates.nodejs.html)
* [`webhooks`](https://mandrillapp.com/api/docs/webhooks.nodejs.html)
* [`subaccounts`](https://mandrillapp.com/api/docs/subaccounts.nodejs.html)
* [`inbound`](https://mandrillapp.com/api/docs/inbound.nodejs.html)
* [`exports`](https://mandrillapp.com/api/docs/exports.nodejs.html)
* [`ips`](https://mandrillapp.com/api/docs/ips.nodejs.html)
* [`metadata`](https://mandrillapp.com/api/docs/metadata.nodejs.html)

and METHOD is the method you want to call, for example `sendTemplate`. See the [Mandrill API Documentation](https://mandrillapp.com/api/docs/index.nodejs.html) for the available methods and options.

## Examples

### Sending an email based on a template

1. First, define a template in Mandrill (or in MailChimp, which has a better visual editor, and export (save) it to Mandrill).
2. In your template, add `mc:edit="somenamehere"` attributes to HTML elements whose content you want replaced. For example:

        <span class="fancy" mc:edit="referrallink">http://domain.com/?ref=</span>

    Note that despite the [example in Mandrill's API](https://mandrill.zendesk.com/hc/en-us/articles/205582497-How-do-I-add-dynamic-content-using-editable-regions-in-my-template-), MailChimp [silently strips dashes in the attribute value and lowercases everything](http://imgur.com/64zYbDG) on save, so best to stick with all-lowercase.

3. Call Mandrill like this:

    ```js
    var result;
    try {
      result = Mandrill.messages('sendTemplate', {
        template_name: 'the-slug-of-your-template',
        template_content: [
          {
            name: 'referrallink',  // no dashes because MailChimp silently strips them
            content: 'https://yourdomain.com/?ref=' + someCodeYouCalculateHere
          }
        ],
        message: {
          from_email: 'support@yourdomain.com',
          from_name: 'Your App',
          subject: 'Welcome to Your App!',
          to: [
            {
              email: 'user@email.com'
            }
          ],
          track_opens: true,
          track_clicks: true,
          auto_text: true
        },
        async: true
      });
    }
    catch (err) {
      console.error(err);
    }
    console.log(result);
    ```

### Rendering a template to HTML for integrating with Meteor's Accounts functionality

You can easily customize Meteor's outgoing emails to send Mandrill templates, using [templates.render](https://mandrillapp.com/api/docs/templates.nodejs.html#method=render). Simply set `Accounts.emailTemplates.enrollAccount.html` (or `Accounts.emailTemplate.resetPassword.html` or `.verifyEmail.html`) to the result of the `render` call, passing the template name and parameters:

```js
Accounts.emailTemplates.enrollAccount.html = function (user, url) {
  console.log('Enrolling', user);
  var referralCode = ... // generate a secret
  var result;
  try {
    result = Mandrill.templates('render', {
      template_name: 'the-slug-of-your-template',
      template_content: [
        {
          name: 'referrallink',
          content: 'https://yourdomain.com/?ref=' + referralCode
        }
      ]
    });
  } catch (error) {
    console.error('Error while rendering Mandrill template', error);
  }
  return result.html;
}
```

Then you let Meteor do its email sending magic by configuring MAIL_URL to point to your Mandrill account:

    export MAIL_URL=smtp://you@yourdomain.com:password@smtp.mandrillapp.com:465

To automatically generate text from the HTML, [set the `X-MC-AutoText` header to `1`](https://mandrill.zendesk.com/hc/en-us/articles/205582117-Using-SMTP-Headers-to-customize-your-messages#automatically-generate-plain-text-from-html-content):


```js
Accounts.emailTemplates.headers = {
  'X-MC-AutoText': true
};
```
