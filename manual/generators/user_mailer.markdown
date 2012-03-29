Generators -- manual/generators/user\_mailer.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_mailer [NAME=user] [options]


## Options

    

        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit
    -i, [--invite-only]          # Add features for an invite only website
        [--activation-email]     # Send an email to activate the account


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -s, [--skip]     # Skip files that already exist
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      This generator is used by the user_resource generator to generate user_mailer.rb.
