(defpackage #:hp/ui/layout
  (:use #:cl)
  (:local-nicknames (#:mk #:markup))
  (:export #:layout))
(in-package #:hp/ui/layout)

(markup:enable-reader)

(mk:deftag nav-header ()
  <header class="navbar bg-base-100" >
    <div class="container mx-auto">
      <div class="flex-1" >
        <a href="/" class="btn btn-ghost text-xl">
          skyizwhite.dev
        </a>
      </div>
      <div class="flex-none" >
        <ul class="menu menu-horizontal px-1" >
          <li class="px-2">
            <details>
              <summary>
                Tech
              </summary>
              <ul class="p-2 bg-base-100 rounded-t-none" >
                <li>
                  <a href="https://github.com/skyizwhite" target="_blank" >
                    GitHub
                  </a>
                </li>
                <li>
                  <a href="https://zenn.dev/skyizwhite" target="_blank">
                    Zenn
                  </a>
                </li>
              </ul>
            </details>
          </li>
          <li class="px-2">
            <details>
              <summary>
                Social
              </summary>
              <ul class="p-2 bg-base-100 rounded-t-none" >
                <li>
                  <a href="https://post.skyizwhite.dev/@paku" target="_blank" rel="me" >
                    Fediverse
                  </a>
                </li>
                <li>
                  <a href="https://bsky.app/profile/skyizwhite.dev" target="_blank">
                    Bluesky
                  </a>
                </li>
              </ul>
            </details>
          </li>
        </ul>
      </div>
    </div>
  </header>)

(mk:deftag layout (children)
  <html>
    <head>
      <title>skyizwhite.dev</title>
      <meta name="description" content="pakuの個人サイトです" />
      <script src="/static/htmx.min.js" ></script>
      <link href="/static/main.css" rel="stylesheet" >
      <link href="/static/tailwind.css" rel="stylesheet" >
    </head>
    <body class="flex flex-col h-[100svh]" >
      <nav-header />
      <main class="h-full">,@(progn children)</main>
    </body>
  </html>)
