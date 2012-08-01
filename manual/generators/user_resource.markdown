Generators -- manual/generators/user\_resource.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_resource [NAME=user] [options]


## Options

    

        [--old-style-hash]    # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--activation-email]  # Send an email to activate the account
    -i, [--invite-only]       # Add features for an invite only website
        [--skip-namespace]    # Skip namespace (affects only isolated applications)


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      Create hobo files for user_resource generator.
