# Real World Elm

This code accompanies a series of blog posts called "Real World Elm" on [TruQu's engineering blog](http://engineering.truqu.com/).

Prerequisites:

- Erlang/OTP 18.0, Erlang Solutions provides [packages](https://www.erlang-solutions.com/downloads/download-erlang-otp)
- Node.js
- npm

To build everything:

    $ npm install && make deps app rel elm

To start the back-end:

    $ ./_rel/blog_code/bin/blog_code start

Vist [http://localhost:9999/](http://localhost:9999/) to see the code running.
