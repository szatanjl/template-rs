Project Template
================

This is a template for software and other types of projects.
Use it as a starting point to quickly set up your own project with
a standardized structure, build process, and development workflow.

To begin:

1. Change `project_name` in Makefile, .dockerignore, and .gitignore
2. Update LICENSE and all mentions of it (`grep LICENSE`)
3. Update contact information and email addresses (`grep @example.com`)
4. Edit this README and replace all `<...>` placeholders
5. Start your project

Note: Project name must only contain ASCII lowercase letters, digits,
periods, and hyphens.  It must start with a letter, must not end with
a period nor hyphen, and must not contain two adjacent periods nor
hyphens.

Regex: `[a-z]([-.]?[0-9a-z]+)*`

Rationale: This is the most portable naming convention that is also
human and machine friendly.

- It is compatible with most character sets and encodings:
  ASCII, Unicode, UTF-8, base64-url
- It is case-insensitive
- It can be used as a filename on most filesystems
  It is compatible with POSIX portable filename character set
- It is URL-safe
- It is compatible with docker image naming convention
- It is compatible with make, shell, markdown, and other programming
  and markup languages.  No spaces, or any special characters which
  could be problematic to handle
- It can be used as an identifier in programming languages.
  May only require changing a hyphen ('-') to an underscore ('\_')


Installation
------------

[Download][releases] pre-compiled binary package.
See [changelog](docs/CHANGELOG.md) for details.

[releases]: https://<URL>/<PKGNAME>/releases


Build and Install from Source
-----------------------------

1. Install build dependencies (these can be removed after build)

   - make

2. Install runtime dependencies

   - sh

3. Download and extract source code

       # packages available also in .tar.zst and .zip formats
       curl -LO https://<URL>/<PKGNAME>/download/<PKGNAME>.src.tar.gz
       tar -xzf <PKGNAME>.src.tar.gz

4. Build and install

       cd <PKGNAME>
       make
       make install


Run Using Docker
----------------

    docker pull <REGISTRY>/<PKGNAME>
    docker run -it --rm <REGISTRY>/<PKGNAME>


Quick Start
-----------

Basic configuration.  Usage examples.

See [documentation](docs/index.md) for details.


Why?
----

Why use this software?  Comparison with other similar projects.


How It Works?
-------------

How does it work?


Development
-----------

1. Install required dependencies

   - sh
   - make
   - git

2. Install optional dependencies

   - docker: Build docker image

3. Clone repository

       git clone --recurse-submodules https://<URL>/<PKGNAME>.git

4. [Configure make](docs/make.md#configuration)

5. Run project in development mode

       make dev

See [documentation](docs/index.md#development) for details.


Questions
---------

Before asking a question, check out [documentation](docs/index.md)
and issues labeled "question".

Cannot find answer you are looking for?
[Submit an issue](docs/CONTRIBUTING.md#issues) or write an email to
<questions@example.com>.


Contributing
------------

Found a security vulnerability?
Read [security policy](docs/SECURITY.md).

Found a bug?  Missing a feature?  Want to help?
Read [contribution guidelines](docs/CONTRIBUTING.md).


License
-------

This project is licensed under the [MIT license](LICENSE).
