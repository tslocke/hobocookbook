Generators -- manual/generators/resource.markdown
{: .document-title}


## Usage

    

    rails generate hobo:resource NAME [field:type field:type] [options]


## Options

    

    [--timestamps]      # Indicates when to generate timestamps
    [--skip-namespace]  # Skip namespace (affects only isolated applications)
    [--old-style-hash]  # Force using old style hash (:foo => 'bar') on Ruby >= 1.9


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      Create hobo files for resource generator.
