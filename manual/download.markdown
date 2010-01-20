Downloading and Installing Hobo
{.document-title}

Before installing Hobo, you must have
[Ruby](http://www.ruby-lang.org/en/),
[RubyGems](http://docs.rubygems.org/) and [Ruby on
Rails](http://rubyonrails.org/) installed.

The standard mechanism for installing Hobo is to use gem:

    gem install hobo

This command will also install the Hobo prerequisites [Hobo
Support](/manual/hobosupport) and [Hobo Fields](/manual/hobofields) as
well as [Mislav's
will_paginate](http://wiki.github.com/mislav/will_paginate/), if you
do not already have them installed.  The two Hobo prerequisites may be
used independently without Hobo, so you may wish to install either or
both of them instead of Hobo.

    gem install hobosupport
    gem install hobofields

If you wish to download the gems directly, you can get them from
[gemcutter](http://gemcutter.org).  There are three gems:
[hobosupport](http://gemcutter.org/gems/hobosupport),
[hobofields](http://gemcutter.org/gems/hobofields) and
[hobo](http://gemcutter.org/gems/hobo)

The source code for Hobo is available on
[github:tablatom/hobo](http://github.com/tablatom/hobo)
