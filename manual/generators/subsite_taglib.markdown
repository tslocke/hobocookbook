Generators -- manual/generators/subsite\_taglib.markdown
{: .document-title}


## Usage

    

    rails generate hobo:subsite_taglib NAME [options]


## Options

    

    -i, [--invite-only]                            # Add features for an invite only website
        [--skip-namespace]                         # Skip namespace (affects only isolated applications)
        [--old-style-hash]                         # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                   # Default: user


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      This generator is used to generate
      app/views/taglibs/<subsite_name>_site.dryml, and is used by the
      subsite and admin_site generators.  Do not use directly.
