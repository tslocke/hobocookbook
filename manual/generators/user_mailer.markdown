Generators -- manual/generators/user\_mailer.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_mailer [NAME=user] [options]


## Options

    

    -i, [--invite-only]          # Add features for an invite only website
        [--activation-email]     # Send an email to activate the account
        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit


## Runtime options

    

    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      This generator is used by the user_resource generator to generate user_mailer.rb.
