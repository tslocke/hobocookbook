Generators -- manual/generators/resource.markdown
{: .document-title}


## Usage

    

    rails generate hobo:resource NAME [field:type field:type] [options]


## Options

    

    [--skip-namespace]  # Skip namespace (affects only isolated applications)
    [--old-style-hash]  # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    [--timestamps]      # Indicates when to generate timestamps


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -s, [--skip]     # Skip files that already exist
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      Create hobo files for resource generator.
