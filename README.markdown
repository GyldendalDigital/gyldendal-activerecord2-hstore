gyldendal-activerecord2-hstore
------------------------------

This is a fork of activerecord2-hstore with a little adjusment to make it usable for Tibet: https://github.com/GyldendalDigital/Tibet.

CHANGES:
The following dependencies are removed:
"activerecord", "~> 2.3.0"
"activesupport", "~> 2.3.0"

BACKROUND:
Tibet already includes both activerecord and activesupport from the vendor/-folder, so the dependencies for activerecord2-hstore are already met.
Unfortunately bundler fails to recognize this and installs both packages, and Tibet ends up with 2 versions of both of them.


