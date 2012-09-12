Generators -- manual/generators/controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:controller NAME


## Options

    

        [--helpers]              # Generates helper files
                                 # Default: true
        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Suppress status output


## Description

    


      Creates a Hobo model controller.   Called from the Hobo `resource` generator.
