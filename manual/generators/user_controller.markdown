Generators -- manual/generators/user\_controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_controller [NAME=users] [options]


## Options

    

    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit
        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--helpers]              # Generates helper files
                                 # Default: true
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -i, [--invite-only]          # Add features for an invite only website


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## USAGE

    

      This generator is used by the user_resource generator to generate
      app/controllers/users_controller.rb
