Generators -- manual/generators/user\_controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_controller [NAME=users] [options]


## Options

    

        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--helpers]              # Generates helper files
                                 # Default: true
    -i, [--invite-only]          # Add features for an invite only website
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit
        [--skip-namespace]       # Skip namespace (affects only isolated applications)


## Runtime options

    

    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes


## USAGE

    

      This generator is used by the user_resource generator to generate
      app/controllers/users_controller.rb
