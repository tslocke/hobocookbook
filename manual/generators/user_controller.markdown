Generators -- manual/generators/user\_controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_controller [NAME=users] [options]


## Options

    

        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit
        [--helpers]              # Generates helper files
                                 # Default: true
    -i, [--invite-only]          # Add features for an invite only website


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -s, [--skip]     # Skip files that already exist
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## USAGE

    

      This generator is used by the user_resource generator to generate
      app/controllers/users_controller.rb
