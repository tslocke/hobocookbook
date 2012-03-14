Generators -- manual/generators/controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:controller NAME


## Options

    

        [--skip-namespace]       # Skip namespace (affects only isolated applications)
        [--helpers]              # Generates helper files
                                 # Default: true
        [--old-style-hash]       # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    -t, [--test-framework=NAME]  # Test framework to be invoked
                                 # Default: test_unit


## Runtime options

    

    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    


      Creates a Hobo model controller.   Called from the Hobo `resource` generator.
