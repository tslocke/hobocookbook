Generators -- manual/generators/user\_resource.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_resource [NAME=user] [options]


## Options

    

        [--skip-namespace]    # Skip namespace (affects only isolated applications)
    -i, [--invite-only]       # Add features for an invite only website
        [--old-style-hash]    # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--activation-email]  # Send an email to activate the account


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      Create hobo files for user_resource generator.
