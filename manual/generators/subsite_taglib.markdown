Generators -- manual/generators/subsite\_taglib.markdown
{: .document-title}


## Usage

    

    rails generate hobo:subsite_taglib NAME [options]


## Options

    

        [--skip-namespace]                         # Skip namespace (affects only isolated applications)
        [--old-style-hash]                         # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                   # Default: user
    -i, [--invite-only]                            # Add features for an invite only website


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -s, [--skip]     # Skip files that already exist
    -q, [--quiet]    # Supress status output
    -f, [--force]    # Overwrite files that already exist


## Description

    

      This generator is used to generate
      app/views/taglibs/<subsite_name>_site.dryml, and is used by the
      subsite and admin_site generators.  Do not use directly.
