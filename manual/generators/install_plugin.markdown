Generators -- manual/generators/install\_plugin.markdown
{: .document-title}


## Usage

    

    rails generate hobo:install_plugin NAME [GIT_PATH] [options]


## Options

    

        [--comments=COMMENTS]  # comments to add before require/include
    -J, [--skip-js]            # don't add require to application.js
    -v, [--version=VERSION]    # Gemspec version string
    -C, [--skip-css]           # doesn't add require to application.css
        [--css-top]            # add the require statement to the top of the CSS file rather tahn the bottom.
        [--skip-namespace]     # Skip namespace (affects only isolated applications)
        [--old-style-hash]     # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -e, [--subsite=SUBSITE]    # Subsite name (without '_site') or 'all' or 'application'
                               # Default: application
    -M, [--skip-gem]           # don't add plugin to Gemfile


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -s, [--skip]     # Skip files that already exist
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist

This generator installs a hobo plugin.

The first argument is the name of the plugin, and the second is where
to get it.  If the second argument is not supplied, it is installed
from rubygems.org or any other gem source listed in your Gemfile.  If
the second argument contains a colon (:), it is assumed to be a git
URL.  Otherwise it is considered to be a path.

If you are installing a Hobo theme, you probably want to use the options
`--subsite=front --css-top`.
