Package.describe({
  name: 'mjmasn:mandrill',
  version: '0.2.0',
  summary: 'Mandrill API package',
  git: 'https://github.com/mjmasn/mandrill',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('coffeescript');
  api.addFiles(['conf.coffee','mandrill.coffee'], 'server');
});

Npm.depends({
  'mandrill-api': '1.0.41'
});
