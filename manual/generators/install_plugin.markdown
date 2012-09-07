Generators -- manual/generators/install\_plugin.markdown
{: .document-title}


## Usage

    

    rails generate hobo:install_plugin NAME [GIT_PATH] [options]


## Options

    

    -v, [--version=VERSION]    # Gemspec version string
    -C, [--skip-css]           # doesn't add require to [subsite].css
    -e, [--subsite=SUBSITE]    # Subsite name (without '_site') or 'all'
                               # Default: all
        [--skip-dryml]         # doesn't add include to [subsite]_site.dryml
        [--comments=COMMENTS]  # comments to add before require/include
        [--skip-namespace]     # Skip namespace (affects only isolated applications)
    -M, [--skip-gem]           # don't add plugin to Gemfile
        [--old-style-hash]     # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -J, [--skip-js]            # don't add require to [subsite].js


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes

This generator installs a hobo plugin.

The first argument is the name of the plugin, and the second is where
to get it.  If the second argument is not supplied, it is installed
from rubygems.org or any other gem source listed in your Gemfile.  If
the second argument contains a colon (:), it is assumed to be a git
URL.  Otherwise it is considered to be a path.
