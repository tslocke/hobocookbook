Generators -- manual/generators/resource.markdown
{: .document-title}


## Usage

    

    rails generate hobo:resource NAME [field:type field:type] [options]


## Options

    

    [--old-style-hash]  # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
    [--timestamps]      # Indicates when to generate timestamps
    [--skip-namespace]  # Skip namespace (affects only isolated applications)


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      Create hobo files for resource generator.
