/* global mocha, sinon, before, after, require, console */

(function() {
  'use strict';

  require.config({
    baseUrl: 'scripts',
    paths: {
      spec: '../../spec',
      templates: '../templates',
      jquery: '../components/jquery/jquery',
      underscore: '../components/underscore/underscore',
      bootstrap: 'vendor/bootstrap',
      backbone: '../components/backbone/backbone',
      layoutmanager: '../components/layoutmanager/backbone.layoutmanager',
      associations: '../components/backbone-associations/backbone-associations',
      text: '../components/requirejs-plugins/lib/text',
      json: '../components/requirejs-plugins/src/json',
      handlebars: '../components/handlebars/handlebars'
    },
    shim: {
      bootstrap: ['jquery'],
      backbone: {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      associations: {
        deps: ['backbone']
      },
      underscore: {
        exports: '_'
      },
      layoutmanager: {
        deps: ['backbone']
      },
      handlebars: {
        exports: 'Handlebars'
      }
    }
  });

  // for our components to be testable, we need to load their non-AMD dependencies before instantiating them
  require(['backbone', 'layoutmanager', 'handlebars', 'bootstrap'], function() {
    var app = {};
    app.templates = {};

    Backbone.Layout.configure({
      manage: true,
      prefix: 'templates/',
      fetch: function(path) {
        var lmdone;
        path += '.hbs';
        if (app.templates.hasOwnProperty('path') && typeof app.templates[path] !== 'undefined') {
          return app.templates[path];
        }
        lmdone = this.async();
        return require(['text!' + path], function(template) {
          return lmdone(app.templates[path] = Handlebars.compile(template));
        });
      }
    });

    before(function() {
      this.server = sinon.fakeServer.create();
      this.server.xhr.useFilters = true;
      this.server.xhr.addFilter(function(method, url) {
        var faked = ![
          '/templates/',
          'config.json'
        ]
          .map(function(pattern) {
            return new RegExp(pattern);
          })
          .some(function(pattern) {
            return pattern.test(url);
          });
        // these diagnostic messages clutter up the test results for headless tests
        console.log('filtering XHR for url:', url, 'it will ' + (faked ? 'be faked' : 'not be faked'));
        return !faked;
      });

      // https://github.com/ariya/phantomjs/issues/10522
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind
      // PhantomJS does not support Function.prototype.bind yet, so we have to resort to a polyfill
      this.olfFnBind = Function.prototype.bind;
      if (!Function.prototype.bind) {
        Function.prototype.bind = function(oThis) {
          if (typeof this !== 'function') {
            // closest thing possible to the ECMAScript 5 internal IsCallable function
            throw new TypeError('Function.prototype.bind - what is trying to be bound is not callable');
          }

          var aArgs = Array.prototype.slice.call(arguments, 1);
          var fToBind = this;
          var F = function() {};
          var fBound = function() {
            return fToBind.apply(
              this instanceof F && oThis ? this : oThis,
              aArgs.concat(Array.prototype.slice.call(arguments))
            );
          };

          F.prototype = this.prototype;
          fBound.prototype = new F();

          return fBound;
        };
      }
    });

    after(function() {
      this.server.restore();
      Function.prototype.bind = this.oldFnBind;
      delete this.oldFnBind;
    });

    require([/* Require tests here */], function() {
      mocha.run();
    });
  });

}());
